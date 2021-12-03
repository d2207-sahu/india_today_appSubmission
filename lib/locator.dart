import 'package:get_it/get_it.dart';
import 'package:zealth_assignment/Services/ApiServices.dart';
import 'package:zealth_assignment/ViewModels/MainViewModel.dart';

import 'ViewModels/ConnectivityProvider.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ApiServices());
  locator.registerFactory(() => MainViewModel());
  locator.registerFactory(() => ConnectivityProvider());
}
