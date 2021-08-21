import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: devWidth * 0.2,
                  height: devWidth * 0.2,
                ),
                SizedBox(
                  height: devWidth * 0.05,
                ),
                Image.asset(
                  'assets/images/insta.png',
                  width: devWidth * 0.4,
                ),
              ],
            ),
            Image.asset(
              'assets/images/fromfb.png',
              width: devWidth * 0.45,
            )
          ],
        ),
      ),
    );
  }
}
