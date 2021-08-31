import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram/screens/auth/signin.dart';
import 'package:instagram/screens/home.dart';
import 'package:instagram/screens/splash.dart';
import 'package:instagram/theme.dart';
import './services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        home: Signin());
  }
}

class ShowSplash extends StatefulWidget {
  const ShowSplash({Key? key}) : super(key: key);

  @override
  _ShowSplashState createState() => _ShowSplashState();
}

class _ShowSplashState extends State<ShowSplash> {
  @override
  void initState() {
    super.initState();
    goToHome();
  }

  void goToHome() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthWidget()));
  }

  @override
  Widget build(BuildContext context) {
    return Splash();
  }
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthMethods().getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return Signin();
        }
      },
    );
  }
}

// class AuthWidget extends StatelessWidget {
//   const AuthWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: AuthMethods().getCurrentUser(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Home();
//         } else {
//           return Signin();
//         }
//       },
//     );
//   }
// }
