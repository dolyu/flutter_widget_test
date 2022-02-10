import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:widget_test/ctrl/grid_ctrl.dart';
//import 'package:get/get.dart';

// ignore: must_be_immutable
class GridPage extends StatelessWidget {
  GridPage({Key? key}) : super(key: key);
  late PlutoGridStateManager stateManager;
  Future<bool> loadData() async {
    await Future.delayed(const Duration(milliseconds: 500));

    GridCtrl.to.rows.value = [
      PlutoRow(
        cells: {
          'id': PlutoCell(value: 'user1'),
          'name': PlutoCell(value: 'Mike'),
        },
      ),
      PlutoRow(
        cells: {
          'id': PlutoCell(value: 'user2'),
          'name': PlutoCell(value: 'Jack'),
        },
      ),
      PlutoRow(
        cells: {
          'id': PlutoCell(value: 'user3'),
          'name': PlutoCell(value: 'Suzi'),
        },
      ),
    ];
    debugPrint('하하하');

    return true;
  }

  modify(int row, String field, String value) async {
    stateManager.rows[row].cells[field]!.value = value;
    //stateManager.currentCell!.value = '123';
    debugPrint('변경');
    stateManager.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    GridCtrl.to.columns.value = [
      PlutoColumn(
        title: 'Id',
        field: 'id',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableRowChecked: false,
        enableRowDrag: true,
      ),
      PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('grid Test')),
      body: FutureBuilder(
          future: loadData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            await GridCtrl.to.add('111', '11111');
                            stateManager.notifyListeners();
                            //await loadData();
                          },
                          child: const Text('추가')),
                      TextButton(
                          onPressed: () async {
                            await GridCtrl.to.del();
                          },
                          child: const Text('삭제')),
                      TextButton(
                          onPressed: () async {
                            await GridCtrl.to.modify(stateManager);
                            stateManager.notifyListeners();
                          },
                          child: const Text('수정')),
                    ],
                  ),
                  Expanded(
                    child: PlutoGrid(
                      columns: GridCtrl.to.columns,
                      rows: GridCtrl.to.rows,
                      mode: PlutoGridMode.selectWithOneTap,

                      // columnGroups: columnGroups,
                      onLoaded: (PlutoGridOnLoadedEvent event) {
                        event.stateManager
                            .setSelectingMode(PlutoGridSelectingMode.row);
                        debugPrint(
                            'selecting Mode ${event.stateManager.selectingMode}');
                        stateManager = event.stateManager;
                      },
                      onChanged: (PlutoGridOnChangedEvent event) {
                        debugPrint('event $event');
                      },

                      configuration: const PlutoGridConfiguration(
                        enableColumnBorder: true,
                      ),
                      onSelected: (PlutoGridOnSelectedEvent event) {
                        String value = '';
                        if (event.cell == null) return;
                        final row = event.cell!.row.sortIdx;
                        if (row == null) return;
                        String field = event.cell!.column.field;
                        String selectedValue = event.cell!.value;

                        debugPrint(
                            'onselected $row  / $field / $selectedValue}');
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('식수인원'),
                                content: TextField(
                                  decoration: const InputDecoration(
                                    labelText: 'Input',
                                  ),
                                  controller: TextEditingController(
                                      text: selectedValue),
                                  onChanged: (text) {
                                    value = text;
                                    debugPrint('text $text');
                                  },
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel')),
                                  TextButton(
                                      onPressed: () {
                                        modify(row, field, value);
                                        stateManager.notifyListeners();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK')),
                                ],
                              );
                            });
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

class LoadWidget extends StatelessWidget {
  const LoadWidget({
    Key? key,
    this.isLoading = false,
    this.isEmpty = false,
    this.indicator,
    required this.child,
  }) : super(key: key);

  final bool isLoading;
  final bool isEmpty;
  final Widget? indicator;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return indicator ?? Loading.circular();
    } else if (isEmpty) {
      return const SizedBox.shrink();
    } else {
      return child;
    }
  }
}

class Loading {
  static Widget circular({double opacity = 1.0}) {
    return Container(
      // width: width,
      color: Colors.white.withOpacity(opacity),
      child: const Directionality(
        textDirection: TextDirection.ltr,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
