import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Services {
  static const platform = MethodChannel('com.rajagoput.app/gojek');

  static Future<String> _getGojekAppVersion() async {
    try {
      String result = await platform.invokeMethod('version');
      print("Current Gojek Version ${result}");
      return result;
    } on PlatformException catch (e) {
      print('MESSAGE ${e.message}');
      throw e;
    }
  }

  static Future<bool> _isVersionValid() async {
    double maxVersion = 4.43;

    String appVersion = await _getGojekAppVersion();

    List<String> splited = appVersion.split('.');
    int lastIndex = int.parse(splited.last);
    double currentVersion = double.parse('${splited.first}.${splited[1]}');

    if (currentVersion <= maxVersion) {
      if (lastIndex > 1) {
        return false;
      }
      return true;
    }
    return false;
  }

  static void showIncompatibleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Peringatan!'),
        content: Text(
          'Aplikasi Gojek kamu diatas 4.43.1, pake versi 4.43.1 kebawah cok!',
        ),
        actions: [
          ElevatedButton(
            child: Text('Download Gojek versi 4.43.1'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                MediaQuery.of(context).size.width,
                40,
              ),
            ),
            onPressed: () async {
              await launchUrl(
                Uri.parse(
                  'https://apkpure.com/id/gojek/com.gojek.app/download/4431-APK',
                ),
                mode: LaunchMode.externalApplication,
              );
            },
          )
        ],
      ),
    );
  }

  static void bypass(BuildContext context) async {
    try {
      bool isVersionValid = await _isVersionValid();
      if (!isVersionValid) {
        showIncompatibleDialog(context);
        return;
      }
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.RUN',
        package: 'com.gojek.app',
        componentName: 'com.gojek.app.home.HomeActivity',
      );
      await intent.launch();
      await _showSuccessToast();
    } catch (e) {
      _showFailureToast();
    }
  }

  static Future<void> _showSuccessToast() async {
    Fluttertoast.showToast(
      msg: "Selamat Makan <3",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static Future<void> _showFailureToast() async {
    Fluttertoast.showToast(
      msg: "App Gojek nya install dulu coeg!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
