import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Firebase Authentication Error: ${e.message}');
      // Handle specific Firebase authentication exceptions here
      // You can customize the error handling based on specific exception codes

      // Example: Handle invalid email
      if (e.code == 'invalid-email') {
        print('Invalid email address');
      }

      // Example: Handle wrong password
      if (e.code == 'wrong-password') {
        print('Wrong password');
      }

      // Add more cases as needed

      return null;
    } catch (e) {
      print('Unexpected error during sign in: $e');
      return null;
    }
  }
}
