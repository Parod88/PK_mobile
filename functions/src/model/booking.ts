export enum BookingStatus {
  pending = "pending",
  confirmed = "confirmed",
  cancelled = "cancelled",
  resolved = "resolved",
}

export interface Booking {
  id: string;
  status: BookingStatus;
  user: { id: string };
  building: { id: string };
  dates: number[];
  peopleNumber: number;
  howManyPeopleHaveAccessed: number;
  bookingTime: { start: string; end: string };
}
