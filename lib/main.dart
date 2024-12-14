import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mess_management/constants/routes.dart';
import 'package:mess_management/firebase_options.dart';
import 'package:mess_management/router.dart';
import 'package:mess_management/services/notification_services.dart';

import 'package:mess_management/services/hive_service.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:mess_management/views/common_issues.dart';
import 'package:mess_management/views/complaints.dart';
import 'package:mess_management/views/menu.dart';
import 'package:mess_management/views/profile_page.dart';
import 'package:mess_management/locator.dart';
import 'package:mess_management/views/feedback_page.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  setUpLocator();
  final appDocumentDir = await getApplicationDocumentsDirectory();

  // Initialize Hive with the directory path
  Hive.init(appDocumentDir.path);

  HiveService.menuCacheBox = await HiveService().openBox(HiveService.menuCache);
  runApp(const MyApp());

}
@pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
   NotificationServices().showNotification(message);

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: ThemeService.primaryColor),
        useMaterial3: true,
      ),
      navigatorKey: navigationService.navigatorKey,
      initialRoute: userService.loggedIn ? Routes.home : Routes.signIn,
      onGenerateRoute: generateRoute,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState()
  {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.getToken();
    // notificationService.FirebaseInit(context);
  }
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onBottomNavTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: ThemeService.primaryAccent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: ThemeService.primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RGUKT',
                    style: TextStyle(
                      color: ThemeService.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Mess Management System',
                    style: TextStyle(
                      color: ThemeService.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeedbackPage()));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.feedback_outlined,
                      size: 35,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Feedback',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubmitComplaintPage()));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.report_gmailerrorred,
                      size: 35,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Complaints',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.report_gmailerrorred,
            //     size: 40,
            //   ),
            //   title: Text(
            //     'Complaints',
            //     style: TextStyle(
            //         color: Colors.black.withOpacity(0.6),
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold),
            //   ),
            //   onTap: () {
            //     // Handle menu tap
            //     Navigator.pop(context); // Closes the drawer
            //   },
            // ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          MessMenuPage(),
          CommonIssues(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: ThemeService.primaryColor,
          unselectedItemColor: ThemeService.secondaryBackgroundColor,
          currentIndex: _currentPage,
          onTap: _onBottomNavTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph),
              label: 'Trending',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
