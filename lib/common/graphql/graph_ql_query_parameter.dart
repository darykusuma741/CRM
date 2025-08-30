class GraphQLQueryParameter {
  String queryString;
  Map<String, dynamic> variables;

  GraphQLQueryParameter({
    required this.queryString,
    this.variables = const <String, dynamic>{}
  });
}