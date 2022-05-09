import 'package:flutter/material.dart';

class MyAlertDialog3 extends StatelessWidget {
  final String title;
  final String content;

  MyAlertDialog3({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        );
  }
}
