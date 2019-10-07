// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mockedo.dart';

// **************************************************************************
// SerdeGenerator
// **************************************************************************

String _toJson(Mockedo instance) {
  Map<String, dynamic> mapper = <String, dynamic>{
    'something': instance.something.toString(),
  };
  return json.encode(mapper);
}

Mockedo _fromJson(Map<String, dynamic> data) {
  final Mockedo mockedo = Mockedo();
  mockedo.something =
      (data['something'] != null) ? (data['something'] as String) : null;
  return mockedo;
}
