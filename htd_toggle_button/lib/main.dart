import 'package:flutter/material.dart';
import 'package:htd_toggle_button/widget/animated_toggle_button/animated_toggle_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: SizedBox(
            width: 300,
            child: AnimatedToggleButton(
              onValueChange: (value) {
                print(value.description);
              },
              toggleData: [
                ToggleData(0, 'First'),
                ToggleData(0, 'Second'),
                ToggleData(0, 'Third'),
              ],
            )),
      ),
    );
  }
}
