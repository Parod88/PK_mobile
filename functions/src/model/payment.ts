import Stripe from "stripe";

export interface Payment {
  id: string;
  amount: number;
  currency: string;
  status: PaymentStatus;
  bookingId: string;
  userId: string;
}

export enum PaymentStatus {
  canceled = "canceled",
  processing = "processing",
  requires_action = "requires_action",
  requires_capture = "requires_capture",
  requires_confirmation = "requires_confirmation",
  requires_payment_method = "requires_payment_method",
  succeeded = "succeeded",
  refunded = "refunded",
}

export const fromStripeStatus = (stripeStatus: Stripe.PaymentIntent.Status) => {
  return PaymentStatus[`${stripeStatus}`];
};
