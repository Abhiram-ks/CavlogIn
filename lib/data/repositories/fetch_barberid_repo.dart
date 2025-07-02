import 'dart:developer';

import 'package:admin/data/models/barbermodel.dart';
import 'package:admin/domain/useCase/rating_service_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FetchBarberidRepository {
  Stream<BarberModel> streamBarber({required String barberID});
}

class FetchBarberidRepositoryImpl implements FetchBarberidRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RatingServiceUsecase _ratingService = RatingServiceUsecase();
  


  @override
  Stream<BarberModel> streamBarber({required String barberID}) {
    return _firestore
       .collection('barbers')
       .doc(barberID)
       .snapshots()
       .asyncMap((snapshot) async {
        if (snapshot.exists) {
          try {
            final rating = await _ratingService.fetchAverageRating(barberID);
          
            return BarberModel.fromMap(snapshot.id, rating, snapshot.data() as Map<String, dynamic>);
          } catch (e) {
            log("Error with raing fetch: $e");
            rethrow;
          }
        } else {
          throw Exception('Barber not found');
        }
       }).handleError((error) {
         log('Error fetching barber data: $error');
       });
  }
}