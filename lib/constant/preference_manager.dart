import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  static String loginStatus = "loginStatus";
  static String id = "id";
  static String name = "name";
  static String email = "email";
  static String password = "password";
  static String cpassword = "cpassword";

  ///set Login status
  static Future setLoginStatus(String value) async {
    await getStorage.write(loginStatus, value);
  }

  static getLoginStatus() {
    return getStorage.read(loginStatus);
  }

  ///set id
  static Future setId(String value) async {
    await getStorage.write(id, value);
  }

  static getId() {
    return getStorage.read(id);
  }

  ///set name
  static Future setName(String value) async {
    await getStorage.write(name, value);
  }

  static getName() {
    return getStorage.read(name);
  }///set email
  static Future setEmail(String value) async {
    await getStorage.write(email, value);
  }

  static getEmail() {
    return getStorage.read(email);
  }

  ///set password
  static Future setPassword(String value) async {
    await getStorage.write(password, value);
  }

  static getPassword() {
    return getStorage.read(password);
  }
  ///set password
  static Future setCPassword(String value) async {
    await getStorage.write(cpassword, value);
  }

  static getCPassword() {
    return getStorage.read(cpassword);
  }

  static Future getClear() {
    return getStorage.erase();
  }
}
