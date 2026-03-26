import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:aurado/core/network/dio_client.dart';
import 'package:aurado/core/network/network_info.dart';
import 'package:aurado/core/network/signed_url_resolver.dart';
import 'package:aurado/core/di/service_locator.dart';
import 'package:aurado/core/local_storage/drift_database.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'provider_registry.g.dart';

@riverpod
SupabaseClient supabaseClient(Ref ref) {
  return Supabase.instance.client;
}

@riverpod
AppDatabase appDatabase(Ref ref) {
  // Database is a singleton because Drift needs to manage the connection.
  return sl<AppDatabase>();
}

@riverpod
Dio dio(Ref ref) {
  // For now, we still pull from the singleton initialized in service_locator
  // to ensure interceptors and timeouts are consistent.
  return sl<DioClient>().instance;
}

@riverpod
NetworkInfo networkInfo(Ref ref) {
  return sl<NetworkInfo>();
}

@riverpod
SignedUrlResolver signedUrlResolver(Ref ref) {
  return sl<SignedUrlResolver>();
}

@riverpod
Connectivity connectivity(Ref ref) {
  return sl<Connectivity>();
}
