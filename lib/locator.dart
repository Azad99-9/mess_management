import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:mess_management/services/size_config.dart';
import 'package:mess_management/view_model/profile_page_view_model.dart';
import 'package:mess_management/view_model/signin_details_view_model.dart';
import 'package:mess_management/services/notification_services.dart';
import 'package:mess_management/views/signin_details_page.dart';

GetIt locator = GetIt.instance;

final sizeConfig=locator<SizeConfig>();
final notificationService=locator<NotificationServices>();
setUpLocator() {
  locator.registerSingleton(NotificationServices());
  locator.registerSingleton(SizeConfig());
  locator.registerFactory(() => ProfilePageViewModel());
  locator.registerFactory(()=>SigninDetailsViewModel());
}