import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  createUserDatabase(name, email, username, uid, dob) {
    final user = {
      "uid": uid,
      "name": name,
      "email": email,
      "username": username,
      "dob": dob,
      "followers": [],
      "following": [],
      "blocked": [],
      "about": ""
    };

    firestore.collection('users').doc(uid).set(user).then((value) {
      print(user);
    });
  }

  getUserWithUsername(username) async => (await firestore
          .collection('users')
          .where("username", isEqualTo: username)
          .get())
      .docs[0]
      .data();

  checkIfUsernameAlreadyExist(username) async =>
      (await firestore
              .collection('users')
              .where("username", isEqualTo: username)
              .get())
          .docs
          .length >
      0;
  // var length;

  // return length;

}
