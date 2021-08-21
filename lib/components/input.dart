import 'package:flutter/material.dart';
import 'package:instagram/components/container.dart';
import 'package:instagram/constants.dart';

class MyInput extends StatelessWidget {
  final hintText;
  final onChanged;
  final inputIconChild;
  final securedText;
  const MyInput(
      {required this.hintText,
      required this.onChanged,
      this.inputIconChild,
      this.securedText});

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  obscureText: securedText != null ? securedText : false,
                  style: TextStyle(color: Color(0xff999999)),
                  decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(color: Color(0xff999999)),
                      border: InputBorder.none),
                  onChanged: onChanged,
                ),
              ),
              inputIconChild != null ? inputIconChild : Container()
            ],
          )),
    );
  }
}
