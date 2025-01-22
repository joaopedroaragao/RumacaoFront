// constants/font_family.dart
enum FontFamily {
  inter,
  dynamicSchematic;

  String get name {
    switch (this) {
      case FontFamily.inter:
        return 'Inter';
      case FontFamily.dynamicSchematic:
        return 'Dynamic Schematic';
    }
  }
}
