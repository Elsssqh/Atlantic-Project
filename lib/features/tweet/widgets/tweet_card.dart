import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:atlanticc/common/common.dart';
import 'package:atlanticc/constants/assets_constants.dart';
import 'package:atlanticc/core/enums/tweet_type_enum.dart';
import 'package:atlanticc/features/auth/controller/auth_controller.dart';
import 'package:atlanticc/features/tweet/controller/tweet_controller.dart';
import 'package:atlanticc/features/tweet/views/twitter_reply_view.dart';
import 'package:atlanticc/features/tweet/widgets/carousel_image.dart';
import 'package:atlanticc/features/tweet/widgets/hashtag_text.dart';
import 'package:atlanticc/features/tweet/widgets/tweet_icon_button.dart';
import 'package:atlanticc/features/user_profile/view/user_profile_view.dart';
import 'package:atlanticc/models/tweet_model.dart';
import 'package:atlanticc/theme/pallete.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({
    super.key,
    required this.tweet,
  }
  );


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return currentUser == null
        ? const SizedBox()
        : ref.watch(userDetailsProvider(tweet.uid)).when(
              data: (user) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      TwitterReplyScreen.route(tweet),
                    );
                  },

                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  UserProfileView.route(user),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user.profilePic),
                                radius: 35,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (tweet.retweetedBy.isNotEmpty)
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AssetsConstants.retweetIcon,
                                        color: Color.fromARGB(255, 63, 99, 161),
                                        height: 20,
                                      ),

                                      const SizedBox(width: 2),
                                      Text(
                                        '${tweet.retweetedBy} Blues',
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 63, 99, 161),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),

                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: user.isTwitterBlue ? 1 : 5,
                                      ),

                                      child: Text(
                                        user.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                        ),
                                      ),
                                    ),
                                    
                                    if (user.isTwitterBlue)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: SvgPicture.asset(
                                          AssetsConstants.verifiedIcon,
                                        ),
                                      ),

                                    Text(
                                      '@${user.name} · ${timeago.format(
                                        tweet.tweetedAt,
                                        locale: 'en_short',
                                      )}',
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 121, 103, 210),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),

                                if (tweet.repliedTo.isNotEmpty)
                                  ref
                                      .watch(
                                          getTweetByIdProvider(tweet.repliedTo))
                                      .when(
                                        data: (repliedToTweet) {
                                          final replyingToUser = ref
                                              .watch(
                                                userDetailsProvider(
                                                  repliedToTweet.uid,
                                                ),
                                              )
                                              .value;
                                          return RichText(
                                            text: TextSpan(
                                              text: 'Replying to',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 92, 68, 137),
                                                fontSize: 16,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      ' @${replyingToUser?.name}',
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 64, 93, 117),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },

                                        error: (error, st) => ErrorText(
                                          error: error.toString(),
                                        ),
                                        loading: () => const SizedBox(),
                                      ),

                                HashtagText(text: tweet.text),
                                if (tweet.tweetType == TweetType.image)
                                  CarouselImage(imageLinks: tweet.imageLinks),
                                if (tweet.link.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  AnyLinkPreview(
                                    displayDirection:
                                        UIDirection.uiDirectionHorizontal,
                                    link: 'https://${tweet.link}',
                                  ),
                                ],

                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    right: 20,
                                  ),

                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TweetIconButton(
                                        pathName:
                                         AssetsConstants.viewsIcon,
                                        text: (tweet.commentIds.length +
                                                tweet.reshareCount +
                                                tweet.likes.length)
                                            .toString(),
                                        onTap: () {},
                                      ),

                                      TweetIconButton(
                                        pathName: AssetsConstants.commentIcon,
                                        text:
                                            tweet.commentIds.length.toString(),
                                        onTap: () {},
                                      ),

                                      TweetIconButton(
                                        pathName: AssetsConstants.retweetIcon,
                                        text: tweet.reshareCount.toString(),
                                        onTap: () {
                                          ref
                                              .read(tweetControllerProvider
                                                  .notifier)
                                              .reshareTweet(
                                                tweet,
                                                currentUser,
                                                context,
                                              );
                                        },
                                      ),

                                      LikeButton(
                                        size: 25,
                                        onTap: (isLiked) async {
                                          ref
                                              .read
                                              (tweetControllerProvider
                                                  .notifier)
                                              .likeTweet(
                                                tweet,
                                                currentUser,
                                              );
                                          return !isLiked;
                                        },

                                        isLiked: tweet.likes
                                            .contains(currentUser.uid),
                                        likeBuilder: 
                                        (isLiked) {
                                          return isLiked
                                              ? SvgPicture.asset(
                                                  AssetsConstants
                                                      .likeFilledIcon,
                                                  color: Color.fromARGB(255, 251, 175, 205),
                                                )
                                              : SvgPicture.asset(
                                                  AssetsConstants
                                                      .likeOutlinedIcon,
                                                  color: Color.fromARGB(
                                                      255, 69, 106, 170),
                                                );
                                        },

                                        likeCount: tweet.likes.length,
                                        countBuilder:
                                            (likeCount, isLiked, text) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0),
                                            child: Text(
                                              text,
                                              style: TextStyle(
                                                color: isLiked
                                                    ? Color.fromARGB(
                                                        255, 229, 128, 172)
                                                    : Color.fromARGB(
                                                        209, 168, 140, 225),
                                                fontSize: 16,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.share_outlined,
                                          size: 25,
                                          color:
                                              Color.fromARGB(255, 52, 79, 128),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 3),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Color.fromARGB(255, 63, 99, 161)),
                    ],
                  ),
                );
              },

              error: (error, stackTrace) => ErrorText(
                error:
               error.toString(),
              ),
              loading: () => const Loader(),
            );
  }
}
