import 'package:get/get.dart';
import 'package:promotion_dashboard/core/localization/languages/ar.dart';
import 'package:promotion_dashboard/core/localization/languages/en.dart';
import 'package:promotion_dashboard/core/localization/languages/tr.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': ar,
        'en': en,
        'tr': tr,
      };
}
