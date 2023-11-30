import 'package:chat_app/cubits/chatcubit/chat_cubit.dart';
import 'package:chat_app/model/chat_bubble.dart';
import 'package:chat_app/model/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class chat_page extends StatelessWidget {
  chat_page({super.key});
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();
  List<Message> messagelist = [];
  @override
  Widget build(BuildContext context) {
    var myemail = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 11, 166, 232),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
                child: Image.asset(
                  'images/chatapp.png',
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text("chatapp"),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('login');
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is Chatsucess) {
                    messagelist = state.messages;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagelist.length,
                      itemBuilder: (context, index) {
                        return messagelist[index].id == myemail
                            ? chatbubble(
                                message: messagelist[index],
                              )
                            : chatbubbleForFriend(message: messagelist[index]);
                      });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  BlocProvider.of<ChatCubit>(context).sendmessages(
                      message: value, myemail: myemail.toString());
                  controller.clear();
                  _controller.animateTo(
                    0,
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(style: BorderStyle.solid))),
              ),
            ),
          ],
        ));
  }
}
