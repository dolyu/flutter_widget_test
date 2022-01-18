import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/model/common.dart';
import 'package:widget_test/page/compute_page.dart';

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

class CommonCtrl extends GetxController {
  static CommonCtrl get to => Get.find();
  RxList<QQQQ> q = RxList.empty(growable: true);
  RxString sss = ''.obs;

  Future<bool> start1() async {
    var receivePort = ReceivePort();
    await Isolate.spawn(echo, receivePort.sendPort);

    // The 'echo' isolate sends it's SendPort as the first message
    var sendPort = await receivePort.first;

    var msg = await sendReceive(sendPort, "foo");
    debugPrint('received $msg');
    msg = await sendReceive(sendPort, "bar");
    debugPrint('received $msg');
    return true;
  }

// the entry point for the isolate
  echo(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    var port = ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (var msg in port) {
      var data = msg[0];
      SendPort replyTo = msg[1];
      replyTo.send(data);
      if (data == "bar") port.close();
    }
  }

  /// sends a message on a port, receives the response,
  /// and returns the message
  Future sendReceive(SendPort port, msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }
}
