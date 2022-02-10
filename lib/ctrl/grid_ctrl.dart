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

  modify(PlutoGridStateManager stateManager) async {
    int row = stateManager.currentRowIdx!;
    String column = stateManager.currentColumnField!;
    stateManager.rows[row].cells[column]!.value = '123';
    //stateManager.currentCell!.value = '123';
    debugPrint('변경');
  }

  modify2(PlutoGridStateManager stateManager, int row, String field,
      String value) async {
    stateManager.rows[row].cells[field]!.value = value;
    //stateManager.currentCell!.value = '123';
    debugPrint('변경');
    stateManager.notifyListeners();
  }
}
