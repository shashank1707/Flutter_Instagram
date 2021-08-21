import 'package:flutter/material.dart';
import 'package:instagram/constants.dart';

class MyContainer extends StatelessWidget {
  final child;
  final backgroundColor;
  final borderColor;

  const MyContainer({this.child, this.backgroundColor, this.borderColor});

  @override
  Widget build(BuildContext context) {
    var devWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      width: devWidth * 0.8,
      height: devWidth * 0.15,
      decoration: BoxDecoration(
          color: backgroundColor != null ? backgroundColor : Color(0xffFAFAFA),
          border: Border.all(
              width: 1,
              color: borderColor != null ? borderColor : Color(0xffDBDBDB)),
          borderRadius: BorderRadius.circular(5)),
      child: child,
    );
  }
}
