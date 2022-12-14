import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/ConsumerTestPage.dart';
import 'package:untitled/TestPage.dart';
import 'package:untitled/Test_Provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Provider를 여러개 쓰는 경우 MultiProvider 근데 보통 하나의 앱에 프로바이더는 수두룩하게 쓰이니까...
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> TestProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ConsumerTestPage(title: 'Consumer Demo Test Page',)
        // const TestPage(title: 'Provider Demo Test Page'),
      ),
    );
  }
}

