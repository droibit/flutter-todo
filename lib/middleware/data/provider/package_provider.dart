import 'dart:async';

import 'package:package_info/package_info.dart';

abstract class PackageProvider {
  Future<PackageInfo> get();
}

class PackageProviderImpl implements PackageProvider {
  static PackageProviderImpl _instance;

  factory PackageProviderImpl() {
    if (_instance == null) {
      _instance = new PackageProviderImpl._();
    }
    return _instance;
  }

  PackageProviderImpl._();

  @override
  Future<PackageInfo> get() => PackageInfo.fromPlatform();
}
