import 'package:covid/home.dart';
import 'package:covid/provider/my_provider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MyProvider>(context, listen: false).getAllClinics();
    Provider.of<MyProvider>(context, listen: false).getAllNewCases();
    Provider.of<MyProvider>(context, listen: false).getAllDeathCases();
    Provider.of<MyProvider>(context, listen: false).getPosition(context);

    // Provider.of<MyProvider>(context, listen: false).getAllClinics();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: SplashScreenView(
          navigateRoute: Home(),
          duration: 5000,
          imageSize: 130,
          text: "Covid-19",
          textType: TextType.ColorizeAnimationText,
          textStyle: const TextStyle(
            fontSize: 70.0,
          ),
          colors: const [
            Colors.purple,
            Colors.blue,
            Colors.yellow,
            Colors.red,
          ],
          backgroundColor: Colors.green[100],
        ));
  }
}
