import 'package:flutter/material.dart';
import 'package:root/root.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raja Goput',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Raja Goput'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bypass Update Gojek untuk versi 4.54.2 kebawah',
            ),
            const Text(
              'Diperlukan Akses ROOT!',
            ),
            Container(
              padding: EdgeInsets.only(top: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  fixer();
                  toast();
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 4, right: 4, top: 12, bottom: 12),
                  child: Text(
                    'Crotkan',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> fixer() async {
  await Root.exec(cmd: 'am force-stop com.gojek.app');
  await Root.exec(
      cmd:
          'rm -rf /data/data/com.gojek.app/shared_prefs/UPDATER_PREFERENCES.xml');

  await Root.exec(cmd: 'monkey -p com.gojek.app 1');
}

Future<void> toast() async {
  Fluttertoast.showToast(
      msg: "CROTTTTTTTT",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
}
