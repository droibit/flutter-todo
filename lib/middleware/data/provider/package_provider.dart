import 'dart:async';

import 'package:package_info/package_info.dart';

abstract class PackageProvider {
  Future<PackageInfo> get();
}

class PackageProviderImpl implements PackageProvider {
  static PackageProviderImpl _instance;

  factory PackageProviderImpl() {
    if (_instance == null) {
      _instance = new PackageProviderImpl._internal();
    }
    return _instance;
  }

  PackageProviderImpl._internal();

  @override
  Future<PackageInfo> get() => PackageInfo.fromPlatform();
}
