import 'package:flutter/material.dart';
import 'package:meditec/model/message.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/resources/firebase_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'message_widget.dart';

class MessagesWidget extends StatelessWidget {
  final String toID;
  final String myID;

  const MessagesWidget({
    Key key,
    @required this.toID,
    @required this.myID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: FirebaseApi.getMessages(doctorID: toID, patientID: myID),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data;

                return messages.isEmpty
                    ? buildText('Say Hi..')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return MessageWidget(
                            message: message,
                            isMe: message.senderID == myID,
                          );
                        },
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
