import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 242, 242),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 220, 220, 243), 
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/MESSI.jpg"),
                ),
                title: Text("Lionel Messi"),
                subtitle: Text("Hello"),
                trailing: Text("9:45 PM"),
              ),
              margin: EdgeInsets.symmetric(vertical: 5),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 221, 221, 244), 
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/ronaldo.webp"),
                ),
                title: Text("Cristiano Ronaldo"),
                subtitle: Text("Hey"),
                trailing: Text("9:58 PM"),
              ),
              margin: EdgeInsets.symmetric(vertical: 5),
            ),
          ],
        ),
      ),
    );
  }
}
