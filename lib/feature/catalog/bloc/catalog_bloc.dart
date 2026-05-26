import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repositories/catalog_repository.dart';
import 'catalog_event.dart';
import 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CatalogRepository catalogRepository;

  CatalogBloc({required this.catalogRepository}) : super(CatalogInitial()) {
    // Регистрируем обработчик события загрузки
    on<CatalogFetchRequested>(_onCatalogFetchRequested);
  }

  Future<void> _onCatalogFetchRequested(
      CatalogFetchRequested event,
      Emitter<CatalogState> emit,
      ) async {
    emit(CatalogLoading());
    try {
      // Идем в репозиторий за данными
      final salon = await catalogRepository.getSalonDetails();
      emit(CatalogSuccess(salon: salon));
    } catch (e) {
      emit(CatalogFailure(errorMessage: e.toString().replaceAll('Exception: ', '')));
    }
  }
}
