// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xy_mobil_app/allergens/presentation/bloc/allergens_bloc.dart';
import 'package:xy_mobil_app/allergens/repository/allergens_repository.dart';
import 'package:xy_mobil_app/allergens/repository/datasource/allergens_remote_data_source.dart';
import 'package:xy_mobil_app/authentication/presentation/bloc/forgotten_pw_cubit.dart';
import 'package:xy_mobil_app/authentication/presentation/bloc/login_cubit.dart';
import 'package:xy_mobil_app/authentication/presentation/bloc/logout_cubit.dart';
import 'package:xy_mobil_app/authentication/presentation/bloc/registration_cubit.dart';
import 'package:xy_mobil_app/authentication/repository/authentication_repository.dart';
import 'package:xy_mobil_app/authentication/repository/datasource/authentication_local_data_source.dart';
import 'package:xy_mobil_app/authentication/repository/datasource/forgotten_pw_remote_data_source.dart';
import 'package:xy_mobil_app/authentication/repository/datasource/login_remote_data_source.dart';
import 'package:xy_mobil_app/authentication/repository/datasource/registration_remote_data_source.dart';
import 'package:xy_mobil_app/authentication/repository/forgotten_pw_repository.dart';
import 'package:xy_mobil_app/authentication/repository/login_repository.dart';
import 'package:xy_mobil_app/authentication/repository/registration_repository.dart';
import 'package:xy_mobil_app/categorylist/presentetion/bloc/category_list_bloc.dart';
import 'package:xy_mobil_app/categorylist/repository/category_list_repository.dart';
import 'package:xy_mobil_app/categorylist/repository/datasource/categories_remote_data_source.dart';
import 'package:xy_mobil_app/core/xy_api_client.dart';
import 'package:xy_mobil_app/core/xy_http_client.dart';
import 'package:xy_mobil_app/info/presentation/bloc/info_bloc.dart';
import 'package:xy_mobil_app/info/presentation/bloc/privacy_bloc.dart';
import 'package:xy_mobil_app/info/repository/datasource/info_remote_data_source.dart';
import 'package:xy_mobil_app/info/repository/datasource/privacy_remote_data_source.dart';
import 'package:xy_mobil_app/info/repository/info_repository.dart';
import 'package:xy_mobil_app/info/repository/privacy_repository.dart';
import 'package:xy_mobil_app/itemdetails/presentation/bloc/item_details_bloc.dart';
import 'package:xy_mobil_app/itemdetails/repository/datasource/item_details_remote_data_source.dart';
import 'package:xy_mobil_app/itemdetails/repository/item_details_repository.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:xy_mobil_app/navigation/presentation/ui/router_delegate.dart';
import 'package:xy_mobil_app/profiledetails/presentation/bloc/profile_bloc.dart';
import 'package:xy_mobil_app/profiledetails/repository/datasource/profile_remote_data_source.dart';
import 'package:xy_mobil_app/profiledetails/repository/profile_repository.dart';
import 'package:xy_mobil_app/settings/presentation/bloc/settings_cubit.dart';
import 'package:xy_mobil_app/settings/presentation/bloc/user_settings_bloc.dart';
import 'package:xy_mobil_app/settings/repository/datasource/settings_local_data_source.dart';
import 'package:xy_mobil_app/settings/repository/datasource/user_settings_local_data_source.dart';
import 'package:xy_mobil_app/settings/repository/datasource/user_state_local_data_source.dart';
import 'package:xy_mobil_app/settings/repository/datasource/xy_connection_remote_data_source.dart';
import 'package:xy_mobil_app/settings/repository/settings_repository.dart';
import 'package:xy_mobil_app/settings/repository/user_settings_repository.dart';
import 'package:xy_mobil_app/settings/repository/user_state_repository.dart';
import 'package:xy_mobil_app/voting/presentation/bloc/vote_bloc.dart';
import 'package:xy_mobil_app/voting/repository/datasource/vote_remote_date_source.dart';
import 'package:xy_mobil_app/voting/repository/vote_repository.dart';

final sl = GetIt.instance;

