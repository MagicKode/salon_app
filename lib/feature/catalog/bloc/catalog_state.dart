import 'package:flutter/material.dart';
import '../data/models/salon_model.dart';

@immutable
abstract class CatalogState {
  const CatalogState();
}

// Первоначальное состояние
class CatalogInitial extends CatalogState {}

// Процесс загрузки данных из сети
class CatalogLoading extends CatalogState {}

// Успех: данные получены, передаем нашу Entity в UI
class CatalogSuccess extends CatalogState {
  final SalonEntity salon;

  const CatalogSuccess({required this.salon});
}

// Ошибка сети или шлюза
class CatalogFailure extends CatalogState {
  final String errorMessage;

  const CatalogFailure({required this.errorMessage});
}
