
import '../../modules/login_screen/login_screen.dart';
import '../networks/local/cache_helper.dart';
import 'components.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((onValue){
    if(onValue){
      navigateAndFinish(context, LoginScreen());
    }
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

//token of user
String token = '';
bool isDark = false;
