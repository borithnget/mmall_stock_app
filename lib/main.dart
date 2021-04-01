import 'package:flutter/material.dart';
import 'package:markarian_sales/pages/splash_screen.dart';
import 'package:markarian_sales/repositories/sale_outstanding_repository.dart';

import 'utils/conection_state_singleton.dart';

void main() {

  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      //home: SaleOutstandingPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: SplashScreen(),
    );


  }
}
