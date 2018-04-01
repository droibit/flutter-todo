import 'dart:async';

import 'package:package_info/package_info.dart';

abstract class PackageProvider {
  Future<PackageInfo> get();
}

class PackageProviderImpl implements PackageProvider {
  @override
  Future<PackageInfo> get() => PackageInfo.fromPlatform();
}
