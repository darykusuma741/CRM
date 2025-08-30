class HttpClientRedirectRecord {
  final int statusCode;
  final String method;
  final Uri location;

  HttpClientRedirectRecord(this.statusCode, this.method, this.location);
}
