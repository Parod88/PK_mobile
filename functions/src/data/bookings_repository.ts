import { collection, doc, getDoc, updateDoc } from "firebase/firestore";
import { firestore } from "./db";
import { Booking, BookingStatus } from "../model/booking";

export class BookingRepository {
  private static _collection = collection(firestore, "bookings");
  static getBooking = async (id: string): Promise<Booking | undefined> => {
    const result = await getDoc(doc(BookingRepository._collection, id));
    if (result.exists()) return result.data() as Booking;
    return undefined;
  };

  static updateStatus = async (id: string, status: BookingStatus) => {
    await updateDoc(doc(BookingRepository._collection, id), {
      status,
    });
  };

  static updateHowManyPeopleHaveAccessed = async (
    id: string,
    newHowManyPeopleHaveAccessed: number
  ) => {
    await updateDoc(doc(BookingRepository._collection, id), {
      howManyPeopleHaveAccessed: newHowManyPeopleHaveAccessed,
    });
  };

  static setPaymentId = async (bookingId: string, paymentId: string) => {
    await updateDoc(doc(BookingRepository._collection, bookingId), {
      payment: doc(BookingRepository._collection, paymentId),
    });
  };
}
