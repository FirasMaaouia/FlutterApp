import 'package:esprit/screens/chat/chat_screen.dart';
import 'package:esprit/screens/courses/coursesRoute.dart';
import 'package:flutter/widgets.dart';
import 'package:esprit/screens/complete_profile/complete_profile_screen.dart';
import 'package:esprit/screens/forgot_password/forgot_password_screen.dart';
import 'package:esprit/Home/HomeScreen/home.dart';
import 'package:esprit/screens/login_success/login_success_screen.dart';
import 'package:esprit/screens/otp/otp_screen.dart';
import 'package:esprit/screens/profile/profile_screen.dart';
import 'package:esprit/screens/sign_in/sign_in_screen.dart';
import 'package:esprit/screens/splash/splash_screen.dart';
import 'package:esprit/screens/forgot_password/otp/otp_screen.dart';
import 'package:esprit/order/userOrderScreen.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  CoursesScreen.routeName: (context) => CoursesScreen(),
  ChatNav.routeName: (context) => ChatNav(),
  OrdersScreen.routeName: (context) => OrdersScreen(),
  ForgotScreen.routeName: (context) => ForgotScreen(),
};
