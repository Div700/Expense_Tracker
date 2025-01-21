import 'package:expense_tracker/presentation/widgets/Expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
var kColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));
void main()
{
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp])
    .then((fn){

      runApp(MaterialApp(
      theme: ThemeData().copyWith (
      colorScheme: kColorScheme,
      appBarTheme: AppBarTheme().copyWith(
      backgroundColor: kColorScheme.onPrimaryContainer,
      foregroundColor: kColorScheme.primaryContainer,
      )
    ),
    home: Expenses(),));
    });
}