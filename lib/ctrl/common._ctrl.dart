import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/model/common.dart';
import 'package:widget_test/model/viz_model.dart';
// import 'package:widget_test/page/compute_page.dart';

// Future<bool> computeTest(ctrl) async {
//   try {
//     debugPrint('시작');
//     aa.sss.value = 'asdf';
//     //sleep(const Duration(seconds: 3));
//     //rl
//     debugPrint('끝');
//     return true;
//   } catch (e) {
//     e.toString();
//     return false;
//   }
// }

dynamic sendPort2;
Future<bool> start1() async {
  var receivePort = ReceivePort();
  await Isolate.spawn(echo, receivePort.sendPort);

  // The 'echo' isolate sends it's SendPort as the first message
  sendPort2 = await receivePort.first;

  //await sendReceive(sendPort, "foo");
  // debugPrint('received $msg');
  //await sendReceive(sendPort, "bar");
  // debugPrint('received $msg');
  return true;
}

// the entry point for the isolate
echo(SendPort sendPort) async {
  // Open the ReceivePort for incoming messages.
  debugPrint('echo start');
  var port = ReceivePort();
  debugPrint('echo 1');
  // Notify any other isolates what port this isolate listens to.
  sendPort.send(port.sendPort);
  debugPrint('echo 2');
  await for (var msg in port) {
    debugPrint('echo  3');
    var data = msg;
    SendPort replyTo = msg[1];
    replyTo.send(data);
    debugPrint('echo  4 $data');
    if (data[0] == "10") port.close();
  }
  debugPrint('echo end');
}

/// sends a message on a port, receives the response,
/// and returns the message
Future sendReceive(msg) async {
  ReceivePort response = ReceivePort();
  //var port = await response.f
  sendPort2.send([msg, response.sendPort]);
  return response.first;
}

class CommonCtrl extends GetxController {
  static CommonCtrl get to => Get.find();
  RxList<QQQQ> q = RxList.empty(growable: true);
  RxString sss = ''.obs;
  List<VizChannel> vizchannel = RxList.empty();
  RxInt iii = 0.obs;

  dynamic sendPort;
}
