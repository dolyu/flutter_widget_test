import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:widget_test/ctrl/common._ctrl.dart';

dynamic aa;
late Isolate isolate;
bool check = false;

class ZZZZZ extends GetxController {
  static ZZZZZ get to => Get.find();
  int a;
  int b;
  ZZZZZ({
    required this.a,
    required this.b,
  });

  @override
  String toString() => 'ZZZZZ(a: $a, b: $b)';
}

// ZZZZZ zzzz = ZZZZZ(a: 3, b: 4);
// late ReceivePort receivePort;
dynamic sendPort1;
late ReceivePort rp;
late SendPort ssss;
void start(a) async {
  ReceivePort receivePort =
      ReceivePort(); //port for isolate to receive messages.

  // List<dynamic> bbb = [];
  // bbb.add(receivePort.sendPort);

  isolate = await Isolate.spawn(runTimer, receivePort.sendPort);
  //sendPort1 = receivePort.first;

  receivePort.listen((data) {
    if (data is SendPort) {
      debugPrint('sendport들어왔어');
      ssss = data;
    } else {
      debugPrint('aaaaaa: ${data.hashCode.toString()}');
      List<ZZZZZ> asdf = [];
      asdf.assignAll(data);
      //debugPrint('Receiving: $asdf, ');
      a.sss.value = asdf[10].b.toString();
    }
  });
}

void runTimer(SendPort sendPort) async {
  // 0:sendPort
  int counter = 0;
  bool stop = false;
  var port = ReceivePort();
  Timer.periodic(const Duration(seconds: 1), (Timer t) {
    List<ZZZZZ> aaaa = [];
    for (int i = 0; i < 100; i++) {
      aaaa.add(ZZZZZ(a: i, b: counter));
    }
    debugPrint('count ${counter++}');
    //sendPort.send(aaaa);
    if (stop) {
      debugPrint('멈춰');
      port.close();
    }
  });

  sendPort.send(port.sendPort);
  port.listen((msg) {
    debugPrint('제발 $msg');
    stop = true;
  });

  // await for (var msg in port) {
  //   debugPrint('echo  3');
  //   stop = msg[0];
  //   debugPrint('echo  4 $stop');
  //   //if (data[0] == "10") port.close();
  // }
  debugPrint('runTime end');

  //listen
}

void stop() {
  // if (isolate != null) {

  debugPrint('Stopping Isolate...');
  isolate.kill(priority: Isolate.immediate);
  //isolate = null;
  // }
}

void stop1() async {
  ReceivePort response = ReceivePort();
  // var port = await receivePort.first;
  ssss.send([true, response.sendPort]);
}

// Future sendReceive(SendPort port, msg) {
//   ReceivePort response = ReceivePort();
//   port.send([msg, response.sendPort]);
//   return response.first;
// }

// ignore: must_be_immutable
class ComputeTest extends StatelessWidget {
  ComputeTest({Key? key}) : super(key: key);
  int temp = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('compute Test')),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('wef'),
              Text(
                '${CommonCtrl.to.sss}',
              ),
              ElevatedButton(
                onPressed: () async {
                  aa = Get.find<CommonCtrl>();
                  //await compute(computeTest, aa);
                  debugPrint('hash ${aa.hashCode}');
                  start(
                    CommonCtrl.to,
                  );
                },
                child: const Text('gogo'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  //aa = Get.find<CommonCtrl>();
                  //await compute(computeTest, aa);
                  stop1();
                },
                child: const Text('stop'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  //aa = Get.find<CommonCtrl>();
                  //await compute(computeTest, aa);
                  temp++;
                  check = !check;
                  //ReceivePort response = ReceivePort();
                  debugPrint("tempclick $temp $check");
                },
                child: const Text('inc'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  start1();
                },
                child: const Text('start1'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  //CommonCtrl.to.sendReceive(port, msg)
                  // ReceivePort aa = ReceivePort();
                  // var sendPort1 = await aa.first;
                  sendReceive(temp.toString());
                },
                child: const Text('sendReceive'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
