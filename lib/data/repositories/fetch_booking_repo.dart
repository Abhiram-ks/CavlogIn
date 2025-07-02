import 'package:admin/data/models/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FetchBookingRepository {
  Stream<List<BookingModel>> stramBookings();
  Stream<List<BookingModel>> streamBookingsFilter({required String status});
  Stream<List<BookingModel>> streamBookingspaymentMethod({required String status});
}


class FetchBookingRepositoryImpl implements FetchBookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Stream<List<BookingModel>> stramBookings(){
    final bookingQuary = _firestore
        .collection('bookings')
        .orderBy('createdAt', descending: true);

    return bookingQuary.snapshots().map((snapshot) {
      try {
        final bookings = snapshot.docs.map((doc){
          final booking = BookingModel.fromMap(doc.id, doc.data());
          return booking;
        }).toList();

        return bookings;
      } catch (e) {
        return <BookingModel> [];
      }
    });
  }


    @override
  Stream<List<BookingModel>> streamBookingsFilter({required String status}){
    final bookingQuary = _firestore
        .collection('bookings')
        .where('service_status', isEqualTo: status)
        .orderBy('createdAt', descending: true);

    return bookingQuary.snapshots().map((snapshot) {
      try {
        final bookings = snapshot.docs.map((doc){
          final booking = BookingModel.fromMap(doc.id, doc.data());
          return booking;
        }).toList();

        return bookings;
      } catch (e) {

        return <BookingModel> [];
      }
    });
  }



  
    @override
   Stream<List<BookingModel>> streamBookingspaymentMethod({required String status}){
    final bookingQuary = _firestore
        .collection('bookings')
        .where('paymentMethod', isEqualTo: status)
        .orderBy('createdAt', descending: true);

    return bookingQuary.snapshots().map((snapshot) {
      try {
        final bookings = snapshot.docs.map((doc){
          final booking = BookingModel.fromMap(doc.id, doc.data());
          return booking;
        }).toList();

        return bookings;
      } catch (e) {

        return <BookingModel> [];
      }
    });
  }
}