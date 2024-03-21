import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/palette/palette.dart';
import 'package:viral_vibes_mobile/src/providers/loading_indicator.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/providers/url_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_data_provider.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/services/network/_network_exception.dart';
import 'package:viral_vibes_mobile/src/services/network/network.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';
import 'package:viral_vibes_mobile/src/widgets/nunito_text_widget.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
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
          'Add Funds',
          color: theme == ThemeMode.light
              ? Palette.darkthemeContainerColor
              : Palette.primaryBackgroundColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10).r,
        child: SingleChildScrollView(
          child: Consumer(
            builder: (context, ref, _) {
              final loadingIndicator = ref.watch(addFundsLoadingProvider);
              final fundsAmountValidator = ref.watch(amountValidatorProvider);

              return Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        if (value.startsWith('0')) {
                          ref
                              .watch(amountValidatorProvider.notifier)
                              .finishedloading();
                        } else {
                          ref
                              .watch(amountValidatorProvider.notifier)
                              .isLoading();
                        }
                      } else {
                        ref
                            .watch(amountValidatorProvider.notifier)
                            .finishedloading();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Amount',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15).r,
                          borderSide: BorderSide(
                            color: Palette.tetiaryColor,
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15).r,
                      ),
                    ),
                  ),
                  Gap(5),
                  nunitoTextWidget(
                      'Note: The minimum deposit required to add funds to your account is 200 Nigerian Naira (NGN).',
                      fontSize: 10.sp,
                      color: theme == ThemeMode.light
                          ? Colors.black87
                          : Palette.secondaryBackgroundColor),
                  const Gap(20),
                  MaterialButton(
                    onPressed: fundsAmountValidator
                        ? () async {
                            ref
                                .read(addFundsLoadingProvider.notifier)
                                .isLoading();

                            // ! Perform something Asyncronous.

                            final accountId =
                                ref.watch(userDataProvider).emailAddress;

                            final amount = _controller.text..trim();

                            print(amount);

                            try {
                              final result = await initialisePayment(
                                  amount: double.parse(amount),
                                  accountId: accountId);

                              if (result.containsKey('error')) {
                              } else {
                                print("link Hosted");

                                final link = result['data']['link'];

                                ref.watch(urlProvider).setUrl(link);

                                print(ref.read(urlProvider).url);

                                if (context.mounted) {
                                  GoRouter.of(context)
                                      .goNamed(RouteName.paymentDetailScreen);
                                }
                              }
                              ref
                                  .read(addFundsLoadingProvider.notifier)
                                  .finishedloading();
                            } on NetworkException catch (e) {
                              print(e.message);
                              ref
                                  .read(addFundsLoadingProvider.notifier)
                                  .finishedloading();
                            }
                          }
                        : null,
                    color: Palette.cardColor,
                    disabledColor: Palette.tetiaryColor.withOpacity(0.6),
                    minWidth: MediaQuery.sizeOf(context).width * 0.7,
                    height: 45.h,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30).r,
                    ),
                    child: loadingIndicator
                        ? const CircularProgressIndicator.adaptive()
                        : nunitoTextWidget(
                            'Add Funds',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Palette.primaryBackgroundColor,
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> initialisePayment(
    {required double amount, required String accountId}) async {
  final endpoint = 'api/payments/payment?amount=$amount&accountId=$accountId';

  const baseUrl = 'https://api.viralvibes.hawkitpro.com';

  final networkClient = NetworkClient(baseUrl);

  final response = await networkClient.getRequest(endpoint);

  if (response.statusCode != 200) {
    return {
      'error': "An unknown error occured",
    };
  }

  final data = jsonDecode(response.body);

  return data;
}
