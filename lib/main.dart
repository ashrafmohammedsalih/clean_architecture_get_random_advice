import 'package:flutter/material.dart';
import 'package:get_advices/theme.dart';
import 'injection.dart' as di;
import 'application/pages/advice/advice_page.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark ,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const AdvicerPageWrapperProvider(),
    );
  }
}