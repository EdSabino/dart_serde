// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mockedo.dart';

// **************************************************************************
// SerdeGenerator
// **************************************************************************

String _toJson(Mockedo instance) {
  Map<String, dynamic> mapper = {
    'something': instance.something.toString(),
  };
  return json.encode(mapper);
}

Mockedo _fromJson(Map<String, dynamic> data) {
  final Mockedo mockedo = Mockedo();
  mockedo.something = data['something'] as String;
  return mockedo;
}
