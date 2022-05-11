import 'package:dpma/controller/auth_store.dart';
import 'package:dpma/injector.dart';
import 'package:dpma/view/home_screen.dart';
import 'package:dpma/view/widgets/auth_button.dart';
import 'package:dpma/view/widgets/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart' as _constants;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthStore _authStore = locator.get<AuthStore>();
  final TextEditingController _loginCtrl = TextEditingController();

  final TextEditingController _otp1 = TextEditingController();
  final TextEditingController _otp2 = TextEditingController();
  final TextEditingController _otp3 = TextEditingController();
  final TextEditingController _otp4 = TextEditingController();
  final TextEditingController _otp5 = TextEditingController();
  final TextEditingController _otp6 = TextEditingController();

  final FocusNode _field1 = FocusNode();
  final FocusNode _field2 = FocusNode();
  final FocusNode _field3 = FocusNode();
  final FocusNode _field4 = FocusNode();
  final FocusNode _field5 = FocusNode();
  final FocusNode _field6 = FocusNode();

  String? _contactNo;
  bool _agree = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _field1.dispose();
    _field2.dispose();
    _field3.dispose();
    _field4.dispose();
    super.dispose();
  }

  void nextField({String? value, FocusNode? focus}) {
    if (value!.length == 1) {
      focus!.requestFocus();
    }
  }

  Widget field({FocusNode? focus,
    FocusNode? next,
    bool autofocus = false,
    required TextEditingController ctrl}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5)),
      width: 10.w,
      child: TextFormField(
          controller: ctrl,
          autofocus: autofocus,
          focusNode: focus,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: GoogleFonts.robotoCondensed(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: _constants.colorAccent),
          onChanged: (e) {
            next != null ? nextField(value: e, focus: next) : null;
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _constants.primaryColorDark,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Center(child: Observer(
            builder: (BuildContext _) {
              switch (_authStore.state) {
                case StoreState.login:
                  return loginUI(context);
                case StoreState.otp:
                  return otpUI(context);
              }
            },
          )),
        ),
      ),
    );
  }

  Widget loginUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const FadeAnimation(
          delay: 0,
          child: AuthHeader(header: 'ENTER YOUR MOBILE NUMBER'),
        ),
        SizedBox(height: 5.h),
        FadeAnimation(
          delay: 600,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
                width: 80.w,
                child: IntlPhoneField(
                  controller: _loginCtrl,
                  style: GoogleFonts.robotoCondensed(
                      textStyle: const TextStyle(
                          color: _constants.colorAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  decoration: const InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  dropdownTextStyle: GoogleFonts.robotoCondensed(
                      textStyle: const TextStyle(
                          color: _constants.colorAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  showCountryFlag: false,
                  initialCountryCode: 'IN',
                  dropdownIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: _constants.colorAccent,
                  ),
                  cursorColor: _constants.colorAccent,
                  onChanged: (phone) {
                    setState(() {
                      _contactNo = phone.completeNumber;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
                width: 10.w,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _loginCtrl.text = '';
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: Color.fromRGBO(250, 178, 6, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        FadeAnimation(
          delay: 600,
          child: AuthButton(
              buttonText: 'Login',
              callBack: () {
                if (_loginCtrl.text.isNotEmpty && _contactNo != null) {
                  _authStore.login(_contactNo!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please enter valid number')));
                }
              }),
        ),
        SizedBox(height: 2.h),
        FadeAnimation(
          delay: 600,
          child: Center(
            child: Text(
              'We will send you an SMS with the verification code to this number',
              maxLines: 2,
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Color.fromRGBO(250, 178, 6, 1),
                    fontSize: 12,
                  )),
            ),
          ),
        ),
      ],
    );
  }

  Widget otpUI(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const FadeAnimation(
            delay: 0,
            child: AuthHeader(header: 'ENTER VERIFICATION CODE'),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FadeAnimation(
                  delay: 200,
                  child: field(
                      focus: _field1,
                      next: _field2,
                      autofocus: true,
                      ctrl: _otp1)),
              FadeAnimation(
                  delay: 400,
                  child: field(focus: _field2, next: _field3, ctrl: _otp2)),
              FadeAnimation(
                  delay: 600,
                  child: field(focus: _field3, next: _field4, ctrl: _otp3)),
              FadeAnimation(
                  delay: 600,
                  child: field(focus: _field4, next: _field5, ctrl: _otp4)),
              FadeAnimation(
                  delay: 600,
                  child: field(focus: _field5, next: _field6, ctrl: _otp5)),
              FadeAnimation(
                  delay: 800, child: field(focus: _field6, ctrl: _otp6)),
            ],
          ),
          SizedBox(height: 2.h),
          FadeAnimation(
            delay: 600,
            child: Center(
              child: Text(
                'Please enter the verification code that was sent to ' +
                    _contactNo.toString(),
                maxLines: 2,
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(250, 178, 6, 1),
                      fontSize: 12,
                    )),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          FadeAnimation(
            delay: 600,
            child: AuthButton(
                buttonText: 'Continue',
                callBack: () async {
                  if (_agree) {
                    if (_otp1.text.isNotEmpty && _otp2.text.isNotEmpty &&
                        _otp3.text.isNotEmpty && _otp4.text.isNotEmpty &&
                        _otp5.text.isNotEmpty && _otp6.text.isNotEmpty){
                      String otp;
                      otp = _otp1.text + _otp2.text + _otp3.text + _otp4.text + _otp5.text + _otp6.text;

                      bool verified = await _authStore.verifyOtp(otp);

                      if(verified) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => const HomeScreen(),
                            ),
                            (route) => false);
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content:
                            Text("Login failed")));
                      }

                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                          Text("Please enter valid OTP")));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                        Text("Please agree to the terms and condition")));
                  }

                }),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              Checkbox(
                activeColor: _constants.buttonColor,
                checkColor: Colors.white,
                focusColor: _constants.buttonColor,
                hoverColor: _constants.buttonColor,
                side: const BorderSide(color: Colors.white),
                value: _agree,
                onChanged: (value) {
                  setState(() {
                    _agree = value ?? false;
                  });
                },
              ),
              Text(
                'I agree to the Terms Of Use and Privacy Policy',
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(color: Colors.white)),
              )
            ],
          ),
          SizedBox(
            height: 1.h,
          ),

          /// go back
          const Divider(
            color: Colors.white,
          ),
          FadeAnimation(
            delay: 300,
            child: GestureDetector(
              onTap: () {
                _authStore.goBack();
              },
              child: Text(
                'GO BACK',
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(250, 178, 6, 1),
                      fontSize: 12,
                    )),
              ),
            ),
          )
        ]);
  }
}

class AuthHeader extends StatelessWidget {
  final String header;

  const AuthHeader({
    Key? key,
    required this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      maxLines: 1,
      style: GoogleFonts.robotoCondensed(
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}
