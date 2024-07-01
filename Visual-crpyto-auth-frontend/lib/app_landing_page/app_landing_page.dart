import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/common/design/customColors.dart';
import 'package:frontend/common/design/fontStyle.dart';
import 'package:frontend/controller/landing_page_controller.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:get/get.dart';

class AppLandingPage extends StatefulWidget {
  const AppLandingPage({super.key});

  @override
  State<AppLandingPage> createState() => _AppLandingPageState();
}

class _AppLandingPageState extends State<AppLandingPage> {
    bool _isExpanded = true;
  bool _isDrawerOpen = false;
  final LandingPageController landingpagecontroller =
      Get.put(LandingPageController());
      
  @override
  void initState() {
    super.initState();
    landingpagecontroller.getUserName();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void _openDrawer() {
    _isDrawerOpen = true;
    Get.forceAppUpdate();
  }

  void _closeDrawer() {
    _isDrawerOpen = false;
    Get.forceAppUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: WillPopScope(
        onWillPop: () async {
          bool exitConfirmed = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirm Exit'),
                content: const Text('Are you sure you want to exit the app?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(false); // User does not want to exit
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // User confirms exit
                    },
                    child: const Text('Exit'),
                  ),
                ],
              );
            },
          );
          return exitConfirmed;
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).extension<AppColors>()!.c1,
            statusBarBrightness: Brightness.light,
          ),
          child: Obx(
            () => SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    TabBarView(
                      children: [
                        Container(
                          color: Theme.of(context).extension<AppColors>()!.c2,
                          child: Stack(
                            children: [
                              // Main content
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 100, top: 20),
                                    child: Container(
                                      child: Text('Hello',
                                          style: CustomTextStyle.T5(context)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 100, top: 10),
                                    child: Container(
                                      child: Text(
                                          landingpagecontroller.userName.value,
                                          style: CustomTextStyle.T5(context)),
                                    ),
                                  ),
                                  // Other content
                                ],
                              ),
                              // Side drawer
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                top: 0,
                                left: _isDrawerOpen ? 0 : -200,
                                child: GestureDetector(
                                  onHorizontalDragUpdate: (details) {
                                    if (details.delta.dx > 0) {
                                      _toggleDrawer();
                                    }
                                  },
                                  child: Container(
                                    width: 200,
                                    height: MediaQuery.of(context).size.height,
                                    color: Colors.grey[300],
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 20),
                                        Row(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                 
                                                  },
                                                  icon: Icon(Icons.person),
                                                  label: Text('Profile'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                   
                                                  },
                                                  icon: Icon(Icons.help),
                                                  label: Text('Help'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                   
                                                  },
                                                  icon: Icon(Icons.support),
                                                  label: Text('Support'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                  },
                                                  icon: Icon(Icons.logout),
                                                  label: Text('Logout'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 20,
                                left: _isDrawerOpen ? 220 : 20,
                                child: GestureDetector(
                                  onTap: _toggleDrawer,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(_isDrawerOpen
                                        ? Icons.close
                                        : Icons.menu),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 30,
                                right: 20,
                                child: Row(
                                  children: [
                                    Icon(Icons.notifications, size: 30),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.account_circle,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Theme.of(context).extension<AppColors>()!.c2,
                          child: Center(
                            child: Text('Coming Soon..!',
                                style: CustomTextStyle.T1(context)),
                          ),
                        ),
                        Container(
                          color: Theme.of(context).extension<AppColors>()!.c2,
                          child: Center(
                            child: Text('Coming Soon..!',
                                style: CustomTextStyle.T1(context)),
                          ),
                        ),
                        Container(
                          color: Theme.of(context).extension<AppColors>()!.c2,
                          child: Center(
                            child: Text('Coming Soon..!',
                                style: CustomTextStyle.T1(context)),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: DraggableScrollableSheet(
                        initialChildSize: 0.1,
                        minChildSize: 0.1,
                        maxChildSize: 0.7,
                        snap: true,
                        builder: (context, scrollController) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                              ),
                              color:
                                  Theme.of(context).extension<AppColors>()!.c11,
                            ),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 6,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      color: Theme.of(context)
                                          .extension<AppColors>()!
                                          .c10,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          'Quick Actions',
                                          style: CustomTextStyle.T4(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // First Row
                                  SizedBox(height: 10),
                                  Container(
                                    height: 130,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(context)
                                          .extension<AppColors>()!
                                          .c12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Material(
                  color: Theme.of(context).extension<AppColors>()!.c12,
                  child: TabBar(
                    indicatorColor:
                        Theme.of(context).extension<AppColors>()!.c4,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.dashboard),
                        text: 'Dashboard',
                      ),
                      Tab(
                        icon: Icon(Icons.insert_chart),
                        text: 'Usage',
                      ),
                      Tab(
                        icon: Icon(Icons.history),
                        text: 'History',
                      ),
                      Tab(
                        icon: Icon(Icons.support),
                        text: 'Support',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
