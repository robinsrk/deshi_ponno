import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberFormatterService {
  String formatCurrency(num price, BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final format = NumberFormat.currency(
      locale: locale.toString(),
      symbol: NumberFormat.simpleCurrency(locale: "bn").currencySymbol,
      customPattern: '#,##0.00 ¤',
    );
    return format.format(price).replaceAll(' ', ' ');
  }
}
