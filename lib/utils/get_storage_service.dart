import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

getUid() {
  final box = GetStorage();
  return box.read('uid');
}

saveUserLogin(String uid, bool isLogin) {
  final box = GetStorage();
  box.write('uid', uid);
  box.write('isLogin', isLogin);
}

logout() {
  final box = GetStorage();
  box.remove('uid');
  box.write('isLogin', false);
  Get.offAllNamed('/login');
}

getLoggedIn() {
  final box = GetStorage();
  return box.read('isLogin');
}
