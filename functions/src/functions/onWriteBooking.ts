import { DocumentSnapshot } from "firebase-admin/firestore";
import { Change, FirestoreEvent } from "firebase-functions/v2/firestore";
import { Booking, BookingStatus } from "../model/booking";
import { PaymentRepository } from "../data/payment_repository";
import { stripeFactory } from "../stripe";

export const onWriteBookingHandler = async (
  snapshot: FirestoreEvent<
    Change<DocumentSnapshot> | undefined,
    {
      id: string;
    }
  >
) => {
  if (!snapshot) {
    return;
  }
  const before = snapshot.data?.before.data() as Booking | undefined;
  const after = snapshot.data?.after.data() as Booking | undefined;

  if (!before || !after) return;
  const payment = await PaymentRepository.queryByBookingId(after.id);
  if (payment == null) return;

  if (
    before.status !== BookingStatus.cancelled &&
    after.status === BookingStatus.cancelled
  ) {
    await stripeFactory().refunds.create({ payment_intent: payment.id });
  }
};
