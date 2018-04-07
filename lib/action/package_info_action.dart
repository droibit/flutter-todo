import '../model/package_info.dart';

class GetPackageInfoAction {}

class OnGetPackageInfoAction {
  final PackageInfo packageInfo;

  OnGetPackageInfoAction(this.packageInfo) : assert(packageInfo != null);
}
