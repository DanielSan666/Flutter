import 'package:flutter/material.dart';
import 'package:medical/custom_textfield.dart';
import 'package:medical/services/auth_services.dart';
import 'package:medical/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void loginUser() {
    authService.signInUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  void navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
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
              "Hello",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const Text(
              "Sign in!",
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
                    controller: emailController,
                    hintText: 'Email',
                    
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  ElevatedButton(
                    onPressed: loginUser,
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
                      "Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            GestureDetector(
              onTap: navigateToSignUp,
              child: Text(
                "Don’t have an account? Sign up",
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
