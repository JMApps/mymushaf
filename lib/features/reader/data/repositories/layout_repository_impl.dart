import '../../domain/entities/layout_entity.dart';
import '../../domain/repositories/layout_repository.dart';
import '../data_source/layout_local_data_source.dart';
import '../mappers/layout_mapper.dart';

class LayoutRepositoryImpl implements LayoutRepository {
  final LayoutLocalDataSource _localDataSource;

  const LayoutRepositoryImpl(this._localDataSource);

  @override
  Future<List<LayoutEntity>> fetchLayoutByPageNumber({required int pageNumber}) async {
    final layoutsByPageNumber = await _localDataSource.fetchLayoutByPageNumber(pageNumber: pageNumber);
    return layoutsByPageNumber.map((m) => m.layoutToEntity()).toList();
  }
}