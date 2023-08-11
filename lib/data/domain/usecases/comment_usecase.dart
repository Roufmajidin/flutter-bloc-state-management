import 'package:dartz/dartz.dart';
import 'package:rouf_state_management_bloc/data/api_endpoints.dart';
import 'package:rouf_state_management_bloc/data/domain/failures/failure.dart';
import 'package:rouf_state_management_bloc/models/comments/comment_model.dart';

class CommentUseCase {
  final CommentApiProvider apiProvider;

  CommentUseCase(this.apiProvider);

  Future<Either<CommentFailure, List<Comment>>> getComments() async {
    try {
      final comments = await apiProvider.fetchComments();

      return Right(comments);
    } catch (error) {
      return Left(CommentFailure("Gagal mendapatkan data comments"));
    }
  }
}
