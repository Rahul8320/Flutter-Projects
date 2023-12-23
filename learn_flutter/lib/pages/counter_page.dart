import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // variable
  int _counter = 0;

  // method
  void _increment() {
    setState(() {
      _counter++;
    });
  }

  // UI (user interface)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[100],
        child: Column(
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.favorite,
                size: 150,
                color: Colors.deepPurpleAccent,
              ),
            ),

            // home page list tile
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                size: 30,
              ),
              title: const Text(
                "H O M E",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                // close the drawer
                Navigator.pop(context);
              },
            ),

            // counter page list tile
            ListTile(
              leading: const Icon(
                Icons.countertops_outlined,
                size: 30,
              ),
              title: const Text(
                "C O U N T E R",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                // close the drawer
                Navigator.pop(context);
              },
            ),

            // list todo page list tile
            ListTile(
              leading: const Icon(
                Icons.task_outlined,
                size: 30,
              ),
              title: const Text(
                "T O D O  L I S T",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
                // go to todo list page
                Navigator.pushNamed(context, '/todo_list_page');
              },
            ),

            // tap me page list tile
            ListTile(
              leading: const Icon(
                Icons.tapas_outlined,
                size: 30,
              ),
              title: const Text(
                "T A P  M E",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
                // go to tap me page
                Navigator.pushNamed(context, '/tapme_page');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("You have pushed the button this many times:"),

            // show the counter value
            Text(
              '$_counter',
              style:
                  const TextStyle(fontSize: 40, color: Colors.deepOrangeAccent),
            ),
            // button
            ElevatedButton(
              onPressed: _increment,
              child: const Text(
                "Increment!",
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
