import 'package:flutter/material.dart';
import 'login_screen.dart';

class OTPScreen extends StatefulWidget {
  final String email;

  OTPScreen(this.email);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _otpController = TextEditingController();

  String _otpError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue, 
        ),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'An OTP has been sent to ${widget.email}.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                      errorText: _otpError,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _otpError = '';
                      });

                      String enteredOTP = _otpController.text;
                      String correctOTP = '123'; 

                      if (enteredOTP == correctOTP) {
                        _showRegistrationSuccess(context);
                      } else {
                        setState(() {
                          _otpError = 'Incorrect OTP, please try again , enter 123';
                        });
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                      ),
                    ),
                    child: Text('Verify OTP'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showRegistrationSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Successful'),
          content: Text('You have successfully registered!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
