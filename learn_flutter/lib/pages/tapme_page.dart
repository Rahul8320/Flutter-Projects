import 'package:flutter/material.dart';

class TapMePage extends StatelessWidget {
  const TapMePage({super.key});

  void userTapped() {
    print("User Tapped!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: const Text("Tap Me Page"),
        backgroundColor: Colors.deepPurpleAccent,
        // elevation: 0,
        // leading: const Icon(Icons.menu),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.logout,
        //         color: Colors.blueGrey,
        //       ))
        // ],
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
    );
  }
}
