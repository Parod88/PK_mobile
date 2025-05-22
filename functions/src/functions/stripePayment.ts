import { Request } from "firebase-functions/v2/https";
import { isNumber } from "../utils/validate";
import { UserRepository } from "../data/user_repository";
import { PaymentRepository } from "../data/payment_repository";
import { BookingRepository } from "../data/bookings_repository";
import { stripeFactory } from "../stripe";
import { fromStripeStatus } from "../model/payment";

export const stripePaymentHandler = async (request: Request, response: any) => {
  const { email, amount, bookingId } = request.body;

  console.log("Processing payment methods for", email);
  if (!isNumber(Number(amount)))
    return response.status(400).send("Invalid amount");
  if (!bookingId) return response.status(400).send("Booking ID required");

  const user = await UserRepository.getUser(email);
  if (!user) {
    console.log("User has not signed up");
    return response.status(400).send("User is not signed up");
  }

  const stripe = stripeFactory();

  const customer = await (user.stripeCustomerId
    ? stripe.customers.retrieve(user.stripeCustomerId)
    : stripe.customers.create({
        email,
      }));

  console.log("User stripe id:", customer.id);
  const ephemeralKey = await stripe.ephemeralKeys.create(
    {
      customer: customer.id,
    },
    { apiVersion: "2024-10-28.acacia" }
  );

  const paymentIntent = await stripe.paymentIntents.create({
    customer: customer.id,
    amount: Number(amount),
    currency: "EUR",
    capture_method: "automatic",
    automatic_payment_methods: {
      enabled: true,
    },
  });

  if (!user.stripeCustomerId) {
    console.log("User updated with stripe ID");
    await UserRepository.saveStripeId(user, customer.id);
  }

  await PaymentRepository.savePayment({
    id: paymentIntent.id,
    amount: Number(amount) / 100,
    currency: "EUR",
    status: fromStripeStatus(paymentIntent.status),
    bookingId,
    userId: user.id,
  });

  await BookingRepository.setPaymentId(bookingId, paymentIntent.id);

  return response.json({
    paymentIntent: paymentIntent.client_secret,
    ephemeralKey: ephemeralKey.secret,
    customer: customer.id,
  });
};
