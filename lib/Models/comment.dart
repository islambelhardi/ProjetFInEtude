import 'package:flutter/cupertino.dart';

class Comment {
  String username;
  String content;
  Comment(this.username, this.content);
  Comment.fromJson(Map json)
      : username = json['username'],
        content = json['content'];
}
