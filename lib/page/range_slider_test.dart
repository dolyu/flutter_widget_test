import 'package:flutter/material.dart';
import 'package:widget_test/ctrl/range_slider_ctrl.dart';
import 'package:get/get.dart';

class RangeSliderTest extends StatelessWidget {
  const RangeSliderTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 200,
      child: Obx(
        () => RangeSlider(
          onChanged: (d) {
            RangeSliderCtrl.to.rv.value = d;
            debugPrint('onchanged ${RangeSliderCtrl.to.firstLine.length} $d');
            RangeSliderCtrl.to.vStart =
                RangeSliderCtrl.to.firstLine[d.start.round()];
            RangeSliderCtrl.to.vEnd =
                RangeSliderCtrl.to.firstLine[d.end.round()];
            //RangeSliderCtrl.to.rv.value = RangeValues(d.start, d.end);
          },
          values: RangeSliderCtrl.to.firstLine.isNotEmpty
              ? RangeSliderCtrl.to.rv.value
              : const RangeValues(0, 0),
          min: 0,
          max: RangeSliderCtrl.to.firstLine.isNotEmpty
              ? RangeSliderCtrl.to.firstLine.length - 1
              : 1,
          divisions: RangeSliderCtrl.to.firstLine.isNotEmpty
              ? RangeSliderCtrl.to.firstLine.length - 1
              : 1,
          labels: RangeLabels(RangeSliderCtrl.to.vStart.toStringAsFixed(3),
              RangeSliderCtrl.to.vEnd.toStringAsFixed(3)
              // _currentRangeValues.value.start.round().toString(),
              // _currentRangeValues.value.end.round().toString(),
              ),
        ),
      ),
    );
  }
}
