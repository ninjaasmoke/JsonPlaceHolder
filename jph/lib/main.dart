import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jph/pages/home.dart';

import 'ui/ui_elements.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily:
              GoogleFonts.montserrat(fontWeight: FontWeight.w900).fontFamily,
          textTheme: GoogleFonts.montserratTextTheme(),
          accentColor: UIHelp().accent,
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
