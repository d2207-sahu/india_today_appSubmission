import 'package:get_it/get_it.dart';
import 'package:zealth_assignment/Services/ApiServices.dart';
import 'package:zealth_assignment/ViewModels/AstroViewModel.dart';
import 'package:zealth_assignment/ViewModels/DailyPanchangViewModel.dart';
import 'package:zealth_assignment/ViewModels/MainViewModel.dart';

import 'Services/AstroService.dart';
import 'Services/DailyPanchangService.dart';
import 'ViewModels/ConnectivityProvider.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ApiServices());
  locator.registerLazySingleton(() => DailyPanchangService());
  locator.registerLazySingleton(() => AstroService());
  locator.registerFactory(() => MainViewModel());
  locator.registerFactory(() => DailyPanchangViewModel());
  locator.registerFactory(() => ConnectivityProvider());
  locator.registerFactory(() => AstroViewModel());
}
