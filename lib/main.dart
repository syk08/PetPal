import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/util.dart';
import 'core/router.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // statusBarColor: Colors.transparent, // top bar color
      ),
    );
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: CustomColors.Yellow,
        fontFamily: 'Poppins',
      ),
     routerConfig: router,
    );
  }
}
