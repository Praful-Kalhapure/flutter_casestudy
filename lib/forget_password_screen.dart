import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController _forgetEmailController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _emailError = '';
  String _otpError = '';
  String _newPasswordError = '';

  bool _otpSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue, // Set background color to blue
        ),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_otpSent) ...[
                    TextField(
                      controller: _forgetEmailController,
                      decoration: InputDecoration(
                        labelText: 'Enter Email',
                        errorText: _emailError,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        // Reset previous error messages
                        setState(() {
                          _emailError = '';
                        });

                        // Validate email
                        String forgetEmail = _forgetEmailController.text;
                        if (!isValidEmail(forgetEmail)) {
                          setState(() {
                            _emailError = 'Invalid email format';
                          });
                          return;
                        }

                        // Simulate sending OTP to email
                        _sendOTP();
                      },
                      child: Text('Send OTP'),
                    ),
                  ],
                  if (_otpSent) ...[
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _otpController,
                      decoration: InputDecoration(
                        labelText: 'Enter OTP',
                        errorText: _otpError,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _newPasswordController,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        errorText: _newPasswordError,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        errorText: _newPasswordError,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Reset previous error messages
                        setState(() {
                          _otpError = '';
                          _newPasswordError = '';
                        });

                        // Validate OTP
                        String enteredOTP = _otpController.text;
                        String correctOTP = '123456'; // Replace with your actual OTP

                        if (enteredOTP != correctOTP) {
                          setState(() {
                            _otpError = 'Incorrect OTP, please try again';
                          });
                          return;
                        }

                        // Validate new password and confirm password match
                        String newPassword = _newPasswordController.text;
                        String confirmPassword = _confirmPasswordController.text;

                        if (newPassword != confirmPassword) {
                          setState(() {
                            _newPasswordError = 'Passwords do not match';
                          });
                          return;
                        }

                        // Passwords match, show success message
                        _showPasswordResetSuccess(context);
                      },
                      child: Text('Reset Password'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Simple email validation function
  bool isValidEmail(String email) {
    // Replace this with a more comprehensive email validation logic if needed
    return email.contains('@');
  }

  // Simulate sending OTP to email
  void _sendOTP() {
    // Simulate sending OTP
    // You can implement your actual OTP sending logic here
    print('OTP Sent to ${_forgetEmailController.text}');
    setState(() {
      _otpSent = true;
    });
  }

  // Show password reset success message
  void _showPasswordResetSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Password Reset Successful'),
          content: Text('Your password has been successfully reset!'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
