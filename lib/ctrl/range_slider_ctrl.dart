import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RangeSliderCtrl extends GetxController {
  static RangeSliderCtrl get to => Get.find();
  RxList<double> firstLine = RxList.empty();
  Rx<RangeValues> rv = const RangeValues(0.0, 0.0).obs;
  double vStart = 0.0;
  double vEnd = 0.0;
  // Rx
}
