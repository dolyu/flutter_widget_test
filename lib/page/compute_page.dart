import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:widget_test/ctrl/common._ctrl.dart';

dynamic aa;
late Isolate isolate;

class ZZZZZ {
  int a;
  int b;
  ZZZZZ({
    required this.a,
    required this.b,
  });

  @override
  String toString() => 'ZZZZZ(a: $a, b: $b)';
}

void start(a) async {
  ReceivePort receivePort =
      ReceivePort(); //port for isolate to receive messages.
  isolate = await Isolate.spawn(runTimer, receivePort.sendPort);
  receivePort.listen((data) {
    List<ZZZZZ> asdf = [];
    asdf.assignAll(data);
    debugPrint('Receiving: $asdf, ');
    //a.sss.value = data[10].toString();
  });
}

void runTimer(SendPort sendPort) {
  int counter = 0;
  Timer.periodic(const Duration(seconds: 1), (Timer t) {
    counter++;
    String msg = 'notification ' + counter.toString();
    //debugPrint('Sending: ' + msg + ' -');
    List<ZZZZZ> aaaa = [];
    for (int i = 0; i < 100; i++) {
      aaaa.add(ZZZZZ(a: i, b: counter));
    }
    sendPort.send(aaaa);
  });
  //listen
}

void stop() {
  if (isolate != null) {
    debugPrint('Stopping Isolate...');
    isolate.kill(priority: Isolate.immediate);
    //isolate = null;
  }
}

class ComputeTest extends StatelessWidget {
  const ComputeTest({Key? key}) : super(key: key);

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
                  //aa = Get.find<CommonCtrl>();
                  //await compute(computeTest, aa);
                  start(CommonCtrl.to);
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
                  stop();
                },
                child: const Text('stop'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
