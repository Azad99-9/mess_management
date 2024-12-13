import 'package:flutter/material.dart';
import 'package:mess_management/locator.dart';
import 'package:mess_management/model/complaint_model.dart';
import 'package:mess_management/model/user_model.dart';
import 'package:mess_management/services/size_config.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:mess_management/services/user_service.dart';
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
    viewModel.context = context;
    UserModel? user = viewModel.currentUser;
    List<ComplaintModel> complaint = viewModel.complaints;

    return Scaffold(
      backgroundColor: ThemeService.primaryAccent,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: Container(
                color: ThemeService.primaryColor,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 36, 16, 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: Icon(
                                Icons.menu,
                                color: ThemeService.secondaryColor,
                              )),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Profile',
                            style: TextStyle(
                              color: ThemeService.secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: 'Know ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                                children: [
                                  TextSpan(
                                      text: 'your self',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: viewModel.isLoading
                ? Center(
                    child: Container(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: ThemeService.primaryColor,
                        )),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  UserService.currentUser?.photoURL ?? ''), // Replace with user's image URL
                            ),
                            SizedBox(width: 16),
                            Text(
                              viewModel.currentUser?.name ?? 'user', // Replace with the user's name
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          title: Text(
                            'Email Address',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              UserService.currentUser?.email ?? ''), // Replace with user's email
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
                          title: Text(
                            'Phone Number',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              viewModel.currentUser?.phoneNumber ?? ''), // Replace with user's phone number
                        ),ListTile(
                          leading: Icon(
                            Icons.person_outline,
                            color: Colors.blue,
                          ),
                          title: Text(
                            'Gender',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              viewModel.currentUser?.gender ?? 'not mentioned'), // Replace with user's phone number
                        ),ListTile(
                          leading: Icon(
                            Icons.restaurant,
                            color: Colors.blue,
                          ),
                          title: Text(
                            'Mess',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              viewModel.currentUser?.mess ?? 'not assigned'), // Replace with user's phone number
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
