import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromjson(jsondata) {
    return Message(jsondata['message'], jsondata["id"]);
  }
}
