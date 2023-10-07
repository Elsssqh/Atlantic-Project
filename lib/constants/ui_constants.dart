import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:atlanticc/constants/constants.dart';
import 'package:atlanticc/features/explore/view/explore_view.dart';
import 'package:atlanticc/features/notifications/views/notification_view.dart';
import 'package:atlanticc/features/tweet/widgets/tweet_list.dart';
import 'package:atlanticc/theme/pallete.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.atlanticLogo,
        color: Pallete.whiteColor,
        height: 230,
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> bottomTabBarPages = [
    TweetList(),
    ExploreView(),
    NotificationView(),
  ];
}
