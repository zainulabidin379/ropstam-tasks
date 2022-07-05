import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainulabidin/shared/constants.dart';
import 'services/auth.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zain Ul Abidin',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: FutureBuilder(
            future: authController.tryAutoLogin(),
            builder: (context, authResult) {
              if (authResult.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                );
              } else {
                if (authResult.data == true) {
                  return const HomeScreen();
                }
                return const LoginScreen();
              }
            }),
      ),
    );
  }
}
