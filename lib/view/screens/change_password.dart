import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/show_snackbar.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/data/resources/auth_methods.dart';
import 'package:cawil/view/screens/auth_screens/login.dart';
import 'package:cawil/view/widgets/custom_button.dart';
import 'package:cawil/view/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  final String email;

  const ChangePasswordPage({
    super.key,
    required this.email,
  });

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      showSnackBar('Passwords do not match', context);
      return;
    }

    setState(() => _isSaving = true);
    final authMethods = AuthMethods();

    try {
      await authMethods.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (widget.email.isEmpty) {
        await authMethods.signOut();
        if (mounted) {
          showSnackBar('Password updated. Please log in again.', context);
          _goToLogin();
        }
        return;
      }

      if (widget.email.isNotEmpty) {
        final result = await authMethods.loginUser(
          email: widget.email,
          password: newPassword,
        );
        if (result != 'success') {
          await authMethods.signOut();
          if (mounted) {
            showSnackBar('Password updated. Please log in again.', context);
            _goToLogin();
          }
          return;
        }
      }

      if (mounted) {
        showSnackBar('Password updated successfully', context);
        Navigator.pop(context);
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

  void _goToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24),
                vertical: getProportionateScreenHeight(28),
              ),
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  _fieldLabel('Current Password'),
                  SizedBox(height: getProportionateScreenHeight(8)),
                  CustomTextfield(
                    controller: _currentPasswordController,
                    hintText: 'Current password',
                    obscureText: true,
                  ),
                  SizedBox(height: getProportionateScreenHeight(18)),
                  _fieldLabel('New Password'),
                  SizedBox(height: getProportionateScreenHeight(8)),
                  CustomTextfield(
                    controller: _newPasswordController,
                    hintText: 'New password',
                    obscureText: true,
                  ),
                  SizedBox(height: getProportionateScreenHeight(18)),
                  _fieldLabel('Confirm Password'),
                  SizedBox(height: getProportionateScreenHeight(8)),
                  CustomTextfield(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm password',
                    inputAction: TextInputAction.done,
                    obscureText: true,
                    onSubmitted: _isSaving ? null : _changePassword,
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  CustomButton(
                    text: 'Update Password',
                    isLoading: _isSaving,
                    onPressed: _isSaving ? null : _changePassword,
                    backgroundColor: deepBlueColor,
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

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: lightBlackColor,
        fontSize: getProportionateScreenHeight(14),
        fontWeight: FontWeight.w600,
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
              'Password',
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
