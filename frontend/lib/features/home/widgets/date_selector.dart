import 'package:flutter/material.dart';
import 'package:frontend/core/widget/app_color.dart';
import 'package:frontend/core/widget/app_text.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int weekOffset = 0;
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final weekDates = generateWeekDates(weekOffset);
    String monthName = DateFormat("MMMM").format(weekDates.first);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    weekOffset--;
                  });
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              AppText.heading(monthName),
              IconButton(
                onPressed: () {
                  setState(() {
                    weekOffset++;
                  });
                },
                icon: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 80,
            child: ListView.builder(
              itemCount: weekDates.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final date = weekDates[index];
                bool isSelected =
                    DateFormat("d").format(selectedDate) ==
                        DateFormat("d").format(date) &&
                    selectedDate.month == date.month &&
                    selectedDate.year == date.year;
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedDate=date;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.deepOrange : null,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 2,
                        color: isSelected
                            ? Colors.deepOrange
                            : Colors.grey.shade300,
                      ),
                    ),
                    width: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText.title(
                          DateFormat("d").format(date),
                          color: isSelected ? Colors.white : null,
                        ),
                        SizedBox(height: 5),
                        AppText.highlight(
                          DateFormat("E").format(date),
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
