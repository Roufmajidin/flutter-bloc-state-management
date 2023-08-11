import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rouf_state_management_bloc/data/bloc/comment/comment_event.dart';
import 'package:rouf_state_management_bloc/data/repository/comment_repository.dart';
import 'package:rouf_state_management_bloc/data/types.dart';

import 'package:dartz/dartz.dart';

import '../../api_endpoints.dart';
import '../../domain/failures/failure.dart';

abstract class CommentRemoteDataSource {
  Future<Either<CommentFailure, ListComment>> getComment();
}

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentApiProvider apiProvider = CommentApiProvider();

  CommentBloc() : super(CommentInitial()) {
    on<FetchComments>((event, emit) async {
      emit(CommentLoading());

      try {
        final comments = await apiProvider.fetchComments();
        emit(CommentLoaded(comments));
      } catch (error) {
        emit(CommentError(CommentFailure("Failed to fetch comments")));
      }
    });
  }
  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is FetchComments) {
      yield CommentLoading();

      try {
        final comments = await apiProvider.fetchComments();
        yield CommentLoaded(comments);
      } catch (error) {
        yield CommentError(CommentFailure("Failed to fetch comments"));
      }
    }
  }
}
