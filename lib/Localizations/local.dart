import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": {},
        "tr": {
          "Login": "kayıt olmak",
          "Email": "eposta",
          "Please enter a valid email":
          "lütfen geçerli eposta adresini giriniz",
          "Password": "Şifre",
          "sign in": "kayıt olmak",
          "Sign Up": "Üye olmak",
          "Forgot Password?": "Parolanızı mı unuttunuz?",
          "sign out": "oturumu Kapat",
          "English": "ingilizce",
          "Turkish": "Türkçe"
        },
      };
}
