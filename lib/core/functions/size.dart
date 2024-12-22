import 'package:get/get.dart';

double getHeiht() {
  return Get.size.height;
}

double getWidth() {
  return Get.size.width;
}

double width(x) {
  return x * getWidth() / 392.727;
}

double height(x) {
  return x * getHeiht() / 826.909;
}

double emp(x) {
  var r = ((x * getHeiht() / 826.909) + (x * getWidth() / 392.727)) / 2;
  return r;
}
