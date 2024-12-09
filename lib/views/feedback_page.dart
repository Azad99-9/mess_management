import 'package:flutter/material.dart';
import 'package:mess_management/services/size_config.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mess_management/view_model/profile_page_view_model.dart';
import 'package:mess_management/locator.dart';
import 'package:mess_management/widgets/star_ratebar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late final ProfilePageViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = locator<ProfilePageViewModel>();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeService.primaryAccent,
      appBar: AppBar(
        backgroundColor: ThemeService.primaryColor,
        centerTitle: true,
        title: Text(
          "Feedback",
          style: TextStyle(
            fontSize: 24,
            color: ThemeService.secondaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: ThemeService.secondaryBackgroundColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                TextFormField(
                  controller: _viewModel.startDateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Start Date",
                    labelStyle: TextStyle(color: ThemeService.primaryColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ThemeService
                            .primaryColor, // Border color when not focused
                        width: 1.5, // Border width
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ThemeService
                            .primaryColor, // Border color when focused
                        width: 2.0, // Border width
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _viewModel.endDateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "End Date",
                    labelStyle: TextStyle(color: ThemeService.primaryColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ThemeService
                            .primaryColor, // Border color when not focused
                        width: 1.5, // Border width
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ThemeService
                            .primaryColor, // Border color when focused
                        width: 2.0, // Border width
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                StarRatebar(
                    text: "Timeliness of service",
                    controller: _viewModel.Timeliness),
                StarRatebar(
                    text: "Cleanliness of surroundings",
                    controller: _viewModel.Cleanliness),
                StarRatebar(
                    text: "Quality of food", controller: _viewModel.Quality),
                StarRatebar(
                    text: "Taste of Curries/Fried",
                    controller: _viewModel.Taste),
                StarRatebar(
                    text: "Snacks,Tea and Coffee",
                    controller: _viewModel.Snacks),
                StarRatebar(
                    text: "Quantity of food as per menu",
                    controller: _viewModel.Quantity),
                StarRatebar(
                    text: "Courtesy of services from contractor employees",
                    controller: _viewModel.Courtesy),
                StarRatebar(
                    text: "Appropriate attire of contractor employees",
                    controller: _viewModel.Attire),
                StarRatebar(
                    text: "Cooking and Serving as per menu",
                    controller: _viewModel.Serving),
                StarRatebar(
                    text: "Cleanliness of wash area",
                    controller: _viewModel.Washarea),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _viewModel.submit();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(130, 50),
                      elevation: 0,
                      backgroundColor: ThemeService.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18), // Rounded corners
                        side: BorderSide(
                          color: ThemeService
                              .secondaryBackgroundColor, // Border color
                          width: 0, // Border width
                        ),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: ThemeService.secondaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
