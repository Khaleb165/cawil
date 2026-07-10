import 'package:cawil/constants/colors.dart';
import 'package:cawil/constants/size_config.dart';
import 'package:cawil/resources/auth_methods.dart';
import 'package:cawil/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String username = '';
  String email = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    try {
      final authMethods = AuthMethods();
      final cachedUser = await authMethods.cachedUser();
      if (cachedUser != null && mounted) {
        setState(() {
          username = cachedUser.username;
          email = cachedUser.email;
        });
      }

      final user = await authMethods.getUserDetails();
      if (mounted) {
        setState(() {
          username = user.username;
          email = user.email;
        });
      }
    } catch (_) {
      if (username.isEmpty && mounted) {
        setState(() => username = 'User');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [deepBlueColor, deepBlueColor, purpleColor],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(50, 50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: crossStart,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.notes_sharp,
                              size: 30,
                              color: whiteColor,
                            )),
                      ),
                      SizedBox(width: getProportionateScreenWidth(50)),
                      Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(40)),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'SETTINGS',
                            style: TextStyle(
                              letterSpacing: 3,
                              color: whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: lightPurpleColorShade2,
                        child: Text(
                          username.isNotEmpty ? username[0].toUpperCase() : 'U',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: deepBlueColor,
                          ),
                        ),
                      ),
                      SizedBox(width: getProportionateScreenWidth(10)),
                      Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                                fontSize: 25,
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.5),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 12,
                              color: whiteColor,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Column(
              children: [
                settingsListTile(() {}, 'assets/images/person.png', 'Account'),
                settingsListTile(
                    () {}, 'assets/images/bell.png', 'Notifications'),
                settingsListTile(
                    () {}, 'assets/images/location.png', 'Location'),
                settingsListTile(() {}, 'assets/images/person.png', 'Support'),
                settingsListTile(() {}, 'assets/images/share.png', 'Share'),
                settingsListTile(() async {
                  await AuthMethods().signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                }, 'assets/images/logout.png', 'Logout'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget settingsListTile(VoidCallback onTap, String imageText, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: lightPurpleColorShade2,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(imageText),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 19,
              color: lightBlackColor,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: lightPurpleColorShade2,
            size: 18,
          ),
        ),
      ),
    );
  }
}
