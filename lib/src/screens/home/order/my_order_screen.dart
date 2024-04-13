import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/order_status_provider.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/screens/home/order/all_orders_section.dart';
import 'package:viral_vibes_mobile/src/screens/home/order/completed_orders_section.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import '../../../models/user_model.dart';

class MyOrderScreen extends ConsumerStatefulWidget {
  const MyOrderScreen({super.key, this.user});
  final User? user;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends ConsumerState<MyOrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer(builder: (context, ref, __) {
      final theme = ref.watch(themeProvider);
      return Scaffold(
        backgroundColor: (theme == ThemeMode.light)
            ? Palette.secondaryBackgroundColor
            : Palette.darkthemeContainerColor,
        appBar: AppBar(
          backgroundColor: (theme == ThemeMode.light)
              ? Palette.secondaryBackgroundColor
              : Palette.darkthemeContainerColor,
          centerTitle: false,
          title: nunitoTextWidget(
            'My Orders',
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: (theme == ThemeMode.light)
                ? Colors.black87
                : Palette.primaryBackgroundColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20).r,
          child: Column(
            children: [
              Gap(30),
              Container(
                width: size.width,
                child: TabBar(
                  controller: _controller,
                  isScrollable: true,

                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Palette.tetiaryColor,
                  automaticIndicatorColorAdjustment: true,
                  // indicator:
                  //     CircleTabIndicator(color: Palette.cardColor, radius: 4),
                  dividerColor: (theme == ThemeMode.light)
                      ? Colors.black12
                      : Palette.primaryBackgroundColor.withOpacity(0.3),
                  tabAlignment: TabAlignment.start,
                  unselectedLabelColor: (theme == ThemeMode.light)
                      ? Colors.black26
                      : Palette.primaryBackgroundColor.withOpacity(0.3),
                  labelColor: (theme == ThemeMode.light)
                      ? Colors.black54
                      : Palette.primaryBackgroundColor,
                  splashBorderRadius: BorderRadius.circular(30),

                  onTap: (value) {
                    _controller.animateTo(value);
                  },
                  labelStyle: GoogleFonts.nunito(fontSize: 10.sp),
                  tabs: const [
                    Tab(
                      text: 'All Orders',
                    ),
                    Tab(
                      text: 'Completed Orders',
                    ),
                  ],
                ),
              ),

              Gap(20),
              Consumer(
                builder: (context, ref, child) {
                  final orderStatusProvider =
                      ref.watch(orderStatusDataProvider);

                  return orderStatusProvider.when(
                    data: (data) {
                      return Expanded(
                        child: TabBarView(
                          controller: _controller,
                          children: [
                            FadeInLeft(
                                child: AllOrders(
                              orders: data,
                            )),
                            FadeInLeft(
                                child: CompletedOrders(
                              orders: data,
                            )),
                          ],
                        ),
                      );
                    },
                    error: (error, stackTrace) {
                      print('print error $error');

                      return Container();
                    },
                    loading: () {
                      return Container();
                    },
                  );
                },
              )

              //
            ],
          ),
        ),
      );
    });
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  CircleTabIndicator({
    required this.color,
    required this.radius,
  });
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CircularPainter(color: color, radius: radius);
  }
}

class _CircularPainter extends BoxPainter {
  _CircularPainter({required this.color, required this.radius});
  final double radius;
  late Color color;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;

    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);

    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
