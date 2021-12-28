import 'package:get/get.dart';
import 'package:widget_test/page/chart_test.dart';

class ChartTestCtrl extends GetxController {
  static ChartTestCtrl get to => Get.find();
  RxList<ChartTest> fvs = RxList.empty(growable: true);
}
