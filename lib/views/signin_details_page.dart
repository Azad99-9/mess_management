import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_management/services/size_config.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:mess_management/view_model/signin_details_view_model.dart';
import 'package:mess_management/locator.dart';

class SigninDetailsPage extends StatefulWidget {
  const SigninDetailsPage({super.key, required this.userDetails});

  final User userDetails;

  @override
  State<SigninDetailsPage> createState() => _SigninDetailsPageState();
}

class _SigninDetailsPageState extends State<SigninDetailsPage> {
  late final SigninDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = locator<SigninDetailsViewModel>();
    _viewModel.initialise(widget.userDetails, setState);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: ThemeService.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.07,
            ),
            Container(
              height: SizeConfig.screenHeight * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // SizedBox(
                  //   height: SizeConfig.screenHeight * 0.35,
                  //   child: Stack(
                  //     children: <Widget>[
                  //       Positioned(
                  //         top: SizeConfig.screenHeight * 0.1,
                  //         left: SizeConfig.screenWidth * 0.3,
                  //         child: CircleAvatar(
                  //           key: const Key('Profile Pic'),
                  //           backgroundImage: const NetworkImage(
                  //               'https://th.bing.com/th/id/OIP.D2Gzy7GXSgpAshfRx9tkHAHaHa?rs=1&pid=ImgDetMain'),
                  //           radius: SizeConfig.screenHeight * 0.09,
                  //         ),
                  //       ),
                  //       Positioned(
                  //         top: SizeConfig.screenHeight * 0.28,
                  //         left: SizeConfig.screenWidth * 0.05,
                  //         child: const Text(
                  //           "Mess Management System",
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             fontSize: 25,
                  //             fontWeight: FontWeight.w800,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  ),
                  const Text(
                    "RGUKT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00444E),
                    ),
                  ),
                  const Text(
                    "Mess Management System",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00444E),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.05,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                        child: Column(
                      children: <Widget>[
                        TextFormField(
                          cursorColor: ThemeService.primaryColor,
                          controller: _viewModel.nameController,
                          focusNode: _viewModel.nameFocus,
                          onTap: () {},
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            prefixIconColor:
                                ThemeService.secondaryBackgroundColor,
                            labelText: "Name",
                            labelStyle: TextStyle(
                              color: ThemeService.secondaryBackgroundColor,
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ThemeService.primaryTextColor,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ThemeService.primaryColor,
                            )),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ThemeService.secondaryBackgroundColor,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        TextFormField(
                          cursorColor: ThemeService.primaryColor,
                          controller: _viewModel.emailController,
                          focusNode: _viewModel.emailFocus,
                          enabled: false,
                          readOnly: true,
                          onTap: () {},
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            prefixIconColor:
                                ThemeService.secondaryBackgroundColor,
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: ThemeService.secondaryBackgroundColor,
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ThemeService.primaryTextColor,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ThemeService.primaryColor,
                            )),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ThemeService.secondaryBackgroundColor,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        TextFormField(
                          cursorColor: ThemeService.primaryColor,
                          controller: _viewModel.phoneController,
                          focusNode: _viewModel.phoneFocus,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            prefixIconColor:
                                ThemeService.secondaryBackgroundColor,
                            labelText: "Mobile Number",
                            labelStyle: TextStyle(
                              color: ThemeService.secondaryBackgroundColor,
                              fontSize: 18,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ThemeService.primaryTextColor,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ThemeService.primaryColor,
                            )),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ThemeService.secondaryBackgroundColor,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ThemeService.primaryTextColor,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ThemeService.primaryColor,
                            )),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ThemeService.secondaryBackgroundColor,
                            )),
                          ),
                          value: _viewModel.genderController.text.isNotEmpty
                              ? _viewModel.genderController.text
                              : null,
                          onChanged: (String? newValue) {
                            setState(() {
                              _viewModel.genderController.text = newValue!;
                            });
                          },
                          isDense: true,
                          items: [
                            DropdownMenuItem(
                              value: "male",
                              child: Text("Male"),
                            ),
                            DropdownMenuItem(
                              value: "female",
                              child: Text("Female"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              _viewModel.submit();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(130, 50),
                              elevation: 0,
                              backgroundColor: ThemeService.primaryAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    18), // Rounded corners
                                // side: BorderSide(
                                //   color: ThemeService
                                //       .secondaryBackgroundColor, // Border color
                                //   width: 0, // Border width
                                // ),
                              ),
                            ),
                            child: _viewModel.isLoading
                                ? Container(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
