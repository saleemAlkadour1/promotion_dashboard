import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/shared_preferences.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';

class LocaleController extends GetxController {
  static String languageCode = Get.deviceLocale!.languageCode;

  static changeLang(String langCode) async {
    languageCode = langCode;
    Shared.setValue("langCode", langCode);
    Locale locale = Locale(langCode);
    ltr = myLanguages[langCode]!['dir'] == 'ltr';
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    getLocalLang();
    super.onInit();
  }

  static Locale getLocalLang() {
    String myLangCode = Shared.getValue(
      'langCode',
      initialVAlue: Get.deviceLocale!.languageCode,
    );

    if (!myLanguages.containsKey(myLangCode)) {
      myLangCode = 'en';
    }

    ltr = myLanguages[myLangCode]!['dir'] == 'ltr';

    return Locale(myLangCode);
  }
}

late bool ltr;
Map<String, Map> myLanguages = {
  'en': {
    'name': 'english',
    'dir': 'ltr',
    'image': Assets.imagesPicturesEnglish,
  },
  'ar': {'name': 'arabic', 'dir': 'rtl', 'image': Assets.imagesPicturesArabic},
  'tr': {
    'name': 'turkey',
    'dir': 'ltr',
    'image': Assets.imagesPicturesTurkey,
  },
};
