import 'package:flutter/material.dart';
import 'package:instagram/constants.dart';

class MyModal extends StatelessWidget {
  final title;
  final contents;

  const MyModal({this.title, this.contents});

  @override
  Widget build(BuildContext context) {
    var devWidth = MediaQuery.of(context).size.width;

    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        insetPadding: EdgeInsets.all(devWidth * 0.2),
        elevation: 0,
        children: [
          Padding(
            padding: const EdgeInsets.all(2 * kDefaultPadding),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2 * kDefaultPadding),
            child: contents,
          )
        ]);
  }
}
