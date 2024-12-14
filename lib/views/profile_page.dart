import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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

    return Scaffold(
      backgroundColor: ThemeService.primaryAccent,
      body: CustomScrollView(
        slivers: [
          _buildHeader(context),
          SliverToBoxAdapter(
            child: viewModel.isLoading
                ? _buildShimmerEffect()
                : _buildProfileDetails(viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(bottom: 14),
        child: Container(
          color: ThemeService.primaryColor,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 36, 16, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: ThemeService.secondaryColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                        color: ThemeService.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
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
    );
  }

  Widget _buildProfileDetails(ProfilePageViewModel viewModel) {
    UserModel? user = viewModel.currentUser;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage:
                NetworkImage(UserService.currentUser?.photoURL ?? ''),
              ),
              SizedBox(width: 16),
              Text(
                user?.name ?? 'User',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildListTile(Icons.email, 'Email Address',
              UserService.currentUser?.email ?? ''),
          _buildListTile(Icons.phone, 'Phone Number',
              user?.phoneNumber ?? 'Not provided'),
          _buildListTile(Icons.person_outline, 'Gender',
              user?.gender ?? 'Not mentioned'),
          _buildListTile(Icons.restaurant, 'Mess', user?.mess ?? 'Not assigned'),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildShimmerEffect() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: CircleAvatar(radius: 40, backgroundColor: Colors.grey),
              ),
              SizedBox(width: 16),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 120,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ...List.generate(
            4,
                (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
