// import 'package:flutter/material.dart';
// import 'package:mess_management/constants/routes.dart';
// import 'package:mess_management/locator.dart';
// import 'package:mess_management/services/theme_service.dart';
// import 'package:mess_management/model/menu_model.dart';
// import 'package:mess_management/services/user_service.dart';
// import 'package:mess_management/locator.dart';
// import 'package:mess_management/view_model/menu_view_model.dart';
// import 'package:stacked/stacked.dart';
//
// class MessMenuPage extends StackedView<MenuViewModel> {
//   @override
//   MenuViewModel viewModelBuilder(BuildContext context) => MenuViewModel();
//
//   @override
//   void onViewModelReady(MenuViewModel viewModel) {
//     viewModel.fetchMenu();
//   }
//
//   @override
//   Widget builder(BuildContext context, MenuViewModel viewModel, Widget? child) {
//     MenuModel? menuData = viewModel.menuData;
//     print("in menu page $menuData");
//     if (menuData == null) {
//       return Center(child: Text("No menu data available"));
//     }
//     final currentTime = DateTime.now();
//     final currentMealType = viewModel.getCurrentMealType(currentTime);
//     return DefaultTabController(
//       length: menuData.data.keys.length,
//       child: Scaffold(
//         backgroundColor: ThemeService.primaryAccent,
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               icon: Icon(
//                 Icons.menu,
//                 color: ThemeService.secondaryColor,
//               )),
//           title: const Text(
//             'Menu',
//             style: TextStyle(
//               color: ThemeService.secondaryColor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   userService.logOut();
//                   if (userService.loggedIn) {
//                     navigationService.removeAllAndPush(
//                         Routes.signIn, Routes.signIn);
//                   }
//                 },
//                 icon: Icon(Icons.logout))
//           ],
//           bottom: TabBar(
//             labelColor: ThemeService.secondaryColor,
//             indicatorColor: ThemeService.secondaryColor,
//             unselectedLabelColor: ThemeService.secondaryColor,
//             isScrollable: true,
//             tabs: menuData!.data.keys.map((day) => Tab(text: day)).toList(),
//           ),
//           backgroundColor: ThemeService.primaryColor,
//         ),
//         body: viewModel.isLoading
//             ? Center(
//                 child: Container(
//                     height: 30,
//                     width: 30,
//                     child: CircularProgressIndicator(
//                       color: ThemeService.primaryColor,
//                     )),
//               )
//             : TabBarView(
//                 children: menuData.data.keys.map((day) {
//                   final dayData = menuData.data[day]!;
//                   print(dayData);
//                   final meals = {
//                     'breakFast': dayData.breakFast,
//                     'lunch': dayData.lunch,
//                     'snacks': dayData.snacks,
//                     'dinner': dayData.dinner,
//                   };
//                   return Padding(
//                       padding: EdgeInsets.symmetric(vertical: 8),
//                     child: ListView(
//                       children: meals.entries.map((meal) {
//                         final mealType = meal.key;
//                         final items = meal.value;
//                         final isHighlighted = mealType.toLowerCase() ==
//                             currentMealType.toLowerCase();
//
//                         return IntrinsicHeight(
//                           child: Container(
//                             color: isHighlighted
//                                 ? ThemeService.primaryColor.withOpacity(0.05)
//                                 : Colors.transparent,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Container(
//                                   width: 6,
//                                   constraints: BoxConstraints(
//                                       maxHeight: double.infinity),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: isHighlighted
//                                         ? ThemeService.primaryColor
//                                         : Colors.transparent,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: isHighlighted ? 24 : 16,
//                                         horizontal: 16),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         // Title Text
//                                         Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: isHighlighted ? 0 : 2),
//                                           child: Text(
//                                             mealType,
//                                             style: TextStyle(
//                                               color: isHighlighted
//                                                   ? ThemeService.primaryColor
//                                                   : Colors.black
//                                                       .withOpacity(0.5),
//                                               fontSize: isHighlighted ? 24 : 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         // Sublist items with better spacing and styling
//                                         ...items.map<Widget>((item) => Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       vertical: 0.0),
//                                               child: Row(
//                                                 children: [
//                                                   // Bullet point
//                                                   // Container(
//                                                   //   width: isHighlighted ? 5 : 4,
//                                                   //   height: isHighlighted ? 5 : 4,
//                                                   //   decoration: BoxDecoration(
//                                                   //     shape: BoxShape.circle,
//                                                   //     color: Colors.black,
//                                                   //   ),
//                                                   // ),
//                                                   // const SizedBox(width: 6),
//                                                   // Space between bullet and text
//                                                   Expanded(
//                                                     child: Text(
//                                                       "${item.itemName} (${item.quantityServed},${item.grams} grams, ${item.calories} cal)",
//                                                       style: TextStyle(
//                                                           color: isHighlighted
//                                                               ? Colors.black
//                                                               : Colors.black
//                                                                   .withOpacity(
//                                                                       0.5),
//                                                           fontSize: 14,
//                                                           fontWeight:
//                                                               FontWeight.w400),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   );
//                 }).toList(),
//               ),
//         bottomNavigationBar: Container(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mess_management/constants/routes.dart';
import 'package:mess_management/locator.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:mess_management/model/menu_model.dart';
import 'package:mess_management/services/user_service.dart';
import 'package:mess_management/view_model/menu_view_model.dart';
import 'package:stacked/stacked.dart';

class MessMenuPage extends StackedView<MenuViewModel> {
  @override
  MenuViewModel viewModelBuilder(BuildContext context) => MenuViewModel();

  @override
  void onViewModelReady(MenuViewModel viewModel) {
    viewModel.fetchMenu();
  }

  @override
  Widget builder(BuildContext context, MenuViewModel viewModel, Widget? child) {
    MenuModel? menuData = viewModel.menuData;

    if (viewModel.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: ThemeService.primaryColor,
        ),
      );
    }

    if (menuData == null) {
      return Center(child: Text("No menu data available. Please try again."));
    }

    final currentTime = DateTime.now();
    final currentMealType = viewModel.getCurrentMealType(currentTime);

    return DefaultTabController(
      length: menuData.data.keys.length,
      child: Scaffold(
        backgroundColor: ThemeService.primaryAccent,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: ThemeService.secondaryColor,
            ),
          ),
          title: const Text(
            'Menu',
            style: TextStyle(
              color: ThemeService.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                userService.logOut();
                if (userService.loggedIn) {
                  navigationService.removeAllAndPush(
                    Routes.signIn,
                    Routes.signIn,
                  );
                }
              },
              icon: Icon(Icons.logout),
            ),
          ],
          bottom: TabBar(
            labelColor: ThemeService.secondaryColor,
            indicatorColor: ThemeService.secondaryColor,
            unselectedLabelColor: ThemeService.secondaryColor,
            isScrollable: true,
            tabs: menuData.data.keys.map((day) => Tab(text: day)).toList(),
          ),
          backgroundColor: ThemeService.primaryColor,
        ),



        body: viewModel.isLoading
            ? Center(
          child: Container(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: ThemeService.primaryColor,
              )),
        )
            : TabBarView(
          children: menuData!.data.keys.map((day) {
            final dayData = menuData.data[day]!;
            final meals = {
              'breakFast': dayData.breakFast,
              'lunch': dayData.lunch,
              'snacks': dayData.snacks,
              'dinner': dayData.dinner,
            };
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: ListView(
                children: meals.entries.map((meal) {
                  final mealType = meal.key;
                  final items = meal.value;
                  final isHighlighted = mealType.toLowerCase() ==
                      currentMealType.toLowerCase();

                  return IntrinsicHeight(
                    child: Container(
                      color: isHighlighted
                          ? ThemeService.primaryColor.withOpacity(0.05)
                          : Colors.transparent,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 6,
                            constraints: BoxConstraints(
                                maxHeight: double.infinity),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: isHighlighted
                                  ? ThemeService.primaryColor
                                  : Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(

                                  vertical: isHighlighted ? 24 : 16,
                                  horizontal: 16),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // Title Text
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: isHighlighted ? 0 : 2),
                                    child: Text(
                                      mealType,
                                      style: TextStyle(
                                        color: isHighlighted
                                            ? ThemeService.primaryColor

                                            : Colors.black
                                            .withOpacity(0.5),
                                        fontSize: isHighlighted ? 24 : 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  // Sublist items with better spacing and styling
                                  ...items.map<Widget>((item) => Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        vertical: 0.0),
                                    child: Row(
                                      children: [
                                        // Bullet point
                                        // Container(
                                        //   width: isHighlighted ? 5 : 4,
                                        //   height: isHighlighted ? 5 : 4,
                                        //   decoration: BoxDecoration(
                                        //     shape: BoxShape.circle,
                                        //     color: Colors.black,
                                        //   ),
                                        // ),
                                        // const SizedBox(width: 6),
                                        // Space between bullet and text
                                        Expanded(
                                          child: Text(
                                            "${item.itemName} (${item.quantityServed},${item.grams} grams, ${item.calories} cal)",
                                            style: TextStyle(
                                                color: isHighlighted
                                                    ? Colors.black
                                                    : Colors.black
                                                    .withOpacity(
                                                    0.5),
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}