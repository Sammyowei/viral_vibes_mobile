import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/service_manager_provicer.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';

class SeviceCategoriesScreen extends ConsumerStatefulWidget {
  final String service;
  const SeviceCategoriesScreen({super.key, String? serviceName})
      : service = serviceName ?? 'Instagram';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SeviceCategoriesScreenState();
}

class _SeviceCategoriesScreenState
    extends ConsumerState<SeviceCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: nunitoTextWidget(
          widget.service,
          fontWeight: FontWeight.bold,
          color: theme == ThemeMode.light
              ? Colors.black87
              : Palette.primaryBackgroundColor,
          fontSize: 18.sp,
        ),
      ),
      backgroundColor: theme == ThemeMode.light
          ? Palette.secondaryBackgroundColor
          : Palette.darkthemeContainerColor,
      body: Consumer(
        builder: (context, ref, child) {
          final serviceManger = ref.watch(serviceManagerProvider);
          List services;

          if (widget.service.toLowerCase() == 'others') {
            services = serviceManger.getCategoriesWithoutKeywords([
              'Instagram',
              'Facebook',
              'Youtube',
              'Twitter',
              'Spotify',
              'TikTok',
              'LinkedIn',
              'Google',
              'Telegram',
              'Discord',
              'Snapchat',
              'twitch',
              'Website Traffic',
              'Reviews',
              'Everything',
            ]);
          } else if (widget.service.toLowerCase() == 'everything') {
            services = serviceManger.getCategoriesWithoutKeywords([]);
          } else {
            services =
                serviceManger.getServiceCategoriesWithKeyword(widget.service);
          }

          final service = services;
          final _image = getImage(widget.service);
          print(service.length);
          return ListView.builder(
            itemCount: service.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print(service[index]);
                  GoRouter.of(context).pushNamed(RouteName.serviceCategoryList,
                      queryParameters: {
                        'categoryListName': service[index],
                      });
                },
                child: ServiceContainer(
                  image: _image,
                  title: service[index],
                  fontSize: 12,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

String getImage(String keyword) {
  switch (keyword) {
    case 'Instagram':
      return IconProvider.instaIcon;
    case 'Facebook':
      return IconProvider.facebookIcon;
    case 'Youtube':
      return IconProvider.youtubeIcon;
    case 'Twitter':
      return IconProvider.twitterIcon;
    case 'Spotify':
      return IconProvider.spotifyIcon;
    case 'TikTok':
      return IconProvider.tiktokIcon;
    case 'LinkedIn':
      return IconProvider.linkedInIcon;
    case 'Google':
      return IconProvider.googleIcon;
    case 'Telegram':
      return IconProvider.telegramIcon;
    case 'Discord':
      return IconProvider.discordIcon;
    case 'Snapchat':
      return IconProvider.snapChatIcon;
    case 'twitch':
      return IconProvider.twitchIcon;
    case 'Website Traffic':
      return IconProvider.websiteIcon;
    case 'Reviews':
      return IconProvider.reviewsIcon;
    case 'Others':
      return IconProvider.othersIcon;
    case 'Everything':
      return IconProvider.everythingIcon;
    default:
      // Handle the case when keyword is not found
      return '';
  }
}
