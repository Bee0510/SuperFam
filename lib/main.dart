// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'screens/login__screen/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      routes: {
        '/login_screen': (context) => LoginScreen(),
      },
      initialRoute: '/login_screen',
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final String phoneNumber;
  final String otp;

  DashboardScreen({required this.phoneNumber, required this.otp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Phone Number: $phoneNumber'),
            Text('OTP: $otp'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
