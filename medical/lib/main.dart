import 'package:flutter/material.dart';
import 'package:medical/providers/user_provider.dart';
import 'package:medical/screens/home_screen.dart';
import 'package:medical/screens/welcome_screen.dart';
import 'package:medical/services/auth_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical Information',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider.of<UserProvider>(context).user.token.isEmpty ? const WelcomeScreen() : const HomeScreen(),
    );
  }
}
