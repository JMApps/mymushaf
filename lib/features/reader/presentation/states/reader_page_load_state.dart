import '../../domain/entities/reader_page_data.dart';

class ReaderPageLoadState {
  final bool loading;
  final Object? error;
  final ReaderPageData? data;

  const ReaderPageLoadState({
    required this.loading,
    required this.error,
    required this.data,
  });

  bool get loaded => data != null && error == null;

  const ReaderPageLoadState.initial() : loading = false, error = null, data = null;

  const ReaderPageLoadState.loading() : loading = true, error = null, data = null;

  const ReaderPageLoadState.error(Object this.error) : loading = false, data = null;

  const ReaderPageLoadState.loaded(ReaderPageData this.data) : loading = false, error = null;
}
