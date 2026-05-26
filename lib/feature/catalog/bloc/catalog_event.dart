import 'package:flutter/material.dart';

@immutable
abstract class CatalogEvent {
  const CatalogEvent();
}

// Событие инициализации/загрузки данных салона
class CatalogFetchRequested extends CatalogEvent {}
