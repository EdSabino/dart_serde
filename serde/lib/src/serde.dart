/// Contain the @Serde annotation.
///
/// This is the class, his use is like an Annotations like @Serde(), it must be used over the class you wanto to be serialize and deserialize.
/// The functionalities of serialization and deserialization are true by default.
class Serde {
  const Serde({this.deserialize = true, this.serialize = true});

  /// If false will not serialize, true by default.
  final bool serialize;

  /// If false will not deserialize, true by default
  final bool deserialize;

}
