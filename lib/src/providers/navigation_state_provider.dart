import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _navigatorKey = GlobalKey<NavigatorState>();
final navigatorKeyProvider = Provider((ref) => _navigatorKey);

final _scaffoldMessangerState = GlobalKey<ScaffoldMessengerState>();

final scaffoldMessangerStateProvider =
    Provider((ref) => _scaffoldMessangerState);
