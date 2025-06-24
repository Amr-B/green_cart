// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cart/common/default_appBar.dart';
import 'package:green_cart/config/responsive/responsive.dart';
import 'package:green_cart/config/themes/colors.dart';
import 'package:green_cart/data/data_provider.dart';
import 'package:green_cart/data/models/profile/profile_model.dart';
import 'package:green_cart/features/authentication/login/login_screen.dart';
import 'package:green_cart/features/presentation/profile/widgets/setting_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../cubits/auth/auth_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ProfileModel> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _fetchUser();
  }

  Future<ProfileModel> _fetchUser() async {
    final profiles = await DataProviders.fetchProfiles();
    return profiles.first;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = Responsive.screenHeight(context);
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: KAppBar(
        title: 'Profile',
        useDefaultBackground: false,
      ),
      body: FutureBuilder(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No profile data found'));
          }

          final profile = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      profile.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                profile.name,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: KColors.dGreen,
                ),
              ),
              Text(
                profile.email,
                style: TextStyle(
                  color: KColors.dGreen,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 45,
                width: 200,
                decoration: BoxDecoration(
                  color: KColors.dGreen,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              KSettingWidget(
                onTap: () {},
                title: 'Settings',
                icon: Icons.settings,
              ),
              SizedBox(height: 25),
              KSettingWidget(
                onTap: () {},
                title: 'Favorites',
                icon: Iconsax.heart,
              ),
              SizedBox(height: 25),
              KSettingWidget(
                onTap: () {},
                title: 'Privacy Policy',
                icon: Icons.newspaper,
              ),
              SizedBox(height: 25),
              Divider(
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  context.read<AuthCubit>().logout();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
                  );
                },
                child: Container(
                  height: 45,
                  width: 170,
                  decoration: BoxDecoration(
                    color: KColors.errorRed.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: KColors.errorRed,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
