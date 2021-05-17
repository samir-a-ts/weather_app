import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum TempType { celsium, farring }

/// (0 °C × 9/5) + 32 = 32 °F

class Settings extends Equatable {
  final TempType type;
  final String locale;
  final Color color;

  const Settings({this.type, this.locale, this.color});

  factory Settings.initial() {
    return Settings(
      locale: window.locale.languageCode,
      type: TempType.celsium,
      color: Colors.black,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'type': type.index,
      'locale': locale,
      'color': [color.red, color.blue, color.green],
    };
  }

  factory Settings.fromJSON(Map<String, dynamic> json) {
    final List<int> colors = (json['color'] as List).cast<int>();

    return Settings(
      locale: json['locale'] as String,
      type: TempType.values[json['type'] as int],
      color: Color.fromRGBO(
        colors[0],
        colors[1],
        colors[2],
        1,
      ),
    );
  }

  @override
  List<Object> get props => [type, locale, color.value];

  Settings copyWith({Color color, TempType type, String locale}) {
    return Settings(
      color: color ?? this.color,
      type: type ?? this.type,
      locale: locale ?? this.locale,
    );
  }
}
