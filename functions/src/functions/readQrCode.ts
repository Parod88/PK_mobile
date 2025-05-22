import { Request } from "firebase-functions/v2/https";
import { BookingRepository } from "../data/bookings_repository";
import { isDateWithinRange, sameDay } from "../utils/dates";

export const readQrCode = async (request: Request, response: any) => {
  const { userId, bookingId } = request.query;
  if (!bookingId) return response.status(400).send("Booking ID required");
  if (!userId) return response.status(400).send("User ID required");

  const booking = await BookingRepository.getBooking(bookingId as string);
  if (!booking) return response.status(404).send("Booking ID not found");

  const dates = booking.dates.map((date) => new Date(date));
  const now = new Date();

  const todaysBooking = dates.filter((date) => sameDay(date, now))[0];
  if (!todaysBooking)
    return response.status(401).send("Booking is not for today");

  const isDateWithinRangeResult = isDateWithinRange(
    todaysBooking,
    booking.bookingTime
  );
  if (!isDateWithinRangeResult)
    return response.status(401).send("Booking is outside booking time range");

  if (booking.howManyPeopleHaveAccessed >= booking.peopleNumber)
    return response.status(401).send("Max capacity reached");

  await BookingRepository.updateHowManyPeopleHaveAccessed(
    booking.id,
    booking.howManyPeopleHaveAccessed
      ? booking.howManyPeopleHaveAccessed + 1
      : 1
  );

  return response.status(200).send("ok");
};
