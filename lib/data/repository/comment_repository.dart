import 'package:dartz/dartz.dart';

import '../../models/comments/comment_model.dart';
import '../api_endpoints.dart';
import '../domain/failures/failure.dart';

class CommentRepository {
  final CommentApiProvider apiProvider;

  CommentRepository(this.apiProvider);

  Future<Either<CommentFailure, List<Comment>>> getComments() async {
    try {
      final comments = await apiProvider.fetchComments();
      return Right(comments);
    } catch (error) {
      return Left(CommentFailure("Failed to fetch comments"));
    }
  }
}
