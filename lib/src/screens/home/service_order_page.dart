import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:viral_vibes_mobile/src/providers/loading_indicator.dart';
import 'package:viral_vibes_mobile/src/providers/navigation_state_provider.dart';
import 'package:viral_vibes_mobile/src/providers/order_status_provider.dart';
import 'package:viral_vibes_mobile/src/providers/price_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/providers/service_manager_provicer.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_data_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_service_providers.dart';
import 'package:viral_vibes_mobile/src/services/network/_network_exception.dart';
import 'package:viral_vibes_mobile/src/services/network/network.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';

class ServiceOrderPage extends ConsumerStatefulWidget {
  const ServiceOrderPage({super.key, String? serviceID})
      : _serviceID = serviceID ?? '2929';

  final String _serviceID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServiceOrderPageState();
}

class _ServiceOrderPageState extends ConsumerState<ServiceOrderPage> {
  late final TextEditingController _urlController;
  late final TextEditingController _quantityController;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final serviceManager = ref.watch(serviceManagerProvider);

        final theme = ref.watch(themeProvider);
        print(widget._serviceID);
        final service = serviceManager.getServiceById(widget._serviceID);

        final loadingIndicator = ref.watch(orderValidProvider);

        final orderLoading = ref.watch(orderLoadingProvider);

