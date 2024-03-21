import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:viral_vibes_mobile/src/providers/service_manager_provicer.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';

class ServiceCategoryListScreen extends ConsumerStatefulWidget {
  const ServiceCategoryListScreen({super.key, String? serviceCategoryName})
      : _servicecategoryName = serviceCategoryName ?? 'Instagram THREADS Likes';

  final String _servicecategoryName;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServiceCategoryListScreenState();
}

class _ServiceCategoryListScreenState
    extends ConsumerState<ServiceCategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: nunitoTextWidget(
          widget._servicecategoryName,
          color: theme == ThemeMode.light
              ? Colors.black87
              : Palette.primaryBackgroundColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: theme == ThemeMode.light
          ? Palette.secondaryBackgroundColor
          : Palette.darkthemeContainerColor,
      body: Consumer(
        builder: (context, ref, child) {
          final serviceManager = ref.watch(serviceManagerProvider);

          final services = serviceManager.getServicesByCategoryKeyword(
            widget._servicecategoryName,
          );
          final word = widget._servicecategoryName.split(' ');

          final keyword = word.first;

          final image = getImage(keyword);
          return ListView.builder(
            itemCount: services.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print(services[index].serviceId);
                  GoRouter.of(context).pushNamed(
                    RouteName.serviceOrderPage,
                    queryParameters: {'serviceId': services[index].serviceId},
                  );
                },
                child: Builder(builder: (context) {
                  final formatedCurency =
                      NumberFormat.currency(name: 'NGN', symbol: '₦');
                  return ServiceContainer(
                    image: image,
                    title:
                        '${services[index].name}     ${formatedCurency.format(double.parse(services[index].rate))}/1K',
                    fontSize: 12,
                  );
                }),
              );
            },
          );
        },
      ),
    );
  }
}

String getImage(String keyword) {
  // Check if the input keyword contains a particular keyword
  if (keyword.contains('Instagram')) {
    return IconProvider.instaIcon;
  } else if (keyword.contains('Facebook')) {
    return IconProvider.facebookIcon;
  } else if (keyword.contains('Youtube')) {
    return IconProvider.youtubeIcon;
  } else if (keyword.contains('X')) {
    return IconProvider.twitterIcon;
  } else if (keyword.contains('Spotify')) {
    return IconProvider.spotifyIcon;
  } else if (keyword.contains('TikTok')) {
    return IconProvider.tiktokIcon;
  } else if (keyword.contains('LinkedIn')) {
    return IconProvider.linkedInIcon;
  } else if (keyword.contains('Google')) {
    return IconProvider.googleIcon;
  } else if (keyword.contains('Telegram')) {
    return IconProvider.telegramIcon;
  } else if (keyword.contains('Discord')) {
    return IconProvider.discordIcon;
  } else if (keyword.contains('Snapchat')) {
    return IconProvider.snapChatIcon;
  } else if (keyword.contains('twitch')) {
    return IconProvider.twitchIcon;
  } else if (keyword.contains('Website Traffic')) {
    return IconProvider.websiteIcon;
  } else if (keyword.contains('Reviews')) {
    return IconProvider.reviewsIcon;
  } else if (!keyword.contains('Instagram') &&
      !keyword.contains('Facebook') &&
      !keyword.contains('Youtube') &&
      !keyword.contains('Twitter') &&
      !keyword.contains('Spotify') &&
      !keyword.contains('TikTok') &&
      !keyword.contains('LinkedIn') &&
      !keyword.contains('Google') &&
      !keyword.contains('Telegram') &&
      !keyword.contains('Discord') &&
      !keyword.contains('Snapchat') &&
      !keyword.contains('twitch') &&
      !keyword.contains('Website Traffic') &&
      !keyword.contains('Reviews')) {
    return IconProvider.othersIcon;
  } else if (keyword.contains('Everything')) {
    return IconProvider.everythingIcon;
  } else {
    // Handle the case when keyword is not found
    return IconProvider.everythingIcon;
  }
}
