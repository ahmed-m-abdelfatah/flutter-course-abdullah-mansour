import 'dart:convert';
import 'dart:core';

class PostModel {
  String name;
  String uId;
  String image;
  String dateTime;
  String text;
  String postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      name: map['name'],
      uId: map['uId'],
      image: map['image'],
      dateTime: map['dateTime'],
      text: map['text'],
      postImage: map['postImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));
}
