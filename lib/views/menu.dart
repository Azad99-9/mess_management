import 'package:flutter/material.dart';
import 'package:mess_management/services/theme_service.dart';

class MessMenuPage extends StatelessWidget {
  // Sample data for mess menu
  final Map<String, Map<String, List<String>>> messMenu = {
    'Monday': {
      'Breakfast': ['Pancakes', 'Omelette', 'Milk'],
      'Lunch': ['Rice and Curry', 'Paneer Butter Masala', 'Roti'],
      'Snacks': ['Samosa', 'Tea'],
      'Dinner': ['Chapati', 'Dal Tadka', 'Mixed Veg Curry'],
    },
    'Tuesday': {
      'Breakfast': ['Idli', 'Sambar', 'Coconut Chutney'],
      'Lunch': ['Veg Pulao', 'Raita', 'Curd Rice'],
      'Snacks': ['Pakoras', 'Coffee'],
      'Dinner': ['Noodles', 'Manchurian', 'Soup'],
    },
    'Wednesday': {
      'Breakfast': ['Paratha', 'Pickle', 'Curd'],
      'Lunch': ['Fried Rice', 'Chili Paneer', 'Soup'],
      'Snacks': ['Veg Sandwich', 'Lemonade'],
      'Dinner': ['Chapati', 'Shahi Paneer', 'Rice'],
    },
    'Thursday': {
      'Breakfast': ['Poha', 'Sev', 'Tea'],
      'Lunch': ['Dal Fry', 'Jeera Rice', 'Salad'],
      'Snacks': ['Banana', 'Green Tea'],
      'Dinner': ['Pulao', 'Kadhi', 'Papad'],
    },
    'Friday': {
      'Breakfast': ['Bread Toast', 'Butter', 'Juice'],
      'Lunch': ['Rajma', 'Rice', 'Chapati'],
      'Snacks': ['Biscuits', 'Cold Coffee'],
      'Dinner': ['Pizza', 'Pasta', 'Salad'],
    },
  };

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final currentMealType = _getCurrentMealType(currentTime);

    return DefaultTabController(
      length: messMenu.keys.length,
      child: Scaffold(
        backgroundColor: ThemeService.primaryAccent,
        appBar: AppBar(
          title: const Text(
            'Menu',
            style: TextStyle(
              color: ThemeService.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(

            labelColor: ThemeService.secondaryColor,
            indicatorColor: ThemeService.secondaryColor,
            unselectedLabelColor: ThemeService.secondaryColor,
            isScrollable: true,
            tabs: messMenu.keys
                .map((day) => Tab(
                      text: day,
                    ))
                .toList(),
          ),
          backgroundColor: ThemeService.primaryColor,
        ),
        body: TabBarView(
          children: messMenu.keys.map((day) {
            final meals = messMenu[day]!;
            return ListView(
              children: meals.entries.map((meal) {
                final mealType = meal.key;
                final items = meal.value;
                final isHighlighted = mealType == currentMealType;

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
                          constraints:
                              BoxConstraints(maxHeight: double.infinity),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: isHighlighted
                                ? ThemeService.primaryColor
                                : Colors.transparent,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title Text
                                Text(
                                  mealType,
                                  style: const TextStyle(
                                    color: ThemeService.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Sublist items with better spacing and styling
                                ...items.map((item) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          // Bullet point
                                          Container(
                                            width: 6,
                                            height: 6,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ThemeService.primaryColor,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          // Space between bullet and text
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
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
            );
          }).toList(),
        ),
      ),
    );
  }

  // Determines the current meal type based on the time
  String _getCurrentMealType(DateTime currentTime) {
    final hour = currentTime.hour;

    if (hour >= 4 && hour < 12) {
      return 'Breakfast';
    } else if (hour >= 12 && hour < 16) {
      return 'Lunch';
    } else if (hour >= 16 && hour < 19) {
      return 'Snacks';
    } else {
      return 'Dinner';
    }
  }
}