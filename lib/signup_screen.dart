import 'package:flutter/material.dart';
import 'otp_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase SignUp',
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _emailError = '';
  String _passwordError = '';

  Future<void> _storeUserData(String email) async {
    try {

      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;

      await firestore.collection('users').doc(uid).set({
        'email': email,
      }).then((_) {
        print("User data stored successfully!");
      }).catchError((error) {
        print("Error storing user data: $error");
      });
    } catch (e) {
      print('Unexpected error storing user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _emailError,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      errorText: _passwordError,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _emailError = '';
                        _passwordError = '';
                      });

                      String email = _emailController.text;
                      if (!email.contains('@')) {
                        setState(() {
                          _emailError = 'Invalid email format';
                        });
                        return;
                      }

                      String password = _passwordController.text;
                      String confirmPassword = _confirmPasswordController.text;

                      if (password != confirmPassword) {
                        setState(() {
                          _passwordError = 'Passwords do not match';
                        });
                        return;
                      }

                      await _storeUserData(email);


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OTPScreen(email)),
                      );
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                      ),
                    ),
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
