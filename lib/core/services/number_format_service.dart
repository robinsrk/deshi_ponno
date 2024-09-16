import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberFormatterService {
  String formatCurrency(num price, BuildContext context) {
    final String locale = Localizations.localeOf(context).toString();
    final NumberFormat format = NumberFormat.currency(
      locale: locale.toString(),
      symbol: NumberFormat.simpleCurrency(locale: "bn").currencySymbol,
      customPattern: '#,##0.00 ¤',
    );
    return format.format(price).replaceAll(' ', ' ');
  }
}
