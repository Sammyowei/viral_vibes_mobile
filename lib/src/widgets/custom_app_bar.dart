import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/src.dart';

class CustomAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title, bool centerTile = false})
      : _centerTile = centerTile;

  final Widget? title;
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
        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Palette.secondaryBackgroundColor,
          shadowColor: Colors.black26,
          surfaceTintColor: Palette.secondaryBackgroundColor,
          leading: canPop
              ? Center(
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.black38,
                            )),
                        color: Palette.primaryBackgroundColor,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.navigate_before_rounded,
                          color: Colors.black38,
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
