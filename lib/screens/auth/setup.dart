import 'package:flutter/material.dart';
import 'package:instagram/components/container.dart';
import 'package:instagram/components/input.dart';
import 'package:instagram/components/modal.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/services/auth.dart';

class NamePassword extends StatefulWidget {
  final email;

  const NamePassword({this.email});

  @override
  _NamePasswordState createState() => _NamePasswordState();
}

class _NamePasswordState extends State<NamePassword> {
  String email = "";
  String name = "";
  String password = "";
  bool securedText = true;

  bool validatePassword() {
    if (password.length >= 6) return true;
    return false;
  }

  void goToNext() {
    if (!validatePassword()) {
      showDialog(
          context: context,
          builder: (context) {
            return MyModal(
              title: "Invalid Password",
              contents: Text(
                "Password must be at least 6 charcters long",
                textAlign: TextAlign.center,
              ),
            );
          });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Birthday(
                    email: email,
                    password: password,
                    name: name,
                  )));
    }
  }

  @override
  void initState() {
    super.initState();
    email = widget.email;
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2 * kDefaultPadding),
                  child: Text(
                    "NAME AND PASSWORD",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                MyInput(
                  hintText: "Name",
                  onChanged: (text) {
                    setState(() {
                      name = text;
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
                        ? Icon(
                            Icons.visibility_off,
                            color: Color(0xff999999),
                          )
                        : Icon(Icons.visibility),
                    color: Color(0xff999999),
                  ),
                ),
                MyContainer(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xff4CB5F9)),
                      onPressed: () {
                        goToNext();
                      },
                      child: Text("NEXT")),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(2 * kDefaultPadding),
              child: Text(
                "Your details will be synced and stored on Instagram servers to help you and others find friends, and to help us provide a better service.",
                style: TextStyle(color: Color(0xff999999)),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Birthday extends StatefulWidget {
  final email, password, name;

  const Birthday({this.email, this.password, this.name});

  @override
  _BirthdayState createState() => _BirthdayState();
}

class _BirthdayState extends State<Birthday> {
  var dob;
  var email = "", name = "", password = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      email = widget.email;
      name = widget.name;
      password = widget.password;
    });
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
            Column(
              children: [
                Image.asset(
                  'assets/images/Cake.png',
                  width: devWidth * 0.2,
                  height: devWidth * 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.all(2 * kDefaultPadding),
                  child: Text(
                    "Add Your Birthday",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                MyContainer(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: Text(dob == null
                        ? "Add Your Birthday"
                        : dob.toString().split(" ")[0]),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now())
                          .then((value) {
                        setState(() {
                          dob = value;
                        });
                      });
                    },
                  ),
                ),
                MyContainer(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xff4CB5F9)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register(
                                      name: name,
                                      email: email,
                                      password: password,
                                      dob: dob,
                                    )));
                      },
                      child: Text("NEXT")),
                ),
              ],
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  final email, password, name;
  final dob;
  const Register({this.email, this.name, this.password, this.dob});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var dob;
  var email = "", name = "", password = "";
  var userName = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      email = widget.email;
      name = widget.name;
      password = widget.password;
      dob = widget.dob;
    });
    createUsername();
  }

  void createUsername() {
    setState(() {
      userName = email.split("@")[0] + "_" + name;
    });
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
            SizedBox(),
            Column(
              children: [
                Text(
                  "WELCOME TO INSTAGRAM,\n$userName",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(2 * kDefaultPadding),
                  child: Text(
                    "Find people to follow and start sharing photos. You can change your username anytime",
                    style: TextStyle(color: Color(0xff999999)),
                    textAlign: TextAlign.center,
                  ),
                ),
                MyContainer(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xff4CB5F9)),
                      onPressed: () {
                        createUsername();
                        print(name);
                        print(email);
                        print(password);
                        print(dob.toString());
                        print(userName);
                      },
                      child: Text("Register")),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(2 * kDefaultPadding),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: "By clicking Register, you agree to our ",
                      style: TextStyle(color: Color(0xff999999))),
                  TextSpan(
                      text: "Terms, Data Policy ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  TextSpan(
                      text: "and ", style: TextStyle(color: Color(0xff999999))),
                  TextSpan(
                      text: "Cookies Policy",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
