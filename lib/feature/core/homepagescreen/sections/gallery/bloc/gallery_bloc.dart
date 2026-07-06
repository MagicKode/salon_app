import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/catalog/domain/repositories/catalog_repository.dart';
import 'gallery_event.dart';
import 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final CatalogRepository repository;

  GalleryBloc(this.repository) : super(GalleryState.initial()) {
    on<LoadGallery>(_onLoadGallery);
  }

  Future<void> _onLoadGallery(LoadGallery event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final images = await repository.getImages('gallery', 0);
      emit(state.copyWith(images: images, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
