import 'package:package_info_plus/package_info_plus.dart';

class AppVersion {
  static PackageInfo? _packageInfo;

  /// Initializes and returns app info (call once on app start)
  static Future<PackageInfo> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    return _packageInfo!;
  }

  /// Returns "v1.2.3" (app version)
  static String get version => _packageInfo?.version ?? '1.0.0';

  /// Returns build number (e.g., "45")
  static String get buildNumber => _packageInfo?.buildNumber ?? '1';

  /// Returns "v1.2.3 (45)" – perfect for settings screen
  static String get versionWithBuild => 'v$version ($buildNumber)';

  /// Returns full info: "App Name v1.2.3 (45)"
  static String get fullVersion =>
      '${_packageInfo?.appName ?? 'InvoicePay'} v$version ($buildNumber)';
}
