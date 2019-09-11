class Prop {
  const Prop({this.name, this.isNested = false, this.path, this.mustSerde = true, this.isNullable = false});

  final String name;
  final bool isNested;
  final String path;
  final bool isNullable;
  final bool mustSerde;
}