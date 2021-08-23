import 'package:flutter/material.dart';
import 'package:instagram/components/container.dart';
import 'package:instagram/components/input.dart';
import 'package:instagram/components/modal.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/screens/auth/setup.dart';
import 'package:instagram/services/auth.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //states
  String email = "";

  bool validateEmail() {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid;
  }

  void checkForEmail() async {
    if (validateEmail()) {
      var authList = [];
      authList = await AuthMethods().checkIfAlreadyRegistered(email);
      if (authList.isEmpty) {
        //Navigate
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NamePassword(email: email)));
      } else {
        //return Modal
        showDialog(
            context: context,
            builder: (context) {
              return MyModal(
                title: "This Email is on Another Account",
                contents: Column(
                  children: [
                    Text(
                        "You can log into the account associated with that email or you can use another email to make a new account",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xff999999))),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 5,
                      thickness: 0.6,
                    ),
                    TextButton(
                      child: Text(
                        "Log in to Existing Account",
                        style: TextStyle(
                            color: Color(0xff4CB5F9),
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Divider(
                      height: 5,
                      thickness: 0.5,
                    ),
                    TextButton(
                      child: Text("Create New Account"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return MyModal(
              title: "Invalid Email",
              contents: Text(
                "Please enter a valid Email",
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    var devWidth = MediaQuery.of(context).size.width;
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
            Text("English (United States)",
                style: TextStyle(color: Color(0xff999999))),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2 * kDefaultPadding),
                  child: Text(
                    "PROVIDE YOUR EMAIL",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                MyInput(
                  hintText: "Email",
                  onChanged: (text) {
                    setState(() {
                      email = text;
                    });
                  },
                ),
                MyContainer(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xff4CB5F9)),
                      onPressed: () {
                        checkForEmail();
                      },
                      child: Text("NEXT")),
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
                          onPressed: () {},
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
