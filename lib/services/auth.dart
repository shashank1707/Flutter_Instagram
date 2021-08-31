import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/services/database.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return auth.currentUser;
  }

  signupUser(email, password, name, username, dob) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        var user = value.user;
        if (user != null) {
          user.sendEmailVerification();
          DatabaseMethods()
              .createUserDatabase(name, email, username, user.uid, dob);
        }
      });
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

  signinUser(email, password) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  checkIfAlreadyRegistered(email) async {
    return await auth.fetchSignInMethodsForEmail(email);
  }

  resetPassword(email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  sendVerificationLink(email, password) async {
    await signinUser(email, password).then((value) {
      if (value != null) {
        value.user.sendEmailVerification();
      }
    });
  }
}
