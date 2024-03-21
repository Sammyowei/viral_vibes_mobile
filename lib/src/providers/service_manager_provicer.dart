import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/user_service_providers.dart';
import 'package:viral_vibes_mobile/src/services/vv_service/service_manager.dart';

final serviceManagerProvider = Provider<ServiceManager>((ref) {
  final services = ref.watch(serviceListProvider);
  return ServiceManager(services.serviceList);
});
