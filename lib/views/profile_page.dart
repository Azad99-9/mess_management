import 'package:flutter/material.dart';
import 'package:mess_management/services/size_config.dart';
import 'package:mess_management/services/theme_service.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:ThemeService.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title:const Text(
          "Profile",
          style: TextStyle(
            fontSize:20,
            color:ThemeService.secondaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.logout,size: 25,color: ThemeService.primaryTextColor,),),
        ],
      ),
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height:SizeConfig.screenHeight*0.03,
            ),
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
                          spreadRadius:1,
                          blurRadius: 10,
                          offset: Offset(0, 0.1),
                        ),
                      ],
                    ),
                    child:CircleAvatar(
                      key: const Key('Profile Pic'),
                      backgroundImage: NetworkImage('https://sm.askmen.com/t/askmen_in/article/f/facebook-p/facebook-profile-picture-affects-chances-of-gettin_fr3n.1200.jpg'),
                      radius: SizeConfig.screenHeight*0.09,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: ListTile(
                    title:Text("ID"),
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
            SizedBox(
              height: SizeConfig.screenHeight*0.02,
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
            const ListTile(
              leading: CircleAvatar(
                backgroundColor:ThemeService.primaryColor,
                radius: 22,
                child: Icon(Icons.food_bank_rounded,size: 30, color: Colors.white,),
              ),
              title: Text("Mess VIII"),
              titleTextStyle: TextStyle(
                fontSize: 17,
                color: ThemeService.primaryTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight*0.01,),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor:ThemeService.primaryColor,
                radius: 22,
                child:Text("5",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),),
              ),
              title: const Text("Complaints Raised",),
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
