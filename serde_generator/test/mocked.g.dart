// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mocked.dart';

// **************************************************************************
// SerdeGenerator
// **************************************************************************

String _toJson(Mocked instance) {
  Map<String, dynamic> mapper = <String, dynamic>{
    'some_thing': instance.someThing.toString(),
    'mama': {
      'Mia': {
        'mama_mia': instance.withMetadata.toString(),
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
  mocked.someThing = data['some_thing'] as bool;
  mocked.withMetadata = (data['mama'] != null &&
          data['mama']['Mia'] != null &&
          data['mama']['Mia']['mama_mia'] != null)
      ? (data['mama']['Mia']['mama_mia'] as String)
      : null;
  mocked.meta = (data['mama'] != null &&
          data['mama']['mia'] != null &&
          data['mama']['mia']['mil'] != null)
      ? (data['mama']['mia']['mil'] as String)
      : null;
  mocked.mocked2 = data['mocked2']
      .map<Mockedo>((dynamic data) => Mockedo.fromJson(data))
      .toList();
  mocked.lala = (data['mama'] != null &&
          data['mama']['mia'] != null &&
          data['lala'] != null)
      ? (Mocked.deserializeFunction(data['lala']))
      : null;
  return mocked;
}
