class PagingData<T> {
  int page;
  int? nextPage;
  List<T> data;

  PagingData({
    required this.page,
    this.nextPage,
    required this.data
  });
}