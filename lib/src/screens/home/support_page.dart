import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';
import 'package:viral_vibes_mobile/src/widgets/nunito_text_widget.dart';

class SupportPage extends ConsumerStatefulWidget {
  const SupportPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SupportPageState();
}

class _SupportPageState extends ConsumerState<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final theme = ref.watch(themeProvider);
        return Scaffold(
          backgroundColor: theme == ThemeMode.light
              ? Palette.secondaryBackgroundColor
              : Palette.darkthemeContainerColor,
          appBar: CustomAppBar(
            title: nunitoTextWidget(
              'Support',
              fontSize: 18.sp,
              color: theme == ThemeMode.light
                  ? Colors.black87
                  : Palette.primaryBackgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15).r,
            child: Column(
              children: [
                Container(
                  height: 100.h,
                  padding: const EdgeInsets.all(10).r,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20).r),
                    color: theme == ThemeMode.light
                        ? Palette.primaryBackgroundColor
                        : Palette.dartThemeBAckgoundColor.withOpacity(0.6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          nunitoTextWidget(
                            'Live Chat',
                            color: theme == ThemeMode.light
                                ? Colors.black87
                                : Palette.primaryBackgroundColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                          ),
                          GestureDetector(
                            onTap: () => GoRouter.of(context)
                                .pushNamed(RouteName.supportHelpDesk),
                            child: Icon(
                              Icons.navigate_next_rounded,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          nunitoTextWidget(
                            'Email Support',
                            color: theme == ThemeMode.light
                                ? Colors.black87
                                : Palette.primaryBackgroundColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                          ),
                          GestureDetector(
                            onTap: () async => await _launchEmail(),
                            child: const Icon(
                              Icons.navigate_next_rounded,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchEmail() async {
    print('executed');
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'viralvibes@hawkitpro.com',
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Assistance Needed: [Brief Description of the Issue]',
      }),
    );

    final launched = await launchUrl(emailLaunchUri);

    if (launched == true) {
      print(true);
    } else {
      print(false);
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
