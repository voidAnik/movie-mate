// for this project we are using just two environment
// normally there would be one more environment for staging
enum FlavorType {
  development,
  production,
}

class Flavor {
  static FlavorType? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case FlavorType.development:
        return 'MovieMate';
      case FlavorType.production:
        return 'MovieMate';
      default:
        return 'title';
    }
  }
}