        return Scaffold(
          backgroundColor: theme == ThemeMode.light
              ? Palette.secondaryBackgroundColor
              : Palette.darkthemeContainerColor,
          appBar: CustomAppBar(
            title: nunitoTextWidget(
              '${service?.name}',
              color: theme == ThemeMode.light
                  ? Colors.black87
                  : Palette.primaryBackgroundColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10).r,
            child: Column(
              children: [
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20).r,
                    ),
                    color: (theme == ThemeMode.light)
                        ? Palette.primaryBackgroundColor
                        : Palette.primaryBackgroundColor.withOpacity(0.1),
                  ),
                  child: TextFormField(
                    controller: _urlController,
                    onChanged: (value) {
                      final urlRegExp = RegExp(
                          r'^[a-zA-Z]+:\/\/[\w\-]+(\.[\w\-]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?');
                      if (_quantityController.text.isEmpty ||
                          value.contains(urlRegExp)) {
                        ref.read(orderValidProvider.notifier).finishedloading();
                      } else {
                        ref.read(orderValidProvider.notifier).isLoading();
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        top: 10,
                      ).r,
                      hintText: 'Enter Link of Post or Page ',
                      hintStyle: GoogleFonts.nunito(
                        fontSize: 12.sp,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                          top: 14,
                          bottom: 14,
                        ).r,
                        child: Icon(
                          Icons.link,
                          color: theme == ThemeMode.light
                              ? Colors.black38
                              : Palette.alternateTertiary.withOpacity(0.7),
                          size: 18,
                        ),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.nunito(
                        color: (theme == ThemeMode.light)
                            ? Colors.black87
                            : Colors.white,
                        fontSize: 14.sp),
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
                        : Palette.primaryBackgroundColor.withOpacity(0.1),
                  ),
                  child: TextFormField(
                    controller: _quantityController,
                    onChanged: (value) {
                      try {
                        final urlRegExp = RegExp(
                            r'^[a-zA-Z]+:\/\/[\w\-]+(\.[\w\-]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?');
                        if (value.isEmpty ||
                            !_urlController.text.contains(urlRegExp)) {
                          ref
                              .read(orderValidProvider.notifier)
                              .finishedloading();
                        } else {
                          ref.read(orderValidProvider.notifier).isLoading();
                        }

                        final doubleValue = int.parse(value);
                        final convertedRate =
                            double.parse(service?.rate ?? "0");
                        ref
                            .read(priceNotifierProvider.notifier)
                            .calculatePrice(convertedRate, doubleValue);
                      } on FormatException catch (_) {
                        ref.read(orderValidProvider.notifier).finishedloading();
                        // Handle the invalid input (e.g., show an error message to the user).
                        print("Invalid input: $value");
                        ref.read(priceNotifierProvider.notifier).restart();
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        top: 10,
                      ).r,
                      hintText: 'Quantity of order',
                      hintStyle: GoogleFonts.nunito(
                        fontSize: 12.sp,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                          top: 14,
                          bottom: 14,
                        ).r,
                        child: Icon(
                          Icons.production_quantity_limits_rounded,
                          color: theme == ThemeMode.light
                              ? Colors.black38
                              : Palette.alternateTertiary.withOpacity(0.7),
                          size: 18,
                        ),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    style: GoogleFonts.nunito(
                        color: (theme == ThemeMode.light)
                            ? Colors.black87
                            : Colors.white,
                        fontSize: 14.sp),
                    keyboardType: TextInputType.number,
                    cursorColor: Palette.tetiaryColor,
                    cursorHeight: 15.h,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    2,
                    (index) => getMinMax(
                        int.parse(service?.min ?? '1'),
                        int.parse(service?.max ?? "10"),
                        index,
                        theme == ThemeMode.light
                            ? Colors.black87
                            : Palette.primaryBackgroundColor),
                  ),
                ),
                Gap(20),
                Container(
                  height: 50.h,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50).r),
                    color: Colors.deepPurpleAccent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        IconProvider.money,
                        height: 25.h,
                        color: Palette.primaryBackgroundColor,
                      ),
                      Gap(5),
                      Consumer(
                        builder: (context, ref, child) {
                          final price = ref.watch(priceNotifierProvider);
                          final formatedCurency =
                              NumberFormat.currency(name: 'NGN', symbol: '₦');

                          return nunitoTextWidget(
                            formatedCurency.format(price),
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: Palette.primaryBackgroundColor,
                          );
                        },
                      )
                    ],
                  ),
                ),
                const Gap(50),
                MaterialButton(
                  onPressed: loadingIndicator
                      ? () async {
                          ref.read(orderLoadingProvider.notifier).isLoading();
                          if (service!.category.contains('Reviews')) {
                            ref
                                .read(orderLoadingProvider.notifier)
                                .finishedloading();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Palette.errorColor,
                                  content: nunitoTextWidget(
                                      'Apologies, but these services within the ${service.category} category are currently unavailable.',
                                      fontSize: 14.sp,
                                      color: Palette.primaryBackgroundColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return;
                          }

                          final orderData = OrderData(
                              link: _urlController.text.trim(),
                              serviceID: service.serviceId,
                              quantity:
                                  int.parse(_quantityController.text..trim()));
                          final user = ref.read(userDataProvider);
                          final order = await placeOrder(
                            accountId: user.emailAddress,
                            orderData: orderData,
                          );

                          // Validate to check if order respose does not have any error.

                          if (order.containsKey('error')) {
                            ref
                                .read(orderLoadingProvider.notifier)
                                .finishedloading();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Palette.errorColor,
                                  content: nunitoTextWidget(
                                    '${order['error']}',
                                    fontSize: 14.sp,
                                    color: Palette.primaryBackgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                            return;
                          }

                          // Perform the logic by extracting the  the order and referesh the FutureProvider.

                          final message = order['message'];

                          ref
                              .read(orderLoadingProvider.notifier)
                              .finishedloading();

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Palette.successColor,
                                content: nunitoTextWidget(
                                  '${message}',
                                  fontSize: 14.sp,
                                  color: Palette.primaryBackgroundColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }

                          final data = ref.refresh(getUserProvider.future);

                          final services =
                              ref.refresh(orderStatusDataProvider.future);

                          return;
                        }
                      : null,
                  color: Palette.cardColor,
                  height: 45.h,
                  disabledColor: Palette.tetiaryColor.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30).r,
                  ),
                  minWidth: MediaQuery.sizeOf(context).width,
                  child: orderLoading
                      ? CircularProgressIndicator.adaptive(
                          backgroundColor: Palette.primaryBackgroundColor,
                        )
                      : nunitoTextWidget('Continue',
                          fontSize: 14.sp,
                          color: Palette.primaryBackgroundColor,
                          fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _quantityController = TextEditingController();

    _urlController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(priceNotifierProvider.notifier).restart();
    });
    super.initState();
  }
}

Widget getMinMax(int min, int max, int index, Color color) {
  final value = [
    nunitoTextWidget('min: $min', fontSize: 11.sp, color: color),
    nunitoTextWidget('max: $max', fontSize: 11.sp, color: color),
  ];
  return value[index];
}

Future<Map<String, dynamic>> placeOrder({
  required String accountId,
  required OrderData orderData,
}) async {
  final networkClient = NetworkClient('https://api.viralvibes.hawkitpro.com');
  const endpoint = 'api/service/add_orders';

  try {
    // Data being sent to the backend
    final data = {
      "accountID": accountId,
      "order": orderData.toJson(),
    };

    final encodedBody = jsonEncode(data);
    final response = await networkClient.postRequest(
      endpoint,
      encodedBody,
    );

    final decodedResponseBody = jsonDecode(response.body);

    return decodedResponseBody;
  } on NetworkException catch (error) {
    print(error.message);
    return {'error': "An unknown error occured."};
  }
}

class OrderData {
  OrderData({
    required this.link,
    required this.serviceID,
    required this.quantity,
  });

  final String serviceID, link;
  final int quantity;

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      link: json['link'],
      serviceID: json['serviceId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "link": link,
      "quantity": quantity,
      "serviceID": serviceID,
    };
  }
}
