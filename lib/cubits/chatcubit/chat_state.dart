part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class Chatsucess extends ChatState {
  List<Message> messages;

  Chatsucess({required this.messages});
}

final class Chatfailure extends ChatState {}
