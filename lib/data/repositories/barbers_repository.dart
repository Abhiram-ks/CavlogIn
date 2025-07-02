
import 'package:admin/data/models/barber_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



abstract class FetchBarberRepository {
  Stream<List<Barber>> getAllBarber();
}


class FetchBarberRepositoryImpl implements FetchBarberRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Barber>> getAllBarber() {
    return _firestore
        .collection('barbers')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .asyncMap((querySnapshot) async {
          final barbers = querySnapshot.docs.map((doc) {
            return Barber.fromFirestore(doc.data());
          }).toList();
          return barbers;
        });
  }
}
