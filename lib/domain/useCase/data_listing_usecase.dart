import 'package:intl/intl.dart';

String formatTimeRange(DateTime startTime) {
  final String time = DateFormat.jm().format(startTime);
  return time;
}

double calculatePlatformFee(double totalAmount) {
  return (totalAmount * 0.01);
}

String formatDate(DateTime dateTime) {
  final dateFormat = DateFormat('dd MMM yyyy');
  return dateFormat.format(dateTime);
}

DateTime dateConverter(String dateString) {
  final DateFormat formatter = DateFormat("dd/MM/yyyy - HH:mm");
  return formatter.parse(dateString);
}

String amount(double totalAmount) {
  final onePercent = totalAmount * 0.01;
  return onePercent.toStringAsFixed(2);
}

