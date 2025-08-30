import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:html/parser.dart' as html_parser;

class StringHelper {
  String toApiEndpointFromBaseUrl(String baseUrl) {
    String effectiveBaseUrl = baseUrl.replaceAll(RegExp(r"/+$"), "");
    return "$effectiveBaseUrl/crmapp/api";
  }

  String getCurrentCurrencySymbol() {
    // var currentContext = NavigationHelperImpl.navigatorKey.currentContext!;
    // var profileAccountCubit = BlocProvider.of<ProfileAccountCubit>(currentContext);
    // var result = profileAccountCubit.state.userWithEmployeeDetailResponseLoadDataResult;
    String currencySymbol = "S\$";
    // if (result.isSuccess) {
    //   var response = result.resultIfSuccess!;
    //   currencySymbol = response.getUserIdResponse.currencySymbol;
    // }
    return currencySymbol;
  }

  String convertToCurrencyString1(double value) {
    String currencySymbol = getCurrentCurrencySymbol();
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'en_US',
      symbol: currencySymbol,
      decimalDigits: 0
    );
    String formattedValue = currencyFormat.format(value);
    if (formattedValue.startsWith(currencySymbol)) {
      formattedValue = formattedValue.replaceFirst(currencySymbol, '$currencySymbol ');
    }
    return formattedValue;
  }

  String convertToCurrencyString2(double value) {
    String currencySymbol = getCurrentCurrencySymbol();
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'en_US',
      symbol: currencySymbol,
      decimalDigits: 2
    );
    String formattedValue = currencyFormat.format(value);
    if (formattedValue.contains(currencySymbol)) {
      formattedValue = formattedValue.replaceFirst(currencySymbol, '$currencySymbol ').replaceFirst("-", "- ");
    }
    return formattedValue;
  }

  String formatToK(double value) {
    double absValue = value.abs();
    if (absValue < 1000) {
      return value.toString();
    }
    double result = value / 1000;
    return '${result.toStringAsFixed(1)}K';
  }

  String formatToPercentage(double value) {
    if (value % 1 == 0) {
      return '${value.toInt()}%';
    } else {
      return '${value.toStringAsFixed(2)}%';
    }
  }

  String minifyGraphQuery(String query) {
    return query.replaceAll(RegExp(r'\s+'), ' ').trim().replaceAll("\n", "").replaceAll("\"", "\"");
  }

  String sanitizeHtml(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }

  bool checkIfFullNumber(String text) {
    return RegExp(r'^\d+$').hasMatch(text);
  }
}