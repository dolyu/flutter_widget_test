import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/ctrl/chart_test_ctrl.dart';
import 'package:widget_test/ctrl/common._ctrl.dart';
import 'package:widget_test/ctrl/file_view_ctrl.dart';
import 'package:widget_test/ctrl/range_slider_ctrl.dart';
import 'package:widget_test/model/common.dart';
import 'package:widget_test/model/config_wr.dart';
import 'package:widget_test/model/file_view.dart';
import 'package:widget_test/page/chart_test.dart';
import 'package:widget_test/page/compute_page.dart';
import 'package:widget_test/page/range_slider_test.dart';

void main() {
  Get.put(FileViewCtrl());
  Get.put(ChartTestCtrl());
  Get.put(RangeSliderCtrl());
  Get.put(CommonCtrl());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter WGS Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      //   home: const MyHomePage(title: 'WGS Widget Test'),
      //routes: {"/"},
      getPages: [
        GetPage(
            name: "/",
            page: () => const MyHomePage(title: 'WGS Widget Test'),
            transition: Transition.zoom),
        GetPage(
            name: "/computeTest",
            page: () => const ComputeTest(),
            binding: BindingsBuilder(() {
              Get.put(CommonCtrl());
            })),
      ],
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
            // Obx(() => Text(
            //       CommonCtrl.to.sss.value,
            //     )),
            ElevatedButton(
                onPressed: () async {
                  //await compute(CommonCtrl.to.computeTest, 1);
                  //CommonCtrl.to.computeTest(11);
                  Get.to(const ComputeTest());
                },
                //child: Text(CommonCtrl.to.sss.value)),
                child: const Text('compute Test Page')),
            SizedBox(
              height: 100,
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
            const RangeSliderTest(),
          ],
        ),
      ),

      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            heroTag: '1',
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
              heroTag: '2',
              onPressed: () {
                FileViewCtrl.to.fvs.removeLast();
              },
              tooltip: 'Delete',
              child: const Icon(Icons.remove)),
          FloatingActionButton(
              heroTag: '3',
              onPressed: () {
                RangeSliderCtrl.to.firstLine.clear();
                for (var i = 0; i < 2048; i++) {
                  RangeSliderCtrl.to.firstLine.add((180.02 + (i * 0.25)));
                }
              },
              tooltip: 'add RangeSlider firstLine',
              child: const Icon(Icons.ac_unit)),
          const SizedBox(width: 20),
          ElevatedButton(
              onPressed: () async {
                ConfigWR writeConfig = ConfigWR.init();
                writeConfig.viz.s[3].comPort = 22;
                File file = File("./setting.json");
                debugPrint('writeConfig ${writeConfig.toJson()}');
                await file.writeAsString(writeConfig.toJson(),
                    mode: FileMode.write);
              },
              child: const Text('write json')),
          const SizedBox(width: 20),
          ElevatedButton(
              onPressed: () async {
                File file = File("./setting.json");
                String data = file.readAsStringSync();
                ConfigWR loadConfig = ConfigWR.fromJson(data);
                debugPrint('ConfigWR $loadConfig');
                debugPrint(
                    'ConfigWR Viz1 Comport ${loadConfig.viz.s[3].comPort}');
              },
              child: const Text('load json')),
          const SizedBox(width: 20),
          ElevatedButton(
              onPressed: () async {
                List<double> a = List.filled(5, 0);
                a[1] = 0.0;
              },
              child: const Text('load json')),
          const SizedBox(width: 20),
          ElevatedButton(
              onPressed: () async {
                for (var i = 0; i < 5; i++) {
                  CommonCtrl.to.q.add(QQQQ(
                      id: i.toString(),
                      name: i.toString(),
                      zzzz: i.toString()));
                }
                debugPrint('qqqq ${CommonCtrl.to.q}');
                RxList<DBIdName> a = CommonCtrl.to.q
                    .map((element) =>
                        DBIdName(id: element.id, name: element.name))
                    .toList()
                    .obs;
                debugPrint('a ${a[0].name}');
              },
              child: const Text('load DBIdName')),
          const SizedBox(width: 20),
          ElevatedButton(
              onPressed: () async {
                File file = File("./wef.csv");
                List<dynamic> initData = [
                  "FileFormat : 1",
                  "Save 하하하 : ",
                  "Wavelength : "
                ];
                List<List<double>> fileData = [];
                for (var i = 0; i < 5; i++) {
                  fileData.add([]);
                  for (var ii = 0; ii < 100; ii++) {
                    fileData[i].add(i * ii * 0.1);
                  }
                }

                String all = initData.join('\n') +
                    '\n' +
                    "Time호호호" +
                    '\n' +
                    fileData.map((line) => line.join(",")).join('\n');
                //String credentials = "username:password";
                Codec<String, String> stringToBase64 = utf8.fuse(base64);
                String encoded =
                    stringToBase64.encode(all); // dXNlcm5hbWU6cGFzc3dvcmQ=
                String decoded = stringToBase64.decode(encoded);
                //Uint8List a = base64Decode(all);
                debugPrint('wwef $encoded $decoded');
                //await file.writeAsBytes(encoded);
                await file.writeAsString(all, encoding: const SystemEncoding());
                //await file.writeAsString('하하하', mode: FileMode.write, );
              },
              child: const Text('한글파일쓰기')),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
