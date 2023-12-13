import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yomu_reader_1/components/my_button.dart';
import 'package:yomu_reader_1/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // login method
  void signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {

      if(passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        showErrorMess("Password don't match!");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMess(e.code);
    }
  }

  void showErrorMess(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(height: 25),
                // app name
                const Text(
                  "Yomu Reader",
                  style: TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                ),

                const SizedBox(height: 10),
                // password textfield
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPasswordController,
                ),

                const SizedBox(height: 25),

                // sign in button

                MyButton(text: "Register", onTap: signUp),

                // dont have an account? register here
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          " Login Now!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
