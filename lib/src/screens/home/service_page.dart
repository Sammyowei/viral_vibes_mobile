import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_service_providers.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';

class ServiceScreen extends ConsumerStatefulWidget {
  const ServiceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends ConsumerState<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: theme == ThemeMode.light
          ? Palette.secondaryBackgroundColor
          : Palette.darkthemeContainerColor,
      appBar: CustomAppBar(
        title: GestureDetector(
          onTap: () async => ref.refresh(serviceProvider.future),
          child: nunitoTextWidget(
            'All Services',
            fontWeight: FontWeight.bold,
            color: theme == ThemeMode.light
                ? Colors.black87
                : Palette.primaryBackgroundColor,
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final getServices = ref.watch(serviceProvider);
          return getServices.when(
            data: (data) {
              final serviceList = ref.watch(serviceListProvider);

              final services = <ServiceContainer>[
                ServiceContainer(
                    image: IconProvider.instaIcon, title: 'Instagram'),
                ServiceContainer(
                    image: IconProvider.facebookIcon, title: 'Facebook'),
                ServiceContainer(
                    image: IconProvider.youtubeIcon, title: 'Youtube'),
                ServiceContainer(
                    image: IconProvider.twitterIcon, title: 'Twitter'),
                ServiceContainer(
                    image: IconProvider.spotifyIcon, title: 'Spotify'),
                ServiceContainer(
                    image: IconProvider.tiktokIcon, title: 'TikTok'),
                ServiceContainer(
                    image: IconProvider.linkedInIcon, title: 'LinkedIn'),
                ServiceContainer(
                    image: IconProvider.googleIcon, title: 'Google'),
                ServiceContainer(
                    image: IconProvider.telegramIcon, title: 'Telegram'),
                ServiceContainer(
                    image: IconProvider.discordIcon, title: 'Discord'),
                ServiceContainer(
                    image: IconProvider.snapChatIcon, title: 'Snapchat'),
                ServiceContainer(
                    image: IconProvider.twitchIcon, title: 'twitch'),
                ServiceContainer(
                    image: IconProvider.websiteIcon, title: 'Website Traffic'),
                ServiceContainer(
                    image: IconProvider.reviewsIcon, title: 'Reviews'),
                ServiceContainer(
                    image: IconProvider.othersIcon, title: 'Others'),
                ServiceContainer(
                    image: IconProvider.everythingIcon, title: 'Everything'),
              ];

              print(data.first.serviceId);
              serviceList.addAll(data);
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: RefreshIndicator(
                  child: ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                              RouteName.serviceCategory,
                              queryParameters: {
                                'serviceName': services[index]._title
                              });
                        },
                        child: services[index],
                      );
                    },
                  ),
                  onRefresh: () => ref.refresh(serviceProvider.future),
                ),
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: nunitoTextWidget('An Error occured',
                    color: theme == ThemeMode.light
                        ? Colors.black87
                        : Palette.primaryBackgroundColor),
              );
            },
            loading: () {
              return Skeletonizer(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ServiceContainer(
                      image: IconProvider.hide,
                      title: 'Hide',
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ServiceContainer extends ConsumerWidget {
  const ServiceContainer({
    super.key,
    required String image,
    required String title,
    double? fontSize,
    FontWeight? fontWeight,
  })  : _image = image,
        _title = title,
        _fontSize = fontSize ?? 14,
        _fontWeight = fontWeight ?? FontWeight.bold;
  final String _image;
  final String _title;

  final double _fontSize;
  final FontWeight _fontWeight;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Container(
      height: 68.h,
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: theme == ThemeMode.light
                ? Palette.primaryBackgroundColor
                : Palette.alternateTertiary.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                _image,
                height: 40.h,
                width: 40.w,
              ),
            ),
          ),
          const Gap(20),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.78,
            child: Consumer(
              builder: (context, ref, child) {
                final theme = ref.watch(themeProvider);
                return nunitoTextWidget(
                  _title,
                  fontWeight: _fontWeight,
                  color: theme == ThemeMode.light
                      ? Colors.black87
                      : Palette.primaryBackgroundColor,
                  fontSize: _fontSize.sp,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
