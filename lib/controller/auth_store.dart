import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

enum StoreState { login, signup }

abstract class AuthStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthStoreBase();

  @observable
  String? _contactNumber;

  @computed
  StoreState get state {
    if (_contactNumber != null) {
      return StoreState.signup;
    } else {
      return StoreState.login;
    }
  }

  @action
  Future<String?> login(String contact) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: contact,
        verificationCompleted: (PhoneAuthCredential credential) {
          if (kDebugMode) {
            print(credential.smsCode);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (kDebugMode) {
            print(e.toString());
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          _contactNumber = contact;
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
  void goBack() {
    _contactNumber = null;
  }
}
