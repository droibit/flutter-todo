import 'package:flutter_flux/flutter_flux.dart';
import 'package:package_info/package_info.dart';

import '../../data/provider/package_provider.dart';

class SettingsStore extends Store {
  final PackageProvider _packageProvider;

  PackageInfo _packageInfo;

  String get appVersion => _packageInfo?.version;

  SettingsStore(this._packageProvider) : assert(_packageProvider != null) {
    triggerOnAction(getPackageAction, (Null _) async {
      _packageInfo = await _packageProvider.get();
    });
  }
}

// For SettingsStore
final StoreToken settingsStoreToken =
    new StoreToken(new SettingsStore(new PackageProviderImpl()));
final Action<Null> getPackageAction = new Action<Null>();
