import 'package:flutter/foundation.dart';

@immutable
class PackageInfo {
  final String version;

  const PackageInfo({
    @required this.version,
  }) : assert(version != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageInfo &&
          runtimeType == other.runtimeType &&
          version == other.version;

  @override
  int get hashCode => version.hashCode;

  @override
  String toString() {
    return 'PackageInfo{version: $version}';
  }
}
