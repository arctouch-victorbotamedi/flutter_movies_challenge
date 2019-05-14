
abstract class Page<T> {
  int get totalResults;
  int get totalPages;
  int get page;
  List<T> get results;
}
