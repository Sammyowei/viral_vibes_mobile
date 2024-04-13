import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:viral_vibes_mobile/src/models/transaction_model.dart';
import 'package:viral_vibes_mobile/src/models/user_model.dart';
import 'package:viral_vibes_mobile/src/providers/nav_bar_state_notifier.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';

import 'package:viral_vibes_mobile/src/widgets/custom_wallet_card.dart';
import '../../src.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key, this.user});
  final User? user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer(builder: (context, ref, _) {
      final theme = ref.watch(themeProvider);

      return Scaffold(
        backgroundColor: (theme == ThemeMode.light)
            ? Palette.secondaryBackgroundColor
            : Palette.darkthemeContainerColor,
        appBar: AppBar(
          backgroundColor: (theme == ThemeMode.light)
              ? Palette.secondaryBackgroundColor
              : Palette.darkthemeContainerColor,
          title: nunitoTextWidget(
            'Wallet',
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: (theme == ThemeMode.light)
                ? Colors.black87
                : Palette.primaryBackgroundColor,
          ),
          centerTitle: false,
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10).w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FadeInLeft(
                child: walletCard(context, size, user: widget.user!),
              ),
              FadeInRight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    nunitoTextWidget(
                      'Recent Activities',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: (theme == ThemeMode.light)
                          ? Colors.black45
                          : Palette.primaryBackgroundColor,
                    ),
                    // GestureDetector(
                    //   child: nunitoTextWidget('See all',
                    //       color: Palette.tetiaryColor,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 14),
                    // )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.4,
                // color: Colors.amber,
                child: Consumer(
                  builder: (context, ref, _) {
                    final transHistory = widget.user!.transactionHistory;
                    final reversedList = transHistory.reversed;
                    return transHistory.isEmpty
                        ? FadeInUp(
                            child: SizedBox(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.7,
                                    child: Image.asset(
                                      ImageProviders.emptyBox,
                                      height: 140.h,
                                    ),
                                  ),
                                  nunitoTextWidget(
                                    'Oops, nothing to show here!',
                                    fontWeight: FontWeight.w600,
                                    color: (theme == ThemeMode.light)
                                        ? Colors.black45
                                        : Palette.primaryBackgroundColor,
                                  ),
                                  nunitoTextWidget(
                                    'Looks like you don\'t have any transactions at the moment.',
                                    textAlign: TextAlign.center,
                                    fontSize: 12,
                                    color: (theme == ThemeMode.light)
                                        ? Colors.black45
                                        : Palette.primaryBackgroundColor,
                                  ),
                                  Gap(50),
                                  FadeInUp(
                                    child: MaterialButton(
                                      onPressed: () {
                                        ref
                                            .read(bottomNavStateNotifierProvider
                                                .notifier)
                                            .goTo(0);
                                      },
                                      color: Palette.cardColor,
                                      height: 40,
                                      minWidth: size.width,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: nunitoTextWidget(
                                        'Make your first order',
                                        color: Palette.primaryBackgroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: transHistory.length,
                            itemBuilder: (context, index) {
                              final transaction = reversedList.toList()[index];

                              return TransactionContainer(
                                theme: theme,
                                transactions: transaction,
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class TransactionContainer extends StatelessWidget {
  const TransactionContainer({
    super.key,
    required this.theme,
    this.transactions,
  });

  final ThemeMode theme;

  final Transactions? transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76.h,
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Palette.cardColor.withOpacity(0.1),
            radius: 24.r,
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
                  height: 60.h,
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
                                "${transactions?.method}",
                                fontSize: 13.sp,
                                color: theme == ThemeMode.light
                                    ? Colors.black87
                                    : Palette.primaryBackgroundColor,
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  final date = DateTime.now();

                                  final useDate = transactions?.dateTime;

                                  final formater = DateFormat();

                                  final formatedDate =
                                      formater.format(useDate ?? date);
                                  return nunitoTextWidget(
                                    formatedDate,
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
                      const Gap(20),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.34,
                        padding: const EdgeInsets.only(top: 2.5, bottom: 2.5).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Builder(builder: (context) {
                              final formatter = NumberFormat.currency(
                                  name: 'NGN', decimalDigits: 2, symbol: '₦');

                              final formatedAmount = formatter.format(
                                transactions?.amount ?? 200000,
                              );

                              return nunitoTextWidget(
                                '+$formatedAmount',
                                fontSize: 12.sp,
                                color: theme == ThemeMode.light
                                    ? Colors.black87
                                    : Palette.primaryBackgroundColor,
                                fontWeight: FontWeight.bold,
                              );
                            }),
                            nunitoTextWidget(
                              transactions?.status ?? 'successful',
                              fontSize: 12.sp,
                              color: Colors.green,
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
