import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class Authentication {
  final _firebase = FirebaseAuth.instance;

  Future<bool> signWithPhone(String verificationUID, String codSMS) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationUID,
      smsCode: codSMS,
    );

    final FirebaseUser loginResult = (await _firebase.signInWithCredential(credential)).user;

    if (loginResult?.uid != null) {
      return true;
    } else {
      return false;
    }
  }

  Future verifyPhoneNumber(String numberCellPhone) async {
    
     final PhoneCodeSent codeSent =
        (String verified, [int forceResendingToken]) async {
          print("Verificado com Sucesso.");
          print(verified);
        };
      
      final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
          print("Ocorreu um erro");
      };
      
      final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
          var signInWithCredential = _firebase.signInWithCredential(phoneAuthCredential);
          print(phoneAuthCredential.hashCode);
      };

      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String timeout) {
          print(timeout);
      };

      await _firebase.verifyPhoneNumber(
        phoneNumber: numberCellPhone,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      
    /*await _firebase.verifyPhoneNumber(
      phoneNumber: numberCellPhone,
      codeSent: (String verified, [int forceResend]) {
        print("Verificado com sucesso");
        print(verified);
      },
      verificationFailed: (AuthException authenticationException) {
        print("Ocorreu um erro");
      },
      verificationCompleted: (FirebaseUser user) {
        print(user?.uid);
      },

      codeAutoRetrievalTimeout: (String timeout) {
        print(timeout);
      },
       timeout: Duration(seconds: 30), 
    );*/



  
  }


}
