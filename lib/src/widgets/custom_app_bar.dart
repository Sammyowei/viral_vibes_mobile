import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/src.dart';

class CustomAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, this.title, bool centerTile = false, this.actions})
      : _centerTile = centerTile;

  final Widget? title;

  final List<Widget>? actions;
  final bool _centerTile;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final canPop = Navigator.canPop(context);

        final theme = ref.watch(themeProvider);
        return AppBar(
          actions: widget.actions,
          automaticallyImplyLeading: false,
          backgroundColor: (theme == ThemeMode.light)
              ? Palette.secondaryBackgroundColor
              : Palette.darkthemeContainerColor,
          shadowColor: (theme == ThemeMode.light)
              ? Colors.black26
              : Colors.white10.withOpacity(0.05),
          surfaceTintColor: (theme == ThemeMode.light)
              ? Palette.secondaryBackgroundColor
              : Palette.darkthemeContainerColor,
          leading: canPop
              ? Center(
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: (theme == ThemeMode.light)
                                ? Colors.black38
                                : Colors.white54,
                          ),
                        ),
                        color: (theme == ThemeMode.light)
                            ? Palette.primaryBackgroundColor
                            : Palette.darkthemeContainerColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.navigate_before_rounded,
                          color: (theme == ThemeMode.light)
                              ? Colors.black38
                              : Colors.white54,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                )
              : null,
          title: widget.title,
          centerTitle: widget._centerTile,
        );
      },
    );
  }
}
