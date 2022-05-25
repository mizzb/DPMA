import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

enum StoreState { login, otp }

abstract class AuthStoreBase with Store {
   final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthStoreBase();

  @observable
  String? _contactNumber;

  String? _verificationId;

  @computed
  StoreState get state {
    if (_contactNumber != null) {
      return StoreState.otp;
    } else {
      return StoreState.login;
    }
  }

  @action
  Future<String?> login(String contact, BuildContext context) async {
    try {

      await _auth.verifyPhoneNumber(
        phoneNumber: contact,
        verificationCompleted: (PhoneAuthCredential credential) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter valid number")));
          if (kDebugMode) {
            print(credential.smsCode);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (kDebugMode) {
            print(e.toString());
          }
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Verification failed")));
          if (kDebugMode) {
            print(e.toString());
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          if (_verificationId != null) {
            _contactNumber = contact;
          } else {
            if (kDebugMode) {
              print("Verification id failed");
            }
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (kDebugMode) {
            print(verificationId);
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return _contactNumber;
  }

  @action
  Future<bool> verifyOtp(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    try {
      UserCredential _resp = await _auth.signInWithCredential(credential);
      if (kDebugMode) {
        print(_resp);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  @action
  Future<void> logout() async {
    _contactNumber = null;
    _verificationId = null;
    return await _auth.signOut();
  }

  @action
  void goBack() {
    _contactNumber = null;
  }
}
