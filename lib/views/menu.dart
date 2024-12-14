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
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.menu, color: ThemeService.secondaryColor),
          ),
          title: const Text(
            'Mess Menu',
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
                      Routes.signIn, Routes.signIn);
                }
              },
              icon: Icon(Icons.logout, color: ThemeService.secondaryColor),
            )
          ],
          bottom: TabBar(
            // controller: ,
            labelColor: ThemeService.secondaryColor,
            indicatorColor: ThemeService.secondaryColor,
            unselectedLabelColor: Colors.grey,
            isScrollable: true,
            tabs: viewModel.days.map((day) => Tab(text: day)).toList(),
          ),
          backgroundColor: ThemeService.primaryColor,
        ),
        body: viewModel.isLoading
            ? Center(
                child:
                    CircularProgressIndicator(color: ThemeService.primaryColor),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: ListView(
                      children: meals.entries.map((meal) {
                        final mealType = meal.key;
                        final items = meal.value;
                        final isHighlighted = mealType.toLowerCase() == currentMealType.toLowerCase() &&
                            DateTime.now().weekday == DateTime.now().weekday;


                        return AnimatedContainer(

                          duration: const Duration(milliseconds: 500),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              color: isHighlighted
                                  ? Colors.white
                                  : ThemeService.primaryAccent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                if (isHighlighted)
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    // Shadow color
                                    blurRadius: 8,
                                    // Softness of the shadow
                                    offset: Offset(
                                        0, 4), // Horizontal and vertical offset
                                  ),
                              ]),
                          child: ExpansionTile(
                            initiallyExpanded: isHighlighted,
                            shape: Border.all(
                              color: Colors.transparent, // Ensure no border is visible
                              width: 0, // No border width
                            ),
                            leading: Icon(
                              _getMealIcon(mealType),
                              color: isHighlighted
                                  ? ThemeService.primaryColor
                                  : Colors.grey,
                            ),
                            title: Text(
                              mealType.toUpperCase(),
                              style: TextStyle(
                                fontSize: isHighlighted ? 20 : 16,
                                fontWeight: FontWeight.bold,
                                color: isHighlighted
                                    ? ThemeService.primaryColor
                                    : Colors.black,
                              ),
                            ),
                            children: items.map<Widget>((item) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 16),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: isHighlighted
                                      ? Colors.white
                                      : ThemeService.primaryAccent,
                                  borderRadius: BorderRadius.circular(12),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.shade200,
                                  //     spreadRadius: 1,
                                  //     blurRadius: 6,
                                  //   ),
                                  // ],
                                ),
                                child: Row(
                                  children: [
                                    // Leading Circle Avatar
                                    Icon(
                                      Icons.restaurant,
                                      color: isHighlighted
                                          ? ThemeService.primaryColor
                                          : Colors.grey,
                                      size: 25,
                                    ),
                                    // Spacer between Avatar and Texts
                                    SizedBox(width: 16),
                                    // Main Column for Title and Subtitle
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Item Name
                                          Text(
                                            item.itemName,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: isHighlighted
                                                  ? Colors.black
                                                  : Colors.grey.shade800,
                                            ),
                                          ),
                                          // Quantity, Grams, Calories
                                          Text(
                                            "${item.quantityServed}, ${item.grams}g, ${item.calories} cal",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: isHighlighted ? FontWeight.w500 : FontWeight.w400,
                                              color: isHighlighted
                                                  ? ThemeService.primaryColor
                                                  : Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Trailing Icon (optional)
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
        // bottomNavigationBar: Container(),
      ),
    );
  }

  IconData _getMealIcon(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return Icons.free_breakfast;
      case 'lunch':
        return Icons.lunch_dining;
      case 'snacks':
        return Icons.fastfood;
      case 'dinner':
        return Icons.night_shelter;
      default:
        return Icons.restaurant;
    }
  }
}
