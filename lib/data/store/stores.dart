import 'package:flutter_flux/flutter_flux.dart';

import '../provider/package_provider.dart';
import 'settings_store.dart';

export 'settings_store.dart';

// For SettingsStore
final StoreToken settingsStoreToken =
    new StoreToken(new SettingsStore(new PackageProviderImpl()));
final Action<Null> getPackageAction = new Action<Null>();
