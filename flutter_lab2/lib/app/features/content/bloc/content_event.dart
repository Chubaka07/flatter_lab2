part of 'content_bloc.dart';

sealed class ContentEvent extends Equatable {
  const ContentEvent();

  @override
  List<Object> get props => [];
}

class ContentLoad extends ContentEvent {
  const ContentLoad({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}