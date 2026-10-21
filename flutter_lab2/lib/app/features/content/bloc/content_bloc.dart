import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_lab2/data/models/content.dart';
import 'package:flutter_lab2/data/repositories/content/content_repository_interface.dart';
import 'package:flutter_lab2/di/di.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final ContentRepositoryInterface contentRepository;

  ContentBloc(this.contentRepository) : super(ContentInitial()) {
    on<ContentLoad>(_onContentLoad);
  }

  Future<void> _onContentLoad(
    ContentLoad event,
    Emitter<ContentState> emit,
  ) async {
    try {
      emit(ContentLoadInProgress());
      final content = await contentRepository.getContentById(event.id);
      emit(ContentLoadSuccess(content: content));
    } catch (exception, stackTrace) {
      emit(ContentLoadFailure(exception: exception));
      talker.handle(exception, stackTrace);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}