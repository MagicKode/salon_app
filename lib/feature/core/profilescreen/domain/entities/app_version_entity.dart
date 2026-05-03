class AppVersionEntity {
  final String version;
  final String buildNumber;

  const AppVersionEntity({
    required this.version,
    required this.buildNumber,
  });

  String get displayVersion => 'Версия $version ($buildNumber)';
}
