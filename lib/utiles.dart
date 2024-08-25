import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class Utiles{
  static const int appId = 508947831;
  static const String appSignIn = "782a7c00738628020b2fddbf891668b79db4248556ba123a6776e271a7255080";

  // baseurl
  //run django project with python manage.py runserver 0.0.0.0:8000
  //my mobile http://10.27.1.5:8000
  //emulatur 10.0.2.2
  //class 5 192.168.137.232
  // alaaphone  192.168.110.123
  // moaaz 192.168.43.161
  static const String baseurl = 'http://10.0.2.2:8000';
}



class SecureStorage {

  final storage = new FlutterSecureStorage();
  Future<void> save (String key , String value)async { //
    await storage.write(key: key, value: value);

  }
  Future<String?> read (String key )async { // read the token and give me value
    return  await storage.read(key: key);

  }
}



