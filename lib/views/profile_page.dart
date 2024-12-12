import 'package:flutter/material.dart';
import 'package:mess_management/model/complaint_model.dart';
import 'package:mess_management/model/user_model.dart';
import 'package:mess_management/services/size_config.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:mess_management/view_model/profile_page_view_model.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StackedView<ProfilePageViewModel> {
  @override
  ProfilePageViewModel viewModelBuilder(context) => ProfilePageViewModel();
  @override
  void onViewModelReady(ProfilePageViewModel viewModel) {
    viewModel.fetchCurrentUser();
    viewModel.fetchUserComplaints();
  }

  @override
  Widget builder(
      BuildContext context, ProfilePageViewModel viewModel, Widget? child) {
    SizeConfig.init(context);
    viewModel.context=context;
    if (viewModel.isBusy) {
      return const Center(child: CircularProgressIndicator());
    }

    UserModel? user = viewModel.currentUser;
    List<ComplaintModel> complaint = viewModel.complaints;
    if (user == null) {
      return const Center(
        child: Text("Failed to fetch"),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeService.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 20,
            color: ThemeService.secondaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.logout,
              size: 25,
              color: ThemeService.primaryTextColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ThemeService.secondaryBackgroundColor,
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(0, 0.1),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          key: const Key('Profile Pic'),
                          backgroundImage: NetworkImage(
                              '${user.imageURL}'),
                          radius: SizeConfig.screenHeight * 0.09,
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text("ID"),
                        titleTextStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: ThemeService.secondaryBackgroundColor,
                        ),
                        subtitle: Text("R200483"),
                        subtitleTextStyle: TextStyle(
                          color: ThemeService.primaryTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: SizeConfig.screenHeight*0.13,
                    left: SizeConfig.screenWidth*0.3,
                    child: Container(
                      padding: EdgeInsets.all(0),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: ThemeService.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          onPressed: (){viewModel.pickAttachment();},
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color: ThemeService.primaryAccent,
                          )
                      ),
                    )
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            const ListTile(
              title: Text("Asif"),
              titleTextStyle: TextStyle(
                fontSize: 27,
                color: ThemeService.primaryTextColor,
              ),
              subtitle: Text("Sayyad"),
              subtitleTextStyle: TextStyle(
                fontSize: 30,
                color: ThemeService.secondaryBackgroundColor,
              ),
            ),
            const ListTile(
              title: Text("Profile"),
              titleTextStyle: TextStyle(
                fontSize: 20,
                color: ThemeService.secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: ThemeService.primaryColor,
                radius: 22,
                child: Icon(
                  Icons.food_bank_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              title: Text('${user.mess}'),
              titleTextStyle: const TextStyle(
                fontSize: 17,
                color: ThemeService.primaryTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: ThemeService.primaryColor,
                radius: 22,
                child: Text(
                  '${complaint.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
              ),
              title: const Text(
                "Complaints Raised",
              ),
              titleTextStyle: const TextStyle(
                fontSize: 17,
                color: ThemeService.primaryTextColor,
                fontWeight: FontWeight.w500,
              ),
              trailing: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(6), // Rounded rectangle
                ),
                child: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
