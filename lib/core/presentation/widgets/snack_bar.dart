import 'package:flutter/material.dart';

SnackBar getErrorSnackbar(String content) {
  return SnackBar(
    content: Text(content),
    backgroundColor: Colors.red,
  );
}
