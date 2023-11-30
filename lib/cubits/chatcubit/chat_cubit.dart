import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection("messages");

  void sendmessages({required String message, required String myemail}) {
    try {
      messages.add(
          {'message': message, 'createdat': DateTime.now(), 'id': myemail});
    } on Exception catch (e) {
      emit(Chatfailure());
    }
  }

  void getMesseges() {
    messages.orderBy("createdat", descending: true).snapshots().listen((event) {
      List<Message> messageslist = [];
      for (var doc in event.docs) {
        messageslist.add(Message.fromjson(doc));
      }

      emit(Chatsucess(messages: messageslist));
    });
  }
}
