import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void userTapped() {
    print("User Tapped!");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple[200],
        appBar: AppBar(
          title: const Text("Learn Flutter"),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          leading: const Icon(Icons.menu),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.logout,
                  color: Colors.blueGrey,
                ))
          ],
        ),
        body: Center(
            child: GestureDetector(
          onTap: userTapped,
          child: Container(
            height: 200,
            width: 200,
            color: Colors.deepOrange[200],
            child: const Center(child: Text("Tap Me")),
          ),
        )),
      ),
    );
  }
}
