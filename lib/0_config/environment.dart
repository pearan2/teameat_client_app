class Environment {
  final bool isDev = const bool.fromEnvironment('IS_DEV', defaultValue: false);
  final String apiEndPoint = const String.fromEnvironment("API_ENDPOINT",
      defaultValue: 'api.teameat.shop');
}
