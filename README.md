# Dart Serde

The aim of that package is provide an easy and friendly interface to use serialization and deserialization for classes;

## Installation

### Add to dependencies

Add those to your pubspec

```
dependencies:
  serde: ^1.0.0

dev_dependencies:
  build_runner: ^1.0.0
  serde_generator: ^1.0.0

```

Run ```pub get```

## Getting started

Given the class

```
class Public {
    final bool mustShow;
    final int number;
}
```

To map a json into it, and from it you must do:
```
@Serde()
class Public {...}
```
And thats it.

If you have special conditions for some keys, that is treatable. Lets assume, for example, that the field musShow, comes int he json with the name show, and nested in the structure, wrapped by the mapper
```
@Serde()
class Public {
    @Prop(name: 'show', isNested: true, path: 'mapper')
    final bool mustShow;
    final int number;
}
```
