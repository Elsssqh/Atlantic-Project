import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:atlanticc/common/common.dart';
import 'package:atlanticc/common/loading_page.dart';
import 'package:atlanticc/constants/constants.dart';
import 'package:atlanticc/features/auth/controller/auth_controller.dart';
import 'package:atlanticc/features/auth/view/login_view.dart';
import 'package:atlanticc/features/auth/widgets/auth_field.dart';
import 'package:atlanticc/theme/palette.dart';
 

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );


  const SignUpView({super.key});
 

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}


class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
 

  @override
  void dispose() {

    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }
 

void onSignUp() {
  final email = emailController.text;
  final password = passwordController.text;
  final confirmPassword = confirmPasswordController.text;


  if (passwordController.text != confirmPasswordController.text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Password and Confirm Password do not match.',
          style: TextStyle(
            fontSize: 16,
          ),
        ),

        backgroundColor: Color.fromARGB(255, 91, 124, 202),
        duration: Duration(seconds: 2), // Adjust the duration as needed
      ),
    );

  } else {
    final res = ref.read(authControllerProvider.notifier).signUp(

      email: emailController.text,
      password: passwordController.text,
      context: context,
    );

  }

}


  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Column(
                  children: [
                    const Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 45),

                    AuthField(
                      controller: emailController,
                      hintText: 'Your Email',
                      titleText: 'Email Address',
                      isPassword: false,
                      backgroundColor: Colors.blue,
                    ),

                    const SizedBox(height: 10),

                    AuthField(
                      controller: passwordController,
                      hintText: 'Your Password',
                      titleText: 'Password',
                      isPassword: true,
                      backgroundColor: Colors.blue,
                    ),
 
                    const SizedBox(height: 10),

                    AuthField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Your Password',
                      titleText: 'Confirm Password',
                      isPassword: true,
                      backgroundColor: Colors.blue,
                    ),

                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.topRight,
                      child: RoundedSmallButton(
                        onTap: onSignUp,
                        label: 'Sign Up',
                      ),
                    ),

                    const SizedBox(height: 30),

                    RichText(
                        text: TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(
                        color: Pallete.whiteColor,
                        fontSize: 16,
                      ),

                      children: [
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),

                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                LoginView.route(),
                              );

                            },

                        ),

                      ],

                    )),

                  ],

                ),

              ),

            ),

    );

  }

}