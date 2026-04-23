import 'package:dio/dio.dart';
import 'package:flutter_advanced_concepts/first_page.dart';
import 'package:flutter_advanced_concepts/login_screen.dart';
import 'package:flutter_advanced_concepts/user_page.dart';
import 'package:go_router/go_router.dart';

class RoutingSetup {

  final Dio dio;
  RoutingSetup(this.dio);

  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const FirstPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(dio: dio),
      ),
      GoRoute(
        path: '/user',
        builder: (context, state) => const UserPage(),
      )

    ],
  );

}
