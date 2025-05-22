import { Request } from "firebase-functions/v2/https";
import Stripe from "stripe";
import { PaymentRepository } from "../data/payment_repository";
import { BookingRepository } from "../data/bookings_repository";
import { BookingStatus } from "../model/booking";
import { fromStripeStatus, PaymentStatus } from "../model/payment";
import { endpointSecret } from "../stripe";

export const stripeWebhooksHandler = async (
  request: Request,
  response: any
) => {
  const sig = request.headers["stripe-signature"];

  let event: Stripe.Event;

  try {
    event = Stripe.webhooks.constructEvent(
      request.rawBody,
      sig as string,
      endpointSecret()
    );
  } catch (err: any) {
    console.log("Invalid stripe signature");
    return response.status(400).send(`Webhook Error: ${err.message}`);
  }
  if (!event) {
    console.log("Can not be constructed");
    return response.json({ received: false });
  }

  if (
    !event.type.startsWith("payment_intent") ||
    !event.type.startsWith("charge.refunded")
  ) {
    console.log(`${event.type} not managed`);
    return response.json({ received: true });
  }

  const object = event.data.object as {
    id: string;
    status: Stripe.PaymentIntent.Status;
  };

  console.log("New webhook received for payment intent", object.id);
  console.log("Webhook type", event.type);
  const payment = await PaymentRepository.getPayment(object.id);
  if (!payment) {
    console.log(`Payment with ID ${object.id} does not exist`);
    return;
  }
  if (event.type === "charge.refunded") {
    await PaymentRepository.updateStatus(payment.id, PaymentStatus.refunded);
  } else {
    await PaymentRepository.updateStatus(
      payment.id,
      fromStripeStatus(object.status)
    );
    if (event.type === "payment_intent.succeeded") {
      await BookingRepository.updateStatus(
        payment.bookingId,
        BookingStatus.confirmed
      );
    } else if (
      ["payment_intent.canceled", "payment_intent.payment_failed"].includes(
        event.type
      )
    ) {
      await BookingRepository.updateStatus(
        payment.bookingId,
        BookingStatus.cancelled
      );
    }
  }

  return response.json({ received: true });
};
