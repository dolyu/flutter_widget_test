import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConfigWR {
  ConfigOES oes;
  ConfigVizCommon viz;
  ConfigWR({
    required this.oes,
    required this.viz,
  });

  factory ConfigWR.init([String name = ""]) {
    return ConfigWR(
      oes: ConfigOES.init(),
      viz: ConfigVizCommon.init(),
    );
  }

  ConfigWR copyWith({
    ConfigOES? oes,
    ConfigVizCommon? viz,
  }) {
    return ConfigWR(
      oes: oes ?? this.oes,
      viz: viz ?? this.viz,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'oes': oes.toMap(),
      'viz': viz.toMap(),
    };
  }

  factory ConfigWR.fromMap(Map<String, dynamic> map) {
    return ConfigWR(
      oes: ConfigOES.fromMap(map['oes']),
      viz: ConfigVizCommon.fromMap(map['viz']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigWR.fromJson(String source) =>
      ConfigWR.fromMap(json.decode(source));

  @override
  String toString() => 'ConfigWR(oes: $oes, viz: $viz)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfigWR && other.oes == oes && other.viz == viz;
  }

  @override
  int get hashCode => oes.hashCode ^ viz.hashCode;
}

class ConfigOES {
  bool simulation;
  int comport;
  AutoSave autosave;
  ConfigOES({
    required this.simulation,
    required this.comport,
    required this.autosave,
  });

  factory ConfigOES.init() {
    return ConfigOES(simulation: false, comport: 1, autosave: AutoSave.init());
  }
  ConfigOES copyWith({
    bool? simulation,
    int? comport,
    AutoSave? autosave,
  }) {
    return ConfigOES(
      simulation: simulation ?? this.simulation,
      comport: comport ?? this.comport,
      autosave: autosave ?? this.autosave,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'simulation': simulation,
      'comport': comport,
      'autosave': autosave.toMap(),
    };
  }

  factory ConfigOES.fromMap(Map<String, dynamic> map) {
    return ConfigOES(
      simulation: map['simulation'] ?? false,
      comport: map['comport']?.toInt() ?? 0,
      autosave: AutoSave.fromMap(map['autosave']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigOES.fromJson(String source) =>
      ConfigOES.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConfigOES(simulation: $simulation, comport: $comport, autosave: $autosave)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfigOES &&
        other.simulation == simulation &&
        other.comport == comport &&
        other.autosave == autosave;
  }

  @override
  int get hashCode {
    return simulation.hashCode ^ comport.hashCode ^ autosave.hashCode;
  }
}

class ConfigVizCommon {
  bool simulation;
  List<ConfigViz> s;
  ConfigVizCommon({
    required this.simulation,
    required this.s,
  });

  factory ConfigVizCommon.init() {
    return ConfigVizCommon(
        simulation: false, s: List.filled(5, ConfigViz.init()));
  }

  ConfigVizCommon copyWith({
    bool? simulation,
    List<ConfigViz>? s,
  }) {
    return ConfigVizCommon(
      simulation: simulation ?? this.simulation,
      s: s ?? this.s,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'simulation': simulation,
      's': s.map((x) => x.toMap()).toList(),
    };
  }

  factory ConfigVizCommon.fromMap(Map<String, dynamic> map) {
    return ConfigVizCommon(
      simulation: map['simulation'] ?? false,
      s: List<ConfigViz>.from(map['s']?.map((x) => ConfigViz.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigVizCommon.fromJson(String source) =>
      ConfigVizCommon.fromMap(json.decode(source));

  @override
  String toString() => 'ConfigVizCommon(simulation: $simulation, s: $s)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfigVizCommon &&
        other.simulation == simulation &&
        listEquals(other.s, s);
  }

  @override
  int get hashCode => simulation.hashCode ^ s.hashCode;
}

class ConfigViz {
  int comPort;
  Color seriesColor;
  ConfigViz({
    required this.comPort,
    required this.seriesColor,
  });
  factory ConfigViz.init() {
    return ConfigViz(comPort: 0, seriesColor: Colors.white);
  }
  ConfigViz copyWith({
    int? comPort,
    Color? seriesColor,
  }) {
    return ConfigViz(
      comPort: comPort ?? this.comPort,
      seriesColor: seriesColor ?? this.seriesColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comPort': comPort,
      'seriesColor': seriesColor.value,
    };
  }

  factory ConfigViz.fromMap(Map<String, dynamic> map) {
    return ConfigViz(
      comPort: map['comPort']?.toInt() ?? 0,
      seriesColor: Color(map['seriesColor']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigViz.fromJson(String source) =>
      ConfigViz.fromMap(json.decode(source));

  @override
  String toString() =>
      'ConfigViz(comPort: $comPort, seriesColor: $seriesColor)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfigViz &&
        other.comPort == comPort &&
        other.seriesColor == seriesColor;
  }

  @override
  int get hashCode => comPort.hashCode ^ seriesColor.hashCode;
}

class AutoSave {
  bool enable;
  double value;
  AutoSave({
    required this.enable,
    required this.value,
  });

  factory AutoSave.init() {
    return AutoSave(enable: false, value: 0.0);
  }

  AutoSave copyWith({
    bool? enable,
    double? value,
  }) {
    return AutoSave(
      enable: enable ?? this.enable,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enable': enable,
      'value': value,
    };
  }

  factory AutoSave.fromMap(Map<String, dynamic> map) {
    return AutoSave(
      enable: map['enable'] ?? false,
      value: map['value']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AutoSave.fromJson(String source) =>
      AutoSave.fromMap(json.decode(source));

  @override
  String toString() => 'AutoSave(enable: $enable, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AutoSave && other.enable == enable && other.value == value;
  }

  @override
  int get hashCode => enable.hashCode ^ value.hashCode;
}
