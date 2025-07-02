import 'package:cloud_firestore/cloud_firestore.dart';

class WalletModel {
  final double lifeTimeAmount;
  final Timestamp updatedAt;


  WalletModel({
    required this.lifeTimeAmount,
    required this.updatedAt
  });


  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      lifeTimeAmount: (map['lifetime_amount'] ?? 0).toDouble(),
      updatedAt: map['updated'] ?? Timestamp.now());
  }
}