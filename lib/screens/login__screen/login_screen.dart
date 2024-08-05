// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../core/theme/base_color.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _otp = '';
  bool _isSendTapped = false;
  final TextEditingController _controllers = TextEditingController();
  late final FocusNode focusNode;

  final TextEditingController _phoneController = TextEditingController();
  String generateOTP() {
    Random random = Random();
    int otp = random.nextInt(900000) + 100000;
    return otp.toString();
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/login anim.json',
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.height * 0.3),
                  Text(
                    _otp == '' ? "Let's Get Started" : "Enter OTP Sent To",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    _otp == ''
                        ? 'Enter your mobile number'
                        : _phoneController.text,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  _otp == ''
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '+91',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your phone number';
                                  } else if (value.length != 10) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                                controller: _phoneController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    hintText: 'XXX XXX XXXX',
                                    label: Text('Phone Number')),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Pinput(
                            length: 6,
                            controller: _controllers,
                            focusNode: focusNode,
                            defaultPinTheme: defaultPinTheme,
                            separatorBuilder: (index) =>
                                const SizedBox(width: 8),
                            validator: (input) {
                              if (input!.length < 6) {
                                return 'Enter 6 digit OTP';
                              }
                              return null;
                            },
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            onCompleted: (pin) {
                              debugPrint('onCompleted: $pin');
                            },
                            onChanged: (value) {
                              debugPrint('onChanged: $value');
                            },
                            cursor: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 9),
                                  width: 22,
                                  height: 1,
                                  color: focusedBorderColor,
                                ),
                              ],
                            ),
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(19),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            errorPinTheme: defaultPinTheme.copyBorderWith(
                              border: Border.all(color: Colors.redAccent),
                            ),
                          ),
                        ),
                  SizedBox(height: 40),
                  _otp == ''
                      ? ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              generateOTP();
                              setState(() {
                                _otp = generateOTP();
                              });
                              print(_otp);
                              if (_otp != '') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('OTP Sent is: $_otp'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 4),
                                ));
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: _isSendTapped
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  )
                                : Text(
                                    'SEND OTP',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            _controllers.length == 6
                                ? _otp == _controllers.text
                                    ? showAlertDialog(context)
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text('Invalid OTP'),
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 2),
                                      ))
                                : null;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _controllers.length < 6
                                ? Colors.grey
                                : AppColors.primarycolor1,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'User Information',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Phone Number: ${_phoneController.text}',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
              ),
              Text(
                'OTP: $_otp',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16.0),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarycolor1,
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
              child: Text('Return',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
