class Prop {
  const Prop({this.name, this.isNested = false, this.path, this.isNullable = false});

  final String name;
  final bool isNested;
  final String path;
  final bool isNullable;
}