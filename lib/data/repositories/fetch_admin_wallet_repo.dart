import 'package:admin/data/models/wallet_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FetchAdminWalletRepository {
  Stream<WalletModel> fetchWalletData();
}

class FetchAdminWalletRepositoryImpl implements FetchAdminWalletRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 @override
 Stream<WalletModel> fetchWalletData() {
  try {
    final docRef = _firestore.collection('platform_free').doc('wallet');

    return docRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        return WalletModel.fromMap(snapshot.data()!);
      }else {
        throw Exception('Wallet data not found');
      }
    });
  } catch (e) {
     return Stream.error('Failed to fetch wallet data: $e');
  }
 }
}