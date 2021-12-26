import 'dart:convert';
import 'package:get/get.dart';

class FileView {
  String fileName;
  Rx<bool> checked;
  Range range;
  FileView({
    required this.fileName,
    required this.checked,
    required this.range,
  });

  FileView copyWith({
    String? fileName,
    Rx<bool>? checked,
    Range? range,
  }) {
    return FileView(
      fileName: fileName ?? this.fileName,
      checked: checked ?? this.checked,
      range: range ?? this.range,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fileName': fileName,
      'checked': checked,
      'range': range.toMap(),
    };
  }

  factory FileView.fromMap(Map<String, dynamic> map) {
    return FileView(
      fileName: map['fileName'] ?? '',
      checked: map['checked'] ?? false,
      range: Range.fromMap(map['range']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FileView.fromJson(String source) =>
      FileView.fromMap(json.decode(source));

  @override
  String toString() =>
      'FileView(fileName: $fileName, checked: $checked, range: $range)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FileView &&
        other.fileName == fileName &&
        other.checked == checked &&
        other.range == range;
  }

  @override
  int get hashCode => fileName.hashCode ^ checked.hashCode ^ range.hashCode;
}

class Range {
  int start;
  int end;
  Range({
    required this.start,
    required this.end,
  });

  Range copyWith({
    int? start,
    int? end,
  }) {
    return Range(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
    };
  }

  factory Range.fromMap(Map<String, dynamic> map) {
    return Range(
      start: map['start']?.toInt() ?? 0,
      end: map['end']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Range.fromJson(String source) => Range.fromMap(json.decode(source));

  @override
  String toString() => 'Range(start: $start, end: $end)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Range && other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
