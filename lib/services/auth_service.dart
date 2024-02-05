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
     

      if (e.code == 'invalid-email') {
        print('Invalid email address');
      }

      if (e.code == 'wrong-password') {
        print('Wrong password');
      }


      return null;
    } catch (e) {
      print('Unexpected error during sign in: $e');
      return null;
    }
  }
}
