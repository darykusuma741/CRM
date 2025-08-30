class LocalPagingIsMaxError extends Error {
  @override
  String toString() {
    return "The local paging is reach max";
  }
}