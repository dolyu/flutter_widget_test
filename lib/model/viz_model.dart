import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class VizChannel {
  // viz 정보
  VizData vizData;
  SerialPort port;
  RxBool toggle;
  VizChannel({
    required this.vizData,
    required this.port,
    required this.toggle,
  });

  VizChannel copyWith({
    VizData? vizData,
    SerialPort? port,
    RxBool? toggle,
  }) {
    return VizChannel(
      vizData: vizData ?? this.vizData,
      port: port ?? this.port,
      toggle: toggle ?? this.toggle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vizData': vizData.toMap(),
      'port': port.toString(),
      'toggle': toggle,
    };
  }

  factory VizChannel.fromMap(Map<String, dynamic> map) {
    return VizChannel(
      vizData: VizData.fromMap(map['vizData']),
      port: SerialPort(map['port']),
      toggle: map['toggle'] ?? false.obs,
    );
  }

  String toJson() => json.encode(toMap());

  factory VizChannel.fromJson(String source) =>
      VizChannel.fromMap(json.decode(source));

  @override
  String toString() =>
      'VizChannel(vizData: $vizData, port: $port, toggle: $toggle)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VizChannel &&
        other.vizData == vizData &&
        other.port == port &&
        other.toggle.value == toggle.value;
  }

  @override
  int get hashCode => vizData.hashCode ^ port.hashCode ^ toggle.hashCode;
}

class VizData {
  // Channel1개에서 나오는 Data
  double freq;
  double pdlv;
  double v;
  double i;
  double r;
  double x;
  double phase;
  VizSeries vizSeries;
  VizData({
    required this.freq,
    required this.pdlv,
    required this.v,
    required this.i,
    required this.r,
    required this.x,
    required this.phase,
    required this.vizSeries,
  });

  factory VizData.init() {
    return VizData(
        freq: 0.0,
        pdlv: 0.0,
        v: 0.0,
        i: 0.0,
        r: 0.0,
        x: 0.0,
        phase: 0.0,
        vizSeries: VizSeries.init());
  }
  VizData copyWith({
    double? freq,
    double? pdlv,
    double? v,
    double? i,
    double? r,
    double? x,
    double? phase,
    VizSeries? vizSeries,
  }) {
    return VizData(
      freq: freq ?? this.freq,
      pdlv: pdlv ?? this.pdlv,
      v: v ?? this.v,
      i: i ?? this.i,
      r: r ?? this.r,
      x: x ?? this.x,
      phase: phase ?? this.phase,
      vizSeries: vizSeries ?? this.vizSeries,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'freq': freq,
      'pdlv': pdlv,
      'v': v,
      'i': i,
      'r': r,
      'x': x,
      'phase': phase,
      'vizSeries': vizSeries.toMap(),
    };
  }

  factory VizData.fromMap(Map<String, dynamic> map) {
    return VizData(
      freq: map['freq']?.toDouble() ?? 0.0,
      pdlv: map['pdlv']?.toDouble() ?? 0.0,
      v: map['v']?.toDouble() ?? 0.0,
      i: map['i']?.toDouble() ?? 0.0,
      r: map['r']?.toDouble() ?? 0.0,
      x: map['x']?.toDouble() ?? 0.0,
      phase: map['phase']?.toDouble() ?? 0.0,
      vizSeries: VizSeries.fromMap(map['vizSeries']),
    );
  }

  String toJson() => json.encode(toMap());

  factory VizData.fromJson(String source) =>
      VizData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VizData(freq: $freq, p_dlv: $pdlv, v: $v, i: $i, r: $r, x: $x, phase: $phase, vizSeries: $vizSeries)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VizData &&
        other.freq == freq &&
        other.pdlv == pdlv &&
        other.v == v &&
        other.i == i &&
        other.r == r &&
        other.x == x &&
        other.phase == phase &&
        other.vizSeries == vizSeries;
  }

  @override
  int get hashCode {
    return freq.hashCode ^
        pdlv.hashCode ^
        v.hashCode ^
        i.hashCode ^
        r.hashCode ^
        x.hashCode ^
        phase.hashCode ^
        vizSeries.hashCode;
  }
}

class VizSeries {
  RxBool toggle = true.obs;
  Color seriesColor = const Color(0xFFEF5350);
  VizSeries({
    required this.toggle,
  });

  factory VizSeries.init() {
    return VizSeries(toggle: true.obs);
  }

  VizSeries copyWith({
    RxBool? toggle,
  }) {
    return VizSeries(
      toggle: toggle ?? this.toggle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'toggle': toggle,
    };
  }

  factory VizSeries.fromMap(Map<String, dynamic> map) {
    return VizSeries(
      toggle: map['toggle'] ?? false.obs,
    );
  }

  String toJson() => json.encode(toMap());

  factory VizSeries.fromJson(String source) =>
      VizSeries.fromMap(json.decode(source));

  @override
  String toString() => 'VizSeries(toggle: $toggle)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VizSeries && other.toggle.value == toggle.value;
  }

  @override
  int get hashCode => toggle.hashCode;
}
