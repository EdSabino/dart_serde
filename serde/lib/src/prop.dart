/// Contains the Prop annotation declaration
/// 
/// Is responsible for possible alterations on specific attributes

/// Define the type that must be passed into serializeFunction, if you want to write your own function to serialize
typedef SerializeFunction = dynamic Function(dynamic data);

/// Define the type that must be passed into deserializeFunction, if you want to write your own function to deserialize
typedef DeserializeFunction = dynamic Function(dynamic data);

/// The @Prop annotation itself, it must be placed above soem attribute inside a class annotated with @Serde, if an element is annotated you can change some configurations about it.
class Prop {
  const Prop({this.name, this.isNested = false, this.path, this.mustSerde = true, this.isNullable = false, this.serializeFunction, this.deserializeFunction});

  /// The name property when used will change the value from where they will be serialize, and deserialize, example:
  ///   your json is {"value": "real_value"}, and the attribute that will receive the "value", is "something", you will annotate the "some" attribute, and put the name as "value"
  final String name;

  /// This is a boolean value that sinalizes to the the generator that the variable path must be used, and that the value is nested inside the json tree
  final bool isNested;

  /// When using isNested: true, this var is mandatory, this will represent the path that the generator must search to find the value, example:
  ///   your json is {"something": {"value": 23}}, the path must be "something", and the name must be "value"
  final String path;

  /// If true, the field can be null, or dont be found, without problem
  final bool isNullable;

  /// The default value of this field is true, and represent if a field must be serded or not, so, if you have an field in your class, that is not 
  /// part from the json, annotate it, and set mustSerde to false
  final bool mustSerde;

  /// If you want to pass a custom function to serialize your field
  final SerializeFunction serializeFunction;

  /// If you want to pass a custom function to deserialize your field
  final DeserializeFunction deserializeFunction;
}