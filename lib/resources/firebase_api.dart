import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
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
    // final refMyMessages =
    //     FirebaseFirestore.instance.collection('chats/$myID/$toID/');

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
    //await refMyMessages.add(newMessage.toJson());
  }

  static Stream<List<Message>> getMessages(
          {@required String doctorID, @required String patientID}) =>
      FirebaseFirestore.instance
          .collection('messages/$doctorID/$patientID/')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
}
