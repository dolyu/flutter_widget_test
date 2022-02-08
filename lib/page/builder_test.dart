import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:widget_test/ctrl/common._ctrl.dart';

// ignore: must_be_immutable
class BuilderTest extends StatelessWidget {
  BuilderTest({Key? key}) : super(key: key);
  int temp = 0;
  StreamController<String> streamController = StreamController<String>();
  _load() async {
    debugPrint('시작');
    streamController.add('wef');
    streamController.add('wefdd');
    await Future.delayed(const Duration(milliseconds: 1000));
    debugPrint('끝');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('compute Test')),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('그렇지'),
              Text(
                '${CommonCtrl.to.sss}',
              ),
              ElevatedButton(
                onPressed: () async {
                  _load();
                },
                child: const Text('gogo'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {},
                child: const Text('stop'),
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                stream: streamController.stream,
                initialData: 'no data',
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    debugPrint('${snapshot.data}');
                    return Text(
                      'Data: ${snapshot.data}',
                      style: const TextStyle(fontSize: 35),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
