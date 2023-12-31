import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/screens/home/order/all_orders_section.dart';
import 'package:viral_vibes_mobile/src/screens/home/order/canceled_orders_section.dart';
import 'package:viral_vibes_mobile/src/screens/home/order/completed_orders_section.dart';
import 'package:viral_vibes_mobile/src/screens/home/order/inprogress_orders_sections.dart';
import 'package:viral_vibes_mobile/src/screens/home/order/partial_orders_section.dart';
import 'package:viral_vibes_mobile/src/screens/home/order/pending_orders_section.dart';
import 'package:viral_vibes_mobile/src/screens/home/order/processing_orders_sesction.dart';
import 'package:viral_vibes_mobile/src/src.dart';

class MyOrderScreen extends ConsumerStatefulWidget {
  const MyOrderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends ConsumerState<MyOrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Palette.secondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.secondaryBackgroundColor,
        centerTitle: false,
        title: nunitoTextWidget(
          'My Orders',
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
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
                dividerColor: Colors.black12,
                tabAlignment: TabAlignment.start,
                unselectedLabelColor: Colors.black38,
                labelColor: Colors.black87,
                splashBorderRadius: BorderRadius.circular(0),
                onTap: (value) {
                  _controller.animateTo(value);
                },
                tabs: const [
                  Tab(
                    text: 'All Orders',
                  ),
                  Tab(
                    text: 'Completed Orders',
                  ),
                  Tab(
                    text: 'Cancelled Orders',
                  ),
                  Tab(
                    text: 'Processing Orders',
                  ),
                  Tab(
                    text: 'Pending Orders',
                  ),
                  Tab(
                    text: 'Partial Completed Orders',
                  ),
                  Tab(
                    text: 'In Progress Orders',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  FadeInLeft(child: const AllOrders()),
                  FadeInLeft(child: const CompletedOrders()),
                  FadeInLeft(child: const CancelledOrders()),
                  FadeInLeft(child: const ProcessingOrders()),
                  FadeInLeft(child: const PendingOrders()),
                  FadeInLeft(child: const PartialOrders()),
                  FadeInLeft(child: const InProgressOrders())
                ],
              ),
            )
          ],
        ),
      ),
    );
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
