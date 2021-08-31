import 'package:flutter/material.dart';
import 'package:instagram/components/container.dart';
import 'package:instagram/components/input.dart';
import 'package:instagram/components/modal.dart';
import 'package:instagram/services/auth.dart';
import 'package:instagram/services/database.dart';

import '../../constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var text = "";
  bool loading = false;
  bool buttonDisabled = true;

  bool validateEmail() {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);

    return emailValid;
  }

  void validateButton() {
    if (text.length > 1) {
      setState(() {
        buttonDisabled = false;
      });
    } else {
      setState(() {
        buttonDisabled = true;
      });
    }
  }

  findSearchMethod() {
    if (validateEmail()) {
      findUserWithEmail();
    } else {
      findUserWithUsername();
    }
  }

  findUserWithUsername() async {
    setState(() {
      loading = true;
    });
    var exist = await DatabaseMethods().checkIfUsernameAlreadyExist(text);
    setState(() {
      loading = false;
    });
    if (exist) {
      await DatabaseMethods().getUserWithUsername(text).then((user) {
        var email = user["email"];
        AuthMethods().resetPassword(email);
        goBack();
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return MyModal(
              title: "User does not exist",
              contents: Column(
                children: [
                  Text("The username you provided does not exist.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff999999))),
                  TextButton(
                    child: Text("Okay"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
    }
  }

  findUserWithEmail() async {
    setState(() {
      loading = true;
    });
    var authList = [];
    authList = await AuthMethods().checkIfAlreadyRegistered(text);
    setState(() {
      loading = false;
    });
    if (authList.isNotEmpty) {
      AuthMethods().resetPassword(text);
      goBack();
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return MyModal(
              title: "User does not exist",
              contents: Column(
                children: [
                  Text("The email you provided does not exist.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff999999))),
                  TextButton(
                    child: Text("Okay"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
    }
  }

  goBack() {
    showDialog(
        context: context,
        builder: (context) {
          return MyModal(
            title: "Email Sent",
            contents: Column(
              children: [
                Text("Check your email to get the password reset link",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xff999999))),
                TextButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2 * kDefaultPadding),
                  child: Text(
                    "Find Your Account",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      3 * kDefaultPadding,
                      kDefaultPadding,
                      3 * kDefaultPadding,
                      2 * kDefaultPadding),
                  child: Text(
                    "Enter your username or the email linked with your account",
                    style: TextStyle(color: Color(0xff999999), fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                MyInput(
                  hintText: "Email",
                  onChanged: (value) {
                    setState(() {
                      text = value;
                    });
                    validateButton();
                  },
                ),
                Opacity(
                  opacity: buttonDisabled ? 0.5 : 1.0,
                  child: MyContainer(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff4CB5F9)),
                        onPressed: buttonDisabled
                            ? () {}
                            : loading
                                ? () {}
                                : () {
                                    findSearchMethod();
                                  },
                        child: loading
                            ? Transform.scale(
                                scale: 0.75,
                                child: CircularProgressIndicator(
                                  color: Color(0xffffffff),
                                ),
                              )
                            : Text("SEND")),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  Divider(
                    height: 5,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                          style: TextStyle(color: Color(0xff999999))),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Log in.",
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.bold)))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
