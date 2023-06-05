import 'package:flutter/material.dart';
//import 'package:xy_mobil_app/tlog/tlog.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TLOG
    //sl<TLog>().move('');

    return Scaffold(
      // Grafika a Betöltőképernyőre...
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/betoltokepernyo.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
