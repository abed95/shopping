import 'package:flutter/material.dart';
import 'package:shoping/shared/components/constants.dart';
import 'package:shoping/shared/networks/local/cache_helper.dart';

import '../../shared/components/components.dart';
import '../login_screen/login_screen.dart';

class SettingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(onPressed: ((){
          signOut(context);

        }), child: Text('Logout')),
      ),
    );
  }
}
