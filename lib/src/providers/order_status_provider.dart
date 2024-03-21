import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/models/order_status_model.dart';
import 'package:viral_vibes_mobile/src/providers/user_data_provider.dart';
import 'package:viral_vibes_mobile/src/services/network/_network_exception.dart';
import 'package:viral_vibes_mobile/src/services/network/network.dart';

final orderStatusDataProvider = FutureProvider<List<OrderStatus>>((ref) async {
  final user = ref.read(userDataProvider);

  final email = user.emailAddress;

  try {
    final networkClient = NetworkClient('https://api.viralvibes.hawkitpro.com');

    final result =
        await networkClient.getRequest('api/service/check_order?id=$email');

    final body = jsonDecode(result.body);

    final decodedBody = body as List;

    final orderList = <OrderStatus>[];
    for (var element in decodedBody) {
      orderList.add(OrderStatus.fromJson(element));
    }
    return orderList;
  } on NetworkException catch (e) {
    print(e.message);
    return [];
  }
});
