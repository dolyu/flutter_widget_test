import 'package:get/get.dart';
import 'package:widget_test/model/file_view.dart';

class FileViewCtrl extends GetxController {
  static FileViewCtrl get to => Get.find();
  RxList<FileView> fvs = RxList.empty(growable: true);
}
