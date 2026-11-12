import 'package:durwyn_talley/src/core/utils/app_exports.dart';
import '../../../modules/authentication/data/datasources/auth_remote_data_source.dart';
import '../../../modules/authentication/data/repositories/auth_repository_impl.dart';
import '../../../modules/authentication/domain/repositories/auth_repository.dart';
import '../../../modules/contacts/data/datasources/contacts_remote_data_source.dart';
import '../../../modules/contacts/data/repositories/contacts_repository_impl.dart';
import '../../../modules/contacts/domain/repositories/contacts_repository.dart';
import '../../../modules/emergency/data/datasources/emergency_remote_data_source.dart';
import '../../../modules/emergency/data/repositories/emergency_repository_impl.dart';
import '../../../modules/emergency/domain/repositories/emergency_repository.dart';
import '../../../modules/notifications/data/datasources/notifications_remote_data_source.dart';

final locator = GetIt.instance;

void setupLocator() {
  appPrint("***Setup Registry***");
  locator.registerLazySingleton<Prefs>(() => Prefs());
  locator.registerLazySingleton<Client>(() => Client());
  locator.registerLazySingleton<ApiService>(() => ApiService());
  locator.registerLazySingleton<BaseApiService>(() => locator<ApiService>());
  locator.registerLazySingleton(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(),
      iOptions: IOSOptions.defaultOptions,
    ),
  );
  locator.registerLazySingleton<NotificationService>(
    () => NotificationService(),
  );
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(locator<BaseApiService>()),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      locator<AuthRemoteDataSource>(),
      locator<Prefs>(),
    ),
  );
  locator.registerLazySingleton<ContactsRemoteDataSource>(
    () => ContactsRemoteDataSourceImpl(locator<BaseApiService>()),
  );
  locator.registerLazySingleton<ContactsRepository>(
    () => ContactsRepositoryImpl(
      locator<ContactsRemoteDataSource>(),
      locator<Prefs>(),
    ),
  );
  locator.registerLazySingleton<EmergencyRemoteDataSource>(
    () => EmergencyRemoteDataSourceImpl(locator<BaseApiService>()),
  );
  locator.registerLazySingleton<EmergencyRepository>(
    () => EmergencyRepositoryImpl(
      locator<EmergencyRemoteDataSource>(),
      locator<Prefs>(),
    ),
  );
  locator.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSourceImpl(locator<BaseApiService>()),
  );
}
