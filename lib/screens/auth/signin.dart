import 'package:flutter/material.dart';
import 'package:instagram/components/container.dart';
import 'package:instagram/components/input.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/services/auth.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  //states
  String email = "";
  String password = "";
  bool securedText = true;

  void signin() async {
    AuthMethods().signinUser(email, password);
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
                  child: Image.asset(
                    'assets/images/insta.png',
                    width: devWidth * 0.4,
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
                MyInput(
                  securedText: securedText,
                  hintText: "Password",
                  onChanged: (text) {
                    setState(() {
                      password = text;
                    });
                  },
                  inputIconChild: IconButton(
                      onPressed: () {
                        setState(() {
                          securedText = !securedText;
                        });
                      },
                      icon: securedText
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)),
                ),
                MyContainer(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xff4CB5F9)),
                      onPressed: () {
                        signin();
                      },
                      child: Text("Log In")),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Forgot your Password?",
                        style: TextStyle(color: Color(0xff999999))),
                    TextButton(
                        onPressed: () {},
                        child: Text("Reset Password",
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.bold)))
                  ],
                )
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
                      Text("Don't have an account?",
                          style: TextStyle(color: Color(0xff999999))),
                      TextButton(
                          onPressed: () {},
                          child: Text("Sign up",
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
