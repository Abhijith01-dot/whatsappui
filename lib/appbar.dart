import 'package:flutter/material.dart';
import 'package:whatsappui/Chats.dart';
import 'package:whatsappui/call.dart';
import 'package:whatsappui/chatbot.dart';
import 'package:whatsappui/community.dart';
import 'package:whatsappui/update.dart';

class AppBarex extends StatefulWidget {
  const AppBarex({super.key});

  @override
  
  State<AppBarex> createState() => _AppBarexState();
}

class _AppBarexState extends State<AppBarex> {
  int index=0;
  List<Widget> pages=[Chat(),Update(),Community(),Call()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WhatsApp",
          style: TextStyle(color: Color.fromARGB(255, 3, 215, 81)),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){}, icon: Icon(Icons.email))),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz_outlined)),
          )
        ],
        foregroundColor: Color.fromARGB(174, 6, 227, 61),
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>Chatbot()));},
          backgroundColor: Color.fromARGB(255, 5, 153, 39),
          foregroundColor: Color.fromARGB(255, 246, 250, 250),
          child: Icon(Icons.add)),
      bottomNavigationBar: BottomNavigationBar (items: [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.update_sharp), label: "Updates"),
        BottomNavigationBarItem(icon:Icon( Icons.groups),label: "community"),
        BottomNavigationBarItem(icon:Icon(Icons.call),label: ("Call"),)
      ],
      currentIndex: index,
      onTap: (tappedindex){
        setState(() {
          index=tappedindex;
        });
      },
      selectedItemColor:Color.fromARGB(255, 30, 241, 111),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color.fromARGB(255, 252, 254, 255)      ) ,
      body: pages[index],
    );
  }
}