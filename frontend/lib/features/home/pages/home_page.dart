import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/widget/app_color.dart';
import 'package:frontend/core/widget/app_text.dart';
import 'package:frontend/features/auth/cubit/auth_cubit.dart';
import 'package:frontend/features/home/cubit/add_new_task_cubit.dart';
import 'package:frontend/features/home/pages/add_new_task_page.dart';
import 'package:frontend/features/home/widgets/date_selector.dart';
import 'package:frontend/features/home/widgets/task_card.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user=context.read<AuthCubit>().state as AuthLoggedIn;
    context.read<AddNewTaskCubit>().getAllTask(token: user.user.token);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: AppText.heading("My task")),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewTaskPage.route());
            },
            icon: Icon(CupertinoIcons.add),
          ),
        ],
      ),

      body: BlocBuilder<AddNewTaskCubit, AddNewTaskState>(
        builder: (context, state) {
          if (state is AddNewTaskLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is AddNewTaskError) {
            return Center(child: Text(state.error));
          }
          if (state is GetTaskSuccess) {
            final tasks = state.tasks;
            Column(
              children: [
                // date selector
                DateSelector(),

                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Row(
                        children: [
                          Expanded(
                            child: TaskCard(
                              color: task.color,
                              headerText: task.title,
                              descriptionText:
                                 task.description,
                            ),
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: strengthColor(
                                task.color,
                                0.69,
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding:  EdgeInsets.all(10.0),
                          //   child: AppText.highlight(DateFormat.jm().format(task.dueAt )),
                          // ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
