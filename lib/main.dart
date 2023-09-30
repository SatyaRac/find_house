import 'package:find_house/pages/splash_page.dart';
import 'package:find_house/providers/space_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SpaceProvider(),
      child: MaterialApp(
        home: SplashPage(),
      ),
    );
  }
}
