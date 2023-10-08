import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:atlanticc/common/loading_page.dart';
import 'package:atlanticc/features/auth/controller/auth_controller.dart';
import 'package:atlanticc/features/user_profile/contoller/user_profile_controller.dart';
import 'package:atlanticc/features/user_profile/view/user_profile_view.dart';
import 'package:atlanticc/theme/palette.dart';

 

class SideDrawer extends ConsumerWidget {

  const SideDrawer({super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {

    final currentUser = ref.watch(currentUserDetailsProvider).value;

 

    if (currentUser == null) {

      return const Loader();

    }

 

    return SafeArea(

      child: Drawer(

        backgroundColor: Color.fromARGB(255, 10, 22, 67),

        child: Column(

          children: [

            const SizedBox(height: 49),

            ListTile(

              leading: const Icon(

                Icons.person,

                size: 30,

              ),

              title: const Text(

                'My Profile',

                style: TextStyle(

                  fontSize: 22,

                ),

              ),

              onTap: () {

                Navigator.push(

                  context,

                  UserProfileView.route(currentUser),

                );

              },

            ),

            ListTile(

              leading: const Icon(

                Icons.payment,

                size: 30,

              ),

              title: const Text(

                'Atlantic Blue',

                style: TextStyle(

                  fontSize: 22,

                ),

              ),

              onTap: () {

                ref

                    .read(userProfileControllerProvider.notifier)

                    .updateUserProfile(

                      userModel: currentUser.copyWith(isTwitterBlue: true),

                      context: context,

                      bannerFile: null,

                      profileFile: null,

                    );

              },

            ),

            ListTile(

              leading: const Icon(

                Icons.logout,

                size: 30,

              ),

              title: const Text(

                'Log Out',

                style: TextStyle(

                  fontSize: 22,

                ),

              ),

              onTap: () {

                ref.read(authControllerProvider.notifier).logout(context);

              },

            ),

          ],

        ),

      ),

    );

  }

}