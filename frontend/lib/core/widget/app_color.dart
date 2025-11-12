import 'package:flutter/material.dart';

class AppColors {
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF637381);
  static const Color textColor = Colors.black;
  static const Color subText = Color(0xFF919EAB);
}

Color strengthColor(Color color, double factor) {
  int r = (color.red * factor).clamp(0, 255).toInt();
  int g = (color.green * factor).clamp(0, 255).toInt();
  int b = (color.blue * factor).clamp(0, 255).toInt();

  return Color.fromARGB(color.alpha, r, g, b);
}

List<DateTime> generateWeekDates(int weekOffset){
  final today=DateTime.now();
  DateTime startOfWeek=today.subtract(Duration(days: today.weekday-1));
  startOfWeek=startOfWeek.add(Duration(days: weekOffset*7));

  return List.generate(7, (index)=>startOfWeek.add(Duration(days: index)));
}