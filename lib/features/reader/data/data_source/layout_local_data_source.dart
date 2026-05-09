import '../models/layout_model.dart';

abstract interface class LayoutLocalDataSource {
  Future<List<LayoutModel>> fetchLayoutByPageNumber({required int pageNumber});
}