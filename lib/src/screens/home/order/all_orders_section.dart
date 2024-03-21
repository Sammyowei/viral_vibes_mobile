import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:viral_vibes_mobile/src/assets_provider/image_provider.dart';
import 'package:viral_vibes_mobile/src/models/order_status_model.dart';
import 'package:viral_vibes_mobile/src/palette/palette.dart';
import 'package:viral_vibes_mobile/src/providers/nav_bar_state_notifier.dart';
import 'package:viral_vibes_mobile/src/providers/order_status_provider.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/widgets/nunito_text_widget.dart';

class AllOrders extends ConsumerStatefulWidget {
  const AllOrders({super.key, required this.orders});

  final List<OrderStatus> orders;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllOrdersState();
}

class _AllOrdersState extends ConsumerState<AllOrders> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final theme = ref.watch(themeProvider);
      final isEmpty = widget.orders.isEmpty;

      final reversedList = widget.orders.reversed;
      return !isEmpty
          ? RefreshIndicator(
              onRefresh: () {
                return ref.refresh(orderStatusDataProvider.future);
              },
              child: ListView.builder(
                itemCount: reversedList.length,
                padding: const EdgeInsets.all(5).r,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8).r,
                    child: OrderContainer(
                      theme: theme,
                      order: reversedList.toList()[index],
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

class OrderContainer extends ConsumerWidget {
  const OrderContainer({
    super.key,
    required this.theme,
    this.order,
  });

  final ThemeMode theme;

  final OrderStatus? order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 100.h,
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Palette.cardColor.withOpacity(0.1),
            radius: 20,
            child: Icon(
              Icons.account_balance,
              color: Palette.cardColor,
            ),
          ),
          Gap(10),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 84,
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              nunitoTextWidget(
                                "${order?.link!}",
                                fontSize: 11.sp,
                                color: theme == ThemeMode.light
                                    ? Colors.black87
                                    : Palette.primaryBackgroundColor,
                              ),
                              Gap(5),
                              Consumer(
                                builder: (context, ref, child) {
                                  return nunitoTextWidget(
                                    'Start Count: ${order!.startCount}',
                                    color: theme == ThemeMode.light
                                        ? Colors.black38
                                        : Palette.alternateTertiary
                                            .withOpacity(0.5),
                                    fontSize: 9.5.sp,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Gap(10),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.2,
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Builder(builder: (context) {
                              final formatter = NumberFormat();
                              final myDouble =
                                  double.parse(order?.remains ?? '20000');
                              final formatedNumber = formatter.format(myDouble);

                              return nunitoTextWidget(
                                'remains: +$formatedNumber',
                                fontSize: 12.sp,
                                color: theme == ThemeMode.light
                                    ? Colors.black87
                                    : Palette.primaryBackgroundColor,
                                fontWeight: FontWeight.bold,
                              );
                            }),
                            nunitoTextWidget(
                              order?.status ?? 'successful',
                              fontSize: 12.sp,
                              color: (order!.status == 'Completed')
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: theme == ThemeMode.light
                      ? Colors.black26
                      : Palette.alternateTertiary.withOpacity(0.4),
                  thickness: 0.3,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