/// Service locator inicializáló függvény
///
/// Ez arra jó, hogy az egyes objektumok létrehozását leválasszuk az
/// osztályok kódjáról, így tetszőleges konfigurációban és implementációban
/// össze lehet rakni az objektumokat, nincsenek behuzalozva az alkalmazásba.
/// Teszteléshez hasznos.
///
/// Bloc-ok:
/// Factoryval jönnek létre, a BlocProvider által, az kezeli a
/// Bloc életcikulsát is.
/// Nem lehetnek singletonok, mert képernyőváltáskor megszűnhetnek és
/// újra létrejöhetnek.
///
/// Repositoryk:
/// Singletonok, egész alkalmazásra közösek, általában csak kódot tartalmaznak,
/// vagy esetleg adatok cachelt változatát.
///
/// Data source-k:
/// Singletonok, csak kód van bennük
///
/// Külső könytárak:
/// Singletonok. Egyenként meg kell viszgálni az életciklusukat, ha valahol
/// fel kell szabadítani erőforrásokat, akkor azt az objektumot be is kell
/// tenni vagy widget state-be vagy providerbe, és ott már lehet dispose-olni
/// (itt nem lehet)
///
Future<void> init() async {
  // Bloc

  sl.registerFactoryParam<CategoryListBloc, NavigationBloc, void>(
    (navigationBloc, _) => CategoryListBloc(
      appBloc: navigationBloc,
      profileRepository: sl(),
      categoryListRepository: sl(),
      allergensRepository: sl(),
    ),
  );

  sl.registerFactoryParam<ItemDetailsBloc, NavigationBloc, void>(
    (navigationBloc, _) => ItemDetailsBloc(
      appBloc: navigationBloc,
      itemDetailsRepository: sl(),
    ),
  );

  sl.registerFactoryParam<VoteBloc, NavigationBloc, void>(
    (navigationBloc, _) => VoteBloc(
      appBloc: navigationBloc,
      voteRepository: sl(),
    ),
  );

  sl.registerFactoryParam<ProfileBloc, NavigationBloc, void>(
    (navigationBloc, _) => ProfileBloc(
      appBloc: navigationBloc,
      profileRepository: sl(),
      allergensRepository: sl(),
    ),
  );

  sl.registerFactoryParam<AllergensBloc, NavigationBloc, void>(
    (navigationBloc, _) => AllergensBloc(
      appBloc: navigationBloc,
      allergensRepository: sl(),
    ),
  );

  sl.registerFactoryParam<PrivacyBloc, NavigationBloc, void>(
    (navigationBloc, _) => PrivacyBloc(
      appBloc: navigationBloc,
      privacyRepository: sl(),
    ),
  );

  sl.registerFactoryParam<InfoBloc, NavigationBloc, void>(
    (navigationBloc, _) => InfoBloc(
      appBloc: navigationBloc,
      infoRepository: sl(),
    ),
  );

  sl.registerFactory<SettingsCubit>(
    () => SettingsCubit(
      settingsRepository: sl(),
    ),
  );

  sl.registerFactoryParam<UserSettingsBloc, NavigationBloc, void>(
    (navigationBloc, _) => UserSettingsBloc(
      userSettingsRepository: sl(),
      appBloc: navigationBloc,
    ),
  );

  sl.registerFactory<NavigationBloc>(
    () => NavigationBloc(
      authenticationRepository: sl(),
      loginRepository: sl(),
      //tlog: sl(),
    ),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(loginRepository: sl()),
  );
  sl.registerFactory<LogoutCubit>(
    () => LogoutCubit(authenticationRepository: sl()),
  );
  sl.registerFactory<ForgottenPwCubit>(
    () => ForgottenPwCubit(forgottenPwRepository: sl()),
  );
  sl.registerFactory<RegistrationCubit>(
    () => RegistrationCubit(registrationRepository: sl()),
  );

  // Navigáció osztályai, stateful widgetben tároljuk ezeket, ezért nem
  // singletonok, hanem factoryval létrehozott objektumok
  sl.registerFactory<XYRouterDelegate>(
    () => XYRouterDelegate(),
  );

  // Repository
  sl.registerLazySingleton(
    () => SettingsRepository(localDataSource: sl()),
  );
  sl.registerLazySingleton(
    () => UserSettingsRepository(userSettingsLocalDataSource: sl()),
  );
  sl.registerLazySingleton(
    () => AuthenticationRepository(authenticationLocalDataSource: sl()),
  );
  sl.registerLazySingleton(
    () => UserStateRepository(userStateLocalDataSource: sl()),
  );
  sl.registerLazySingleton(
    () => LoginRepository(
      authenticationRepository: sl(),
      loginRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ForgottenPwRepository(
      forgottenPwRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => RegistrationRepository(
      registrationRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ProfileRepository(
      profileRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => CategoryListRepository(
      categoriesRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ItemDetailsRepository(
      itemDetailsRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => VoteRepository(
      voteRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => InfoRepository(
      infoRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => PrivacyRepository(
      privacyRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => AllergensRepository(
      allergensRemoteDataSource: sl(),
    ),
  );

  // Bejelentkezést nem igénylő XY adatforrások
  sl.registerLazySingleton(
    () => XYConnectionRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton(
    () => LoginRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton(
    () => ForgottenPwRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton(
    () => RegistrationRemoteDataSource(apiClient: sl()),
  );

  // Bejelentkezést igénylő
  sl.registerLazySingleton(
    () => ProfileRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton(
    () => CategoriesRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton(
    () => ItemDetailsRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton(
    () => VoteRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton(
    () => InfoRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton(
    () => PrivacyRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton(
    () => AllergensRemoteDataSource(apiClient: sl()),
  );

  // Hálózati kapcsolatot nem igénylő helyi adatforrások
  sl.registerLazySingleton(
    () => AuthenticationLocalDataSource(sharedPreferences: sl()),
  );
  sl.registerLazySingleton(
    () => UserStateLocalDataSource(sharedPreferences: sl()),
  );
  sl.registerLazySingleton(
    () => SettingsLocalDataSource(sharedPreferences: sl()),
  );
  sl.registerLazySingleton(
    () => UserSettingsLocalDataSource(sharedPreferences: sl()),
  );

  // XY API hívás alacsonyszintű kezelése
  sl.registerLazySingleton<XYApiClient>(
    () => XYApiClient(
        httpClient: sl<XYHttpClient>(),
        settingsRepository: sl<SettingsRepository>(),
        authenticationRepository: sl<AuthenticationRepository>()),
  );

  // Külső könyvtárak
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // TODO: XYHttpClient.close() hívást berakni valahova!!!
  sl.registerLazySingleton<XYHttpClient>(
      () => XYHttpClient(settingsRepository: sl<SettingsRepository>()));

  // Ezt innen már csak a ParmobilKozpontApiClient használja
  // TODO: XYHttpClient.close() hívást berakni valahova!!!
  sl.registerLazySingleton<http.Client>(() =>
      IOClient(HttpClient()..connectionTimeout = const Duration(seconds: 10)));
}
