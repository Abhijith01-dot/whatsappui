import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Chatbot extends StatefulWidget {
  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  List<Map<String, String>> messages = [];
  bool isloading = false;
  bool cansend = false;
  String apikey = "AIzaSyB5o0Jeq2tRHedXnJf-gcKOkrwmVFoSPqQ";
  TextEditingController msgcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    msgcontroller.addListener(() {
      setState(() {
        cansend = msgcontroller.text.trim().isNotEmpty;
      });
    });
  }

  Future<void> sendMessage(String userMessage) async {
    setState(() {
      messages.add({'role': 'user', 'text': userMessage});
      isloading = true;
      cansend = false;
    });

    final uri = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apikey');

    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {'text': userMessage}
          ]
        }
      ]
    });

    try {
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botReply = data['candidates'][0]['content']['parts'][0]['text'];

        setState(() {
          messages.add({'role': 'bot', 'text': botReply});
        });
      } else {
        setState(() {
          messages.add({
            'role': 'bot',
            'text': 'Something went wrong. Please try again later.'
          });
        });
      }
    } catch (e) {
      setState(() {
        messages.add({'role': 'bot', 'text': 'Error: $e'});
      });
    } finally {
      setState(() {
        isloading = false;
        msgcontroller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("AI CHAT BOT")),
        body: Column(
          children: [
            Builder(builder: (context) {
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) =>
                      buildmessage(messages.reversed.toList()[index]),
                ),
              );
            }),
            if (isloading)
              CircularProgressIndicator(
                color: Colors.black,
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                      controller: msgcontroller,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 138, 184, 190),
                          filled: true,
                          prefixIcon: Icon(Icons.camera_alt),
                          hintText: "Ask anything",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)))),
                ),
                IconButton(
                    onPressed: () {
                      sendMessage(msgcontroller.text.trim());
                    },
                    icon: Icon(Icons.send))
              ],
            )
          ],
        ));
  }

  Widget buildmessage(Map<String, String> msg) {
    bool isuser = msg["role"] == "user";
    return Align(
      alignment: isuser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container( 
        padding: EdgeInsets.symmetric(horizontal: 13,vertical: 11),
        decoration: BoxDecoration(color: isuser ? Color.fromARGB(255, 202, 215, 218) : Color.fromARGB(255, 222, 226, 231),borderRadius: BorderRadius.circular(20)),
        child: Text(
          msg["text"] ?? "",
          style: TextStyle(color: isuser ? Colors.black : Color.fromARGB(255, 20, 19, 26)),
        ),
      ),
    );
  }
}
