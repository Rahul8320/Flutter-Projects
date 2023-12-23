import 'package:flutter/material.dart';
import 'package:learn_flutter/pages/counter_page.dart';
// import 'package:learn_flutter/pages/tapme_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: TapMePage(),
      home: CounterPage(title: "Counter Page"),
    );
  }
}
