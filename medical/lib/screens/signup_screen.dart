import 'package:flutter/material.dart';
import 'package:medical/custom_textfield.dart';
import 'package:medical/services/auth_services.dart';
import 'package:medical/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final AuthService authService = AuthService();

  void signupUser() {
    authService.signUpUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );
  }

  void navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.pink[100], // Fondo rosa
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1),
            const Text(
              "Register",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const Text(
              "Create an account!",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            SizedBox(height: screenHeight * 0.08),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    hintText: 'Enter your name',
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Enter your email',
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    obscureText: true,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  ElevatedButton(
                    onPressed: signupUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent, // Color del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.3,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            GestureDetector(
              onTap: navigateToLogin,
              child: Text(
                'Ya tienes cuenta? Inicia Sesión',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.04,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
