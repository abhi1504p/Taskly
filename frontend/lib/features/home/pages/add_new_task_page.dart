import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/widget/app_button.dart';
import 'package:frontend/core/widget/app_input_field.dart';
import 'package:frontend/core/widget/app_text.dart';
import 'package:frontend/features/auth/cubit/auth_cubit.dart';
import 'package:frontend/features/home/cubit/add_new_task_cubit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewTaskPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => AddNewTaskPage());
  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Color selectedColor = Color.fromARGB(246, 222, 194, 1);
  final formKey = GlobalKey<FormState>();

  void createNewTask() async {
    AuthLoggedIn user = context.read<AuthCubit>().state as AuthLoggedIn;
    if (formKey.currentState!.validate()) {
      context.read<AddNewTaskCubit>().createNewTask(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        color: selectedColor,
        token: user.user.token,
        dueAt: selectedDate,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: AppText.highlight("Add New Task")),
        actions: [
          GestureDetector(
            onTap: () async {
              final _selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 90)),
              );
              if (_selectedDate != null) {
                setState(() {
                  selectedDate = _selectedDate;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText.highlight(
                DateFormat("d-MM-y").format(selectedDate),
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<AddNewTaskCubit, AddNewTaskState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state is AddNewTaskError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
            context.read<AuthCubit>().reset();
          } else if (state is AddNewTaskSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Task add Successfully")));
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is AddNewTaskLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppInputField(
                      labeltext: "Title",
                      isDropdown: false,
                      controller: titleController,
                      obscureTexts: false,
                      validate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Tittle cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: AppInputField(
                      maxlines: 4,
                      validate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Description cannot be empty";
                        }
                        return null;
                      },
                      labeltext: "Description",
                      isDropdown: false,
                      controller: descriptionController,
                      obscureTexts: false,

                    ),
                  ),
                  SizedBox(height: 2),

                  AppText.heading("Select Color", color: Colors.black87),

                  ColorPicker(
                    subheading: AppText.title("Select a different shade"),
                    onColorChanged: (Color color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    color: selectedColor,
                    pickersEnabled: {ColorPickerType.wheel: true},
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(12.0),

                    child: AppButton(
                      type: ButtonType.filled,
                      text: "Submit",
                      color: Colors.black,
                      onPressed: createNewTask,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
