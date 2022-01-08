import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String error) {
  final snackBar = SnackBar(
    content: Text(
      error,
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.red[900],
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
