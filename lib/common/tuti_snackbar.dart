import 'package:flutter/material.dart';

import '../constants/color.dart';

class TuTiSnackBar {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorConstants.primaryColor,
      ),
    );
  }
}
