import 'package:equatable/equatable.dart';
import 'package:rouf_state_management_bloc/data/domain/failures/failure.dart';
import 'package:rouf_state_management_bloc/models/comments/comment_model.dart';
import 'package:dartz/dartz.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<Comment> comments;

  const CommentLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentError extends CommentState {
  final CommentFailure failure;

  const CommentError(this.failure);

  @override
  List<Object> get props => [failure];
}
