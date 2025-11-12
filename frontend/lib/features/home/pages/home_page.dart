import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/widget/app_color.dart';
import 'package:frontend/core/widget/app_text.dart';
import 'package:frontend/features/home/widgets/date_selector.dart';
import 'package:frontend/features/home/widgets/task_card.dart';

class HomePage extends StatelessWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => HomePage());
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: AppText.heading("My task")),
        actions: [IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.add))],
      ),

      body: Column(
        children: [
          // date selector
          DateSelector(),

          Row(
            children: [
              Expanded(
                child: TaskCard(
                  color: Colors.yellow.shade300,
                  headerText: "Hello",
                  descriptionText:
                      "What is your name What is your name What is your name What is your name What is your name What is your name What is your name ",
                ),
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: strengthColor(Color.fromARGB(246, 222, 194, 1), 0.69),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppText.highlight("10:00 Am"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
