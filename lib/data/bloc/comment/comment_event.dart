import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/comments/comment_model.dart';
import '../../domain/failures/failure.dart';

// CommentEvent
abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class FetchComments extends CommentEvent {}

// CommentState
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
