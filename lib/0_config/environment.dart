class Environment {
  final bool isDev = const bool.fromEnvironment('IS_DEV', defaultValue: false);
  final String apiEndPoint = const String.fromEnvironment("API_ENDPOINT",
      defaultValue: 'api.teameat.shop');
  final String linkBaseUrl = const String.fromEnvironment("LINK_BASE_URL",
      defaultValue: 'link.teameat.shop');
}
