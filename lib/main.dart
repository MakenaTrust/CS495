import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'bandedBoot_navigation/welcome_screen.dart';
import 'bandedBoot_navigation/login_navigation/login_screen.dart';
import 'bandedBoot_navigation/registration_navigation/signup_screen.dart';
import 'home_navigation/home_screen.dart';
import 'bandedBoot_navigation/registration_navigation/accType_screen.dart';
import 'bandedBoot_navigation/registration_navigation/holder_screen.dart';
import 'home_navigation/profile_navigation/eventCreation_screen.dart';
import 'home_navigation/profile_navigation/eventCreationSuccess_screen.dart';
import 'home_navigation/profile_navigation/profileMain_screen.dart';
import 'home_navigation/profile_navigation/profileUpdate_screen.dart';
import 'home_navigation/profile_navigation/profileUpdateSuccess_screen.dart';
import 'home_navigation/wallet_navigation/walletMain_screen.dart';
import 'home_navigation/search_navigation/searchMain_screen.dart';
import 'home_navigation/transfer_navigation/transferMain_screen.dart';
import 'home_navigation/profile_navigation/nftCreation_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    // only return the child without warping it with animations
    return child!;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: NoTransitionsBuilder(),
            TargetPlatform.iOS: NoTransitionsBuilder(),
          },
        ),
      ),
      title: 'WristBands',
      initialRoute: 'welcome_screen', //'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'accType_screen': (context) => const AccTypeScreen(),
        'registration_screen': (context) => RegistrationScreen(picked: false),
        'login_screen': (context) => const LoginScreen(),
        'holder_screen': (contect) => HolderScreen(),
        'home_screen': (context) => const HomeScreen(
              title: '',
            ),
        'eventCreation_screen': (context) => EventCreationScreen(
              picked: false,
            ),
        'eventCreationSuccess_screen': (context) =>
            EventCreationSuccessScreen(),
        'profileMain_screen': (context) => Profile(),
        'profileUpdate_screen': (context) => ProfileUpdateScreen(),
        'profileUpdateSuccess_screen': (context) =>
            ProfileUpdateSuccessScreen(),
        'searchMain_screen': (context) => Search(),
        'walletMain_screen': (context) => Wallet(),
        'transferMain_screen': (context) => Transfer(),
        'nft_screen': (context) => Blockchain()
      },
    );
  }
}
