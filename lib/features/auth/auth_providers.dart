import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zhu_app/app/app_config_provider.dart';
import 'package:zhu_app/core/network/api_dio.dart';
import 'package:zhu_app/features/auth/data/auth_data_source.dart';
import 'package:zhu_app/features/auth/data/auth_repository.dart';
import 'package:zhu_app/features/auth/data/auth_token_manager.dart';
import 'package:zhu_app/features/auth/data/auth_token_store.dart';
import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
Dio authDio(Ref ref) => createApiDio(ref.watch(appConfigProvider));

@Riverpod(keepAlive: true)
AuthTokenStore authTokenStore(Ref ref) => AuthTokenStore();

@Riverpod(keepAlive: true)
AuthDataSource authDataSource(Ref ref) =>
    AuthDataSource(ref.watch(authDioProvider));

@Riverpod(keepAlive: true)
AuthTokenManager authTokenManager(Ref ref) {
  final manager = AuthTokenManager(
    dataSource: ref.watch(authDataSourceProvider),
    store: ref.watch(authTokenStoreProvider),
  );
  ref.onDispose(manager.dispose);
  return manager;
}

@Riverpod(keepAlive: true)
AuthenticatedApiClient authenticatedApiClient(Ref ref) {
  return AuthenticatedApiClient(
    dio: createApiDio(ref.watch(appConfigProvider)),
    tokenManager: ref.watch(authTokenManagerProvider),
  );
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    dataSource: ref.watch(authDataSourceProvider),
    tokenManager: ref.watch(authTokenManagerProvider),
    authenticatedApiClient: ref.watch(authenticatedApiClientProvider),
  );
}

@Riverpod(keepAlive: true)
Stream<void> sessionInvalidations(Ref ref) {
  return ref.watch(authTokenManagerProvider).sessionInvalidations;
}
