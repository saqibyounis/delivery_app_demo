import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoHelper {
  PackageInfo _packageInfo;
  static final PackageInfoHelper _instance = PackageInfoHelper._internal();
  factory PackageInfoHelper() {
    return _instance;
  }

  PackageInfoHelper._internal() {
    _initPackageInfo();
  }

  void _initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  String getAppVersion() {
    return "1.0.0 (2)";
  }
}
