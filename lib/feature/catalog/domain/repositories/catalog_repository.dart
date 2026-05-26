import '../../data/models/salon_model.dart';

abstract class CatalogRepository {
  Future<SalonEntity> getSalonDetails();
}
