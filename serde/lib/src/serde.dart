@Serde()
class Serde {
  const Serde({this.deserialize = true, this.serialize = true});

  final bool serialize;
  final bool deserialize;

}
