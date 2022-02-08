import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

class GridCtrl extends GetxController {
  static GridCtrl get to => Get.find();
  RxList<PlutoRow> rows = RxList.empty();
  RxList<PlutoColumn> columns = RxList.empty();
  final RxBool isLoading = false.obs;

  add(idx, value) async {
    isLoading(true);
    await Future.delayed(const Duration(milliseconds: 10));
    rows.add(PlutoRow(
      cells: {
        'id': PlutoCell(value: idx),
        'name': PlutoCell(value: value),
      },
    ));
    debugPrint('data  $rows ${rows.length} ');
    isLoading(false);
    return true;
  }

  del() async {
    isLoading(true);

    if (rows.isNotEmpty) {
      rows.removeAt(0);
      debugPrint('삭제');
    }
    await Future.microtask(
        () => isLoading(false)); //delayed(const Duration(milliseconds: 10));
  }
}
