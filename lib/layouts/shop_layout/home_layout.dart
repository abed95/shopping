import 'package:flutter/material.dart';

import '../../modules/login_screen/login_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/networks/local/cache_helper.dart';

class HomeLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saallaa'),
      ),
      body: Center(
        child: TextButton(onPressed: ((){
          CacheHelper.removeData(key: 'token').then((onValue){
            if(onValue){
              navigateAndFinish(context, LoginScreen());
            }
          });

        }), child: Text('Logout')),
      ),
    );
  }
}