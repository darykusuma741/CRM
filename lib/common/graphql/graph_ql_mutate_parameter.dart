class GraphQLMutateParameter {
  String queryString;
  Map<String, dynamic> variables;

  GraphQLMutateParameter({
    required this.queryString,
    this.variables = const <String, dynamic>{}
  });
}