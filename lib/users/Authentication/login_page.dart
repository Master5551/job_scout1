import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_scout/Controller/login_controller.dart';
import 'package:job_scout/Home/welcome_screen.dart';
import 'package:job_scout/components/my_button.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:job_scout/users/Authentication/forgot_password_screen.dart';
import 'package:job_scout/users/Authentication/verified_page.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: loginController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.002,
              ),
              Text(
                'Welcome to Job Scout App',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: loginController.emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}')
                        .hasMatch(value)) {
                      return 'Please enter a valid Email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Please enter email",
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade400,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: loginController.passwordController,
                  obscureText: !loginController.isPasswordVisible.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      loginController.isPasswordValid.value = true;
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Please enter your password",
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        loginController.togglePasswordVisibility();
                      },
                      icon: Obx(() => Icon(
                        loginController.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      )),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade400,
                    filled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(foregroundColor: Colors.teal),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgotPasswordScreen()));
                        },
                        child: const Text('Forgot Password'))
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              MyButton(
                onTap: () {
                  loginController.signInWithEmailAndPassword();
                  loginController.submitForm();
                },
                buttonText: 'Sign In',
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const Text('Or Continue with'),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Column(
                children: [
                  SignInButton(
                    Buttons.Google,
                    onPressed: () {
                      loginController.signInWithGoogle();
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  SignInButton(
                    Buttons.GitHub,
                    onPressed: () {
                      loginController.signInWithGitHub();
                    },
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not A Member?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(foregroundColor: Colors.teal),
                      onPressed: () {
                        Get.toNamed('/searchpage');
                      },
                      child: const Text(
                        'Register Here',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
