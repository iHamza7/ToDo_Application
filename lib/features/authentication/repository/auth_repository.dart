import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/helpers/db_helper.dart';
import '../../../common/routes/routes.dart';
import '../../../common/widgets/dialogue_bix.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(firebaseAuth: FirebaseAuth.instance);
});

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  AuthRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  void verifyOtp({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);
      await _firebaseAuth.signInWithCredential(credential);
      if (!mounted) {
        return;
      }
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    } on FirebaseAuth catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void sendOtp({
    required BuildContext context,
    required String phone,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _firebaseAuth.signInWithCredential(credential);
          },
          verificationFailed: (failed) {
            showAlertDialog(context: context, message: failed.toString());
          },
          codeSent: (smsCodeId, resendCodeId) {
            DbHelper.createUser(1);
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.otp, (route) => false,
                arguments: {
                  'phone': phone,
                  'smsCodeId': smsCodeId,
                });
          },
          codeAutoRetrievalTimeout: (String smsCodeId) {});
    } on FirebaseException catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
