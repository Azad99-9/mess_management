import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:mess_management/services/size_config.dart';
import 'package:mess_management/view_model/profile_page_view_model.dart';

GetIt locator = GetIt.instance;

final sizeConfig=locator<SizeConfig>();
setUpLocator() {
  locator.registerSingleton(SizeConfig());
  locator.registerFactory(() => ProfilePageViewModel());
}