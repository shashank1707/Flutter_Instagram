import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return auth.currentUser;
  }

  signupUser(email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("signup successful");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
