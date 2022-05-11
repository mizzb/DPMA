// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on AuthStoreBase, Store {
  Computed<StoreState>? _$stateComputed;

  @override
  StoreState get state => (_$stateComputed ??=
          Computed<StoreState>(() => super.state, name: 'AuthStoreBase.state'))
      .value;

  late final _$_contactNumberAtom =
      Atom(name: 'AuthStoreBase._contactNumber', context: context);

  @override
  String? get _contactNumber {
    _$_contactNumberAtom.reportRead();
    return super._contactNumber;
  }

  @override
  set _contactNumber(String? value) {
    _$_contactNumberAtom.reportWrite(value, super._contactNumber, () {
      super._contactNumber = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('AuthStoreBase.login', context: context);

  @override
  Future<String?> login(String contact, BuildContext context) {
    return _$loginAsyncAction.run(() => super.login(contact, context));
  }

  late final _$verifyOtpAsyncAction =
      AsyncAction('AuthStoreBase.verifyOtp', context: context);

  @override
  Future<bool> verifyOtp(String otp) {
    return _$verifyOtpAsyncAction.run(() => super.verifyOtp(otp));
  }

  late final _$logoutAsyncAction =
      AsyncAction('AuthStoreBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$AuthStoreBaseActionController =
      ActionController(name: 'AuthStoreBase', context: context);

  @override
  void goBack() {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
        name: 'AuthStoreBase.goBack');
    try {
      return super.goBack();
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
