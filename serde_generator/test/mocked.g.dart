// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mocked.dart';

// **************************************************************************
// SerdeGenerator
// **************************************************************************

String _toJson(Mocked instance) {
  Map<String, dynamic> mapper = <String, dynamic>{
    'something': instance.something.toString(),
    'mama': {
      'Mia': {
        'mamaMia': instance.withMetadata.toString(),
      },
      'mia': {
        'mil': instance.meta.toString(),
      },
    },
    'mocked2': instance.mocked2.cast<Mockedo>().toList(),
    'lala': Mocked.serializeFunction(instance.lala),
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
  mocked.mocked2 = data['mocked2'].cast<Mockedo>().toList();
  mocked.lala = Mocked.deserializeFunction(data['lala']);
  return mocked;
}
