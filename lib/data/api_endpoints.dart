import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/comments/comment_model.dart';

const String _baseUrl = 'https://jsonplaceholder.typicode.com';

// end pointtt
const String comment = '/comments';

class CommentApiProvider {
  Future<List<Comment>> fetchComments() async {
    log("message");
    final response = await http.get(Uri.parse("$_baseUrl$comment"));

    if (response.statusCode == 200) {
      Iterable commentsJson = json.decode(response.body);
      for (var element in commentsJson) {
        log('data id : ${element['id']}');
      }
      return commentsJson.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception("Failed to load comments");
    }
  }
}
