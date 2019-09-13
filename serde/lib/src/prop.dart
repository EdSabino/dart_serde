typedef SerializeFunction = dynamic Function(dynamic data);
typedef DeserializeFunction = dynamic Function(dynamic data);

class Prop {
  const Prop({this.name, this.isNested = false, this.path, this.mustSerde = true, this.isNullable = false, this.serializeFunction, this.deserializeFunction});

  final String name;
  final bool isNested;
  final String path;
  final bool isNullable;
  final bool mustSerde;
  final SerializeFunction serializeFunction;
  final DeserializeFunction deserializeFunction;
}