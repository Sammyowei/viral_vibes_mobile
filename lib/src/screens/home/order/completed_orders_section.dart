import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/nav_bar_state_notifier.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/screens/home/order/all_orders_section.dart';

import '../../../models/order_status_model.dart';
import '../../../providers/order_status_provider.dart';
import '../../../src.dart';

class CompletedOrders extends ConsumerStatefulWidget {
  const CompletedOrders({super.key, required this.orders});

  final List<OrderStatus> orders;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompletedOrdersState();
}

class _CompletedOrdersState extends ConsumerState<CompletedOrders> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final theme = ref.watch(themeProvider);

      final orderList = widget.orders.reversed;
      List<OrderStatus> completedOrder = [];
      for (var element in orderList) {
        if (element.status == 'Completed') {
          completedOrder.add(element);
        }
      }

      final isEmpty = completedOrder.isEmpty;

      return !isEmpty
          ? RefreshIndicator(
              onRefresh: () {
                return ref.refresh(orderStatusDataProvider.future);
              },
              child: ListView.builder(
                itemCount: completedOrder.length,
                padding: const EdgeInsets.all(5).r,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8).r,
                    child: OrderContainer(
                      theme: theme,
                      order: completedOrder.toList()[index],
                    ),
                  );
                },
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  height: 231,
                  child: Column(
                    children: [
                      Image.asset(
                        ImageProviders.emptyBox,
                        height: 170,
                      ),
                      nunitoTextWidget(
                        'Oops, nothing to see here!',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: (theme == ThemeMode.light)
                            ? Colors.black87
                            : Palette.primaryBackgroundColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: nunitoTextWidget(
                          "Looks like you don't have any task available yet. Keep an eye out  for important updates from us.",
                          fontSize: 13,
                          textAlign: TextAlign.center,
                          color: (theme == ThemeMode.light)
                              ? Colors.black38
                              : Palette.primaryBackgroundColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    ref.read(bottomNavStateNotifierProvider.notifier).goTo(0);
                  },
                  color: Palette.cardColor,
                  minWidth: MediaQuery.sizeOf(context).width,
                  height: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: nunitoTextWidget(
                    'Make your first order',
                    fontSize: 15,
                    color: Palette.primaryBackgroundColor,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            );
    });
  }
}
