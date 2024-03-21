import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_data_provider.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';

class PersonalInfoScreen extends ConsumerStatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends ConsumerState<PersonalInfoScreen> {
  late TextEditingController _emailController;

  late TextEditingController _mobileController;

  late TextEditingController _userNameController;

  @override
  void initState() {
    final _user = ref.read(userDataProvider);
    _emailController = TextEditingController(text: _user.emailAddress);
    _mobileController = TextEditingController(text: _user.mobileNumber);
    _userNameController = TextEditingController(text: _user.userName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: theme == ThemeMode.light
          ? Palette.secondaryBackgroundColor
          : Palette.darkthemeContainerColor,
      appBar: CustomAppBar(
        title: nunitoTextWidget(
          "Personal Information",
          fontSize: 18.sp,
          color: theme == ThemeMode.light
              ? Colors.black87
              : Palette.primaryBackgroundColor,
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 15,
              ),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: AssetImage(
                        ImageProviders.manAvatar,
                      ),
                    ),
                    Gap(20),
                    Container(
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20).r,
                          ),
                          color: (theme == ThemeMode.light)
                              ? Palette.primaryBackgroundColor
                              : Palette.dartThemeBAckgoundColor
                                  .withOpacity(0.3)),
                      child: TextFormField(
                        controller: _userNameController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                          ).r,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              top: 14,
                              bottom: 14,
                            ).r,
                            child: Image.asset(
                              IconProvider.user,
                              height: 5.h,
                              width: 5.w,
                              color: (theme == ThemeMode.light)
                                  ? Colors.black38
                                  : Colors.white38,
                            ),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.nunito(
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
                          fontSize: 14.sp,
                        ),
                        cursorColor: Palette.tetiaryColor,
                        cursorHeight: 15.h,
                      ),
                    ),
                    Gap(10),
                    Container(
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20).r,
                          ),
                          color: (theme == ThemeMode.light)
                              ? Palette.primaryBackgroundColor
                              : Palette.dartThemeBAckgoundColor
                                  .withOpacity(0.3)),
                      child: TextFormField(
                        controller: _mobileController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                          ).r,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              top: 14,
                              bottom: 14,
                            ).r,
                            child: Image.asset(
                              IconProvider.user,
                              height: 5.h,
                              width: 5.w,
                              color: (theme == ThemeMode.light)
                                  ? Colors.black38
                                  : Colors.white38,
                            ),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.nunito(
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
                          fontSize: 14.sp,
                        ),
                        cursorColor: Palette.tetiaryColor,
                        cursorHeight: 15.h,
                      ),
                    ),
                    Gap(10),
                    Container(
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20).r,
                          ),
                          color: (theme == ThemeMode.light)
                              ? Palette.primaryBackgroundColor
                              : Palette.dartThemeBAckgoundColor
                                  .withOpacity(0.3)),
                      child: TextFormField(
                        controller: _emailController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                          ).r,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              top: 14,
                              bottom: 14,
                            ).r,
                            child: Image.asset(
                              IconProvider.user,
                              height: 5.h,
                              width: 5.w,
                              color: (theme == ThemeMode.light)
                                  ? Colors.black38
                                  : Colors.white38,
                            ),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.nunito(
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
                          fontSize: 14.sp,
                        ),
                        cursorColor: Palette.tetiaryColor,
                        cursorHeight: 15.h,
                      ),
                    ),
                    Gap(40),
                    MaterialButton(
                      onPressed: () {
                        // TODO; perform authentiction Logiic
                      },
                      child: nunitoTextWidget(
                        'Update',
                        color: Palette.primaryBackgroundColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      color: Palette.cardColor,
                      minWidth: MediaQuery.sizeOf(context).width,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20).r,
                      ),
                      height: 40.h,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
