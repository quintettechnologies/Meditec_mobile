import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meditec/model/ChatUser.dart';
import 'package:meditec/model/message.dart';
import 'package:meditec/utils/utils.dart';

class FirebaseApi {
  static Future uploadMessage(
      {String patientID,
      String patientName,
      String doctorID,
      String doctorName,
      String message}) async {
    final refMessages =
        FirebaseFirestore.instance.collection('messages/$doctorID/$patientID/');
    final refUsers =
        FirebaseFirestore.instance.collection('users/chats/$doctorID/');
    DocumentSnapshot snapshot = await refUsers.doc("$patientID").get();
    print(snapshot.exists);
    if (!snapshot.exists) {
      print("$patientID user does not exist!");

      ChatUser newUser = ChatUser(
          idUser: patientID,
          name: patientName,
          lastMessageTime: DateTime.now());
      await refUsers.doc("$patientID").set(newUser.toJson());
    } else {
      print(refUsers.doc("$patientID").get().toString());
    }

    final newMessage = Message(
      senderID: patientID,
      senderName: patientName,
      receiverID: doctorID,
      receiverName: doctorName,
      message: message,
      createdAt: DateTime.now(),
    );
    print(newMessage.senderName);
    print(newMessage.receiverName);
    print(newMessage.message);
    await refMessages.add(newMessage.toJson());
    await refUsers
        .doc("$patientID")
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(
          {@required String doctorID, @required String patientID}) =>
      FirebaseFirestore.instance
          .collection('messages/$doctorID/$patientID/')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
}
