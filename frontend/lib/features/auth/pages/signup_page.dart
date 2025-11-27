import 'package:flutter/material.dart';
import 'package:frontend/core/widget/app_button.dart';
import 'package:frontend/core/widget/app_input_field.dart';
import 'package:frontend/core/widget/app_text.dart';
import 'package:frontend/features/auth/cubit/auth_cubit.dart';
import 'package:frontend/features/auth/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => SignInPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();

    super.dispose();
  }

  void signUpUser() {
    if (formKey.currentState!.validate()) {
      //store user data
      context.read<AuthCubit>().signUp(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
              context.read<AuthCubit>().reset();
            } else if (state is AuthSignUp) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Account Created ! Login Now")),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator(color: Colors.red,));
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.heading("Sign Up.", fontSize: 45),
                    SizedBox(height: 35),
                    AppInputField(
                      validate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Name field Cannot be Empty";
                        } else {
                          return null;
                        }
                      },
                      obscureTexts: false,
                      labeltext: "Name",
                      controller: nameController,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 12),
                    AppInputField(
                      validate: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.trim().contains("@")) {
                          return "Email should be proper";
                        } else {
                          return null;
                        }
                      },
                      obscureTexts: false,
                      labeltext: "Email",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 12),
                    AppInputField(
                      validate: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.trim().length <= 6) {
                          return "password should be more than 6 letter";
                        } else {
                          return null;
                        }
                      },
                      obscureTexts: true,
                      labeltext: "Password",
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      maxlines: 1,
                    ),
                    SizedBox(height: 12),
                    AppButton(
                      type: ButtonType.filled,
                      text: "Sign Up",
                      width: double.infinity,
                      color: Colors.black,
                      onPressed: signUpUser,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText.body("Already have an Account?"),
                        SizedBox(width: 5),
                        GestureDetector(
                          child: AppText.highlight(
                            "Sign In",
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.of(context).push(SignupPage.route());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
