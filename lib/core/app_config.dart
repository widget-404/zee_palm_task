enum Environment {
  DEVELOPMENT,
  STAGING,
  PRODUCTION,
  PRODUCTION_WITH_INSTABUG,
}

class AppConfig {
  final Environment environment;

  AppConfig(this.environment);
}
