import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/ctrl/chart_test_ctrl.dart';
import 'package:widget_test/ctrl/file_view_ctrl.dart';
import 'package:widget_test/model/file_view.dart';
import 'package:widget_test/page/chart_test.dart';

void main() {
  Get.put(FileViewCtrl());
  Get.put(ChartTestCtrl());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WGS Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'WGS Widget Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class WidgetFileView extends StatelessWidget {
  const WidgetFileView({Key? key, required this.fv}) : super(key: key);
  final FileView fv;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(fv.fileName),
        Obx(
          () => Checkbox(
              value: fv.checked.value,
              onChanged: (value) {
                if (value != null) {
                  fv.checked.value = value;
                  debugPrint('checked $value!');
                }
              }),
        )
      ],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: Obx(() => Scrollbar(
                    isAlwaysShown: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: FileViewCtrl.to.fvs.length,
                      itemBuilder: (context, index) {
                        return WidgetFileView(fv: FileViewCtrl.to.fvs[index]);
                      },
                    ),
                  )),
            ),
            const ChartTest(),
          ],
        ),
      ),

      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              int i = FileViewCtrl.to.fvs.length;
              FileViewCtrl.to.fvs.add(FileView(
                  fileName: '${i.toString()}.xlsx',
                  checked: i % 2 == 1 ? true.obs : false.obs,
                  range: Range(start: i, end: i + 2)));
            },
            tooltip: 'Add',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
              onPressed: () {
                FileViewCtrl.to.fvs.removeLast();
              },
              tooltip: 'Delete',
              child: const Icon(Icons.remove)),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
