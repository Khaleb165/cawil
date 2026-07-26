import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/show_snackbar.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/data/resources/auth_methods.dart';
import 'package:cawil/model/user.dart' as model;
import 'package:cawil/view/screens/change_password.dart';
import 'package:cawil/view/widgets/custom_button.dart';
import 'package:cawil/view/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final _usernameController = TextEditingController();
  model.User? _user;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _loadUser() async {
    final authMethods = AuthMethods();
    try {
      final cachedUser = await authMethods.cachedUser();
      if (cachedUser != null && mounted) {
        _setUser(cachedUser);
      }

      final user = await authMethods.getUserDetails();
      if (mounted) {
        _setUser(user);
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(e.toString(), context);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _setUser(model.User user) {
    setState(() {
      _user = user;
      _usernameController.text = user.username;
    });
  }

  Future<void> _saveUsername() async {
    setState(() => _isSaving = true);
    try {
      final user = await AuthMethods().updateUsername(
        username: _usernameController.text,
      );
      if (mounted) {
        _setUser(user);
        showSnackBar('Username updated successfully', context);
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(e.toString(), context);
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = _user?.email ?? '';

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(color: deepBlueColor),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(24),
                      vertical: getProportionateScreenHeight(28),
                    ),
                    child: Column(
                      crossAxisAlignment: crossStart,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                            color: lightBlackColor,
                            fontSize: getProportionateScreenHeight(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        CustomTextfield(
                          controller: _usernameController,
                          hintText: 'Username',
                          inputAction: TextInputAction.done,
                          onSubmitted: _isSaving ? null : _saveUsername,
                          maxLength: 30,
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        Text(
                          'Email',
                          style: TextStyle(
                            color: lightBlackColor,
                            fontSize: getProportionateScreenHeight(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenHeight(14),
                          ),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(
                              getProportionateScreenHeight(20),
                            ),
                          ),
                          child: Text(
                            email,
                            style: TextStyle(
                              color: lightBlackColor,
                              fontSize: getProportionateScreenHeight(14),
                            ),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(28)),
                        CustomButton(
                          text: 'Save Changes',
                          isLoading: _isSaving,
                          onPressed: _isSaving ? null : _saveUsername,
                          backgroundColor: deepBlueColor,
                          width: double.infinity,
                        ),
                        SizedBox(height: getProportionateScreenHeight(14)),
                        CustomButton(
                          text: 'Change Password',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePasswordPage(
                                  email: email,
                                ),
                              ),
                            );
                          },
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepBlueColor, deepBlueColor, purpleColor],
          tileMode: TileMode.clamp,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.elliptical(50, 50),
        ),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: whiteColor,
                  size: 22,
                ),
              ),
            ),
            Text(
              'Account',
              style: TextStyle(
                color: whiteColor,
                fontSize: getProportionateScreenHeight(25),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
