import '../entities/layout_entity.dart';

abstract interface class LayoutRepository {
  Future<List<LayoutEntity>> fetchLayoutByPageNumber({required int pageNumber});
}