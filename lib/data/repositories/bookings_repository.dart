import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passkey/data/repository.dart';
import 'package:passkey/domain/models/bookings/booking_model.dart';

class BookingRepository extends Repository<BookingModel> {
  final CollectionReference _collection = Repository.db.collection('bookings');

  String generateId() {
    return _collection.doc().id;
  }

  Future<List<BookingModel>> fetchBookings(String buildingId) async {
    final querySnapshot =
        await _collection.where('buildingId', isEqualTo: buildingId).get();
    return querySnapshot.docs
        .map((doc) => BookingModel.fromFirestore(doc))
        .toList();
  }

  Future<List<BookingModel>> fetchUserBookings(String userId) async {
    final querySnapshot =
        await _collection.where('userId', isEqualTo: userId).get();

    return querySnapshot.docs
        .map((doc) => BookingModel.fromFirestore(doc))
        .toList();
  }

  Future<BookingModel?> getBookingById(String id) async {
    final docSnapshot = await _collection.doc(id).get();
    if (docSnapshot.exists) {
      return BookingModel.fromFirestore(docSnapshot);
    }
    return null;
  }

  Future<void> addBooking(BookingModel booking) async {
    await _collection.doc(booking.id).set(booking.toFirestore());
  }

  Future<void> updateBooking(BookingModel booking) async {
    await _collection.doc(booking.id).update(booking.toFirestore());
  }

  Future<void> deleteBooking(String id) async {
    await _collection.doc(id).delete();
  }
}
