import {
  collection,
  doc,
  getDoc,
  getDocs,
  query,
  setDoc,
  updateDoc,
  where,
} from "firebase/firestore";
import { firestore } from "./db";
import { Payment, PaymentStatus } from "../model/payment";

export class PaymentRepository {
  private static _collection = collection(firestore, "payments");
  static savePayment = async (payment: Payment) => {
    await setDoc(doc(PaymentRepository._collection, payment.id), payment);
  };

  static getPayment = async (id: string): Promise<Payment | undefined> => {
    const result = await getDoc(doc(PaymentRepository._collection, id));
    if (result.exists()) return result.data() as Payment;
    return undefined;
  };

  static queryByBookingId = async (
    bookingId: string
  ): Promise<Payment | undefined> => {
    const q = query(
      PaymentRepository._collection,
      where("bookingId", "==", bookingId)
    );
    const querySnapshot = await getDocs(q);
    if (querySnapshot.empty) return undefined;
    return querySnapshot.docs[0].data() as Payment;
  };

  static updateStatus = async (id: string, status: PaymentStatus) => {
    await updateDoc(doc(PaymentRepository._collection, id), {
      status,
    });
  };
}
