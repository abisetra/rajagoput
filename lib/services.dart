import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Services {
  static void bypass() async {
    try {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.RUN',
        package: 'com.gojek.app',
        componentName: 'com.gojek.app.home.HomeActivity',
      );
      await intent.launch();
      await showSuccessToast();
    } catch (e) {
      showFailureToast();
    }
  }

  static Future<void> showSuccessToast() async {
    Fluttertoast.showToast(
      msg: "Selamat Makan <3",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static Future<void> showFailureToast() async {
    Fluttertoast.showToast(
      msg: "App Gojek nya install dulu coeg!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
