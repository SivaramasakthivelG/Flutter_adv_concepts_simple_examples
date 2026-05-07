import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_concepts/providers/position_provider.dart';
import 'package:flutter_advanced_concepts/routing_setup.dart';
import 'package:provider/provider.dart';

void main() {
  final dio = Dio();

  runApp(ChangeNotifierProvider(
      create: (_) => PositionProvider(),
      child: MyApp(dio: dio)
    ),
  );
}

class MyApp extends StatelessWidget {
  final Dio dio;
  const MyApp({super.key,required this.dio});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: RoutingSetup(dio).router,
      title: 'Flutter',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: Colors.blue
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Colors.yellow
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(backgroundColor: Colors.black),
      ),
      themeMode: ThemeMode.system,
    );
  }
}
