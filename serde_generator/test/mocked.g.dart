// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mocked.dart';

// **************************************************************************
// SerdeGenerator
// **************************************************************************

String _toJson(Mocked instance) {
  Map<String, dynamic> mapper = {
    'something': instance.something,
    'mama': {
      'Mia': {
        'mamaMia': instance.withMetadata,
      }
    },
    'mama': {
      'mia': {
        'mil': instance.meta,
      }
    },
  };
  return json.encode(mapper);
}

Mocked _fromJson(Map<String, dynamic> data) {
  final Mocked mocked = Mocked();
  mocked.something = data['something'] as bool;
  mocked.withMetadata = data['mama']['Mia']['mamaMia'] as String;
  mocked.meta = data['mama']['mia']['mil'] as String;
  return mocked;
}
