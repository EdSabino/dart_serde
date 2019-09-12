// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mocked.dart';

// **************************************************************************
// SerdeGenerator
// **************************************************************************

String _toJson(Mocked instance) {
  Map<String, dynamic> mapper = {
    'something': instance.something.toString(),
    'mama': {
      'Mia': {
        'mamaMia': instance.withMetadata,
      },
      'mia': {
        'mil': instance.meta,
      },
    },
    'mocked2': instance.mocked2.map((dynamic data) {
      return data.toJson();
    }).toList(),
  };
  return json.encode(mapper);
}

Mocked _fromJson(Map<String, dynamic> data) {
  final Mocked mocked = Mocked();
  mocked.something = data['something'] as bool;
  mocked.withMetadata = data['mama']['Mia']['mamaMia'] as String;
  mocked.meta = (data['mama']['mia']['mil'] != null)
      ? (data['mama']['mia']['mil'] as String)
      : null;
  mocked.mocked2 = data['mocked2'].map<Mockedo>((dynamic data) {
    return Mockedo.fromJson(data as Map<String, dynamic>);
  }).toList();
  return mocked;
}
