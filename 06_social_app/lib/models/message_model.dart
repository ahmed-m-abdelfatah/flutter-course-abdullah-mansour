import 'dart:convert';

class MessageModel {
  String sinderId;
  String recevierId;
  String messageDate;
  String messagetext;

  MessageModel({
    required this.sinderId,
    required this.recevierId,
    required this.messageDate,
    required this.messagetext,
  });

  Map<String, dynamic> toMap() {
    return {
      'sinderId': sinderId,
      'recevierId': recevierId,
      'messageDate': messageDate,
      'messagetext': messagetext,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      sinderId: map['sinderId'],
      recevierId: map['recevierId'],
      messageDate: map['messageDate'],
      messagetext: map['messagetext'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));
}
