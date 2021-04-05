import 'package:flutter/material.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/widget/messages_widget.dart';
import 'package:meditec/view/widget/new_message_widget.dart';
import 'package:meditec/view/widget/profile_header_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'callscreens/pickup/pickup_layout.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    User me = context.read(userProvider).currentUser();
    return PickupLayout(
      scaffold: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xFF00BABA),
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.user.name),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: MessagesWidget(
                    toID: widget.user.userId.toString(),
                    myID: me.userId.toString(),
                  ),
                ),
              ),
              NewMessageWidget(
                myID: me.userId.toString(),
                myName: me.name,
                toID: widget.user.userId.toString(),
                toName: widget.user.name,
              )
            ],
          ),
        ),
      ),
    );
  }
}
