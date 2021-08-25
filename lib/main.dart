import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(MyApp());
}

class ExampleHive {
  void doSome() async {
    var box = await Hive.openBox('MyTestBox');
    await box.put('name', 'Jonibek');
    box.close();
  }
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Using hive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
    );
  }
}

var model = ExampleHive();
var text = '';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  void printIt() async {
    var box = await Hive.openBox('MyTestBox');
    var a = box.get('name') as String?;
    setState(() {
      text = a as String;
    });
    box.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hive'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                CupertinoButton.filled(
                  onPressed: () {
                    model.doSome();
                  },
                  child: Text('Put'),
                ),
                CupertinoButton.filled(
                    child: Text('Display'), onPressed: printIt)
              ],
            ),
            Text('$text')
          ],
        ),
      ),
    );
  }
}
