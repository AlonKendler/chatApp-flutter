import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  Future<void> _sendMessage() async {
    await messages.add({
      'message': _messageController.text,
      'timestamp': Timestamp.fromDate(DateTime.now()),
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: messages.orderBy('timestamp', descending: true).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              return ListView(
                reverse: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['message']),
                    subtitle: Text(
                        (data['timestamp'] as Timestamp).toDate().toString()),
                  );
                }).toList(),
              );
            },
          ),
        ),
        TextField(
          controller: _messageController,
          decoration: InputDecoration(
            labelText: "Type a message",
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: _sendMessage,
            ),
          ),
        ),
      ],
    );
  }
}
