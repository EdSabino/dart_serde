class Prop {
  const Prop({this.name, this.isNested = false, this.path});

  final String name;
  final bool isNested;
  final String path;
}