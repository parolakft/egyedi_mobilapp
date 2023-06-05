import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xy_mobil_app/injection_container.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:xy_mobil_app/navigation/presentation/ui/router_delegate.dart';
import 'package:xy_mobil_app/settings/presentation/bloc/user_settings_bloc.dart';

/// Fő widget az alkalmazásszintű bloc-ok létrehozására
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (_) => sl<NavigationBloc>()..add(ApplicationOpened()),
        ),
        BlocProvider<UserSettingsBloc>(
          create: (context) => sl<UserSettingsBloc>(
            param1: context.read<NavigationBloc>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'parMobil rendelés',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          typography: Typography.material2018(platform: defaultTargetPlatform),
          // Default AppBar háttérszín
          appBarTheme: AppBarTheme.of(context)
              .copyWith(backgroundColor: const Color(0xfff8931f)),
          // Default font family...
          fontFamily: 'HPSimplified',
        ),
        home: Router(
          routerDelegate: sl<XYRouterDelegate>(),
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
