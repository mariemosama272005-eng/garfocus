
import 'package:flutter/material.dart';


class AppTextstyle {
  static TextStyle h1(BuildContext context) {
    return TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle h2(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle hint24(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }

  static TextStyle hintTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }

  static TextStyle subTitle(BuildContext context) {
    return TextStyle(
      fontSize: 15,
      color: Theme.of(context).colorScheme.onSurface,
      height: 1.4,
    );
  }
}
