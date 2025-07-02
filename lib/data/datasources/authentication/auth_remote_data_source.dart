import 'dart:convert';
import 'dart:developer';

import 'package:admin/core/utils/const/constent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

class AuthRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  String hashPassword(String password){
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> storeAdminCredentials()async{
     try {
      String adminEmail = EnvConstants.adminEmail;
      String adminPassword = EnvConstants.adminPassword;

       String hashedPassword  = hashPassword(adminPassword);

       await _firestore.collection('admin').doc('credentials').set({
        'email': adminEmail,
        'password': hashedPassword,
       });

     } catch (e) {
       log('$e from Admin credentials');
     }
  }
}