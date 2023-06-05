import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xy_mobil_app/authentication/presentation/ui/forgotten_pw_page.dart';
import 'package:xy_mobil_app/authentication/presentation/ui/login_page.dart';
import 'package:xy_mobil_app/authentication/presentation/ui/registration_page.dart';
import 'package:xy_mobil_app/categorylist/presentetion/ui/category_list_page.dart';
import 'package:xy_mobil_app/itemdetails/presentation/ui/item_details_page.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:xy_mobil_app/navigation/presentation/ui/splash_page.dart';
import 'package:xy_mobil_app/profiledetails/presentation/ui/profile_page.dart';

/// RouterDelegate, a navigáció "lelke"
///
/// Navigation 2.0-hoz szükséges osztály, részletes leírását lásd a szülőnél.
/// - Router hozza létre, és listenerrel rákapcsolódik, így ez a delegate
/// bármikor értesíteni tudja a Router-t, hogy építse újjá a megjelenített
/// képernyőket
/// (1: de ezt a mechanizmust nem használjuk, e helyett
/// a NavigationBloc állapotváltozásai fogják újraépíteni a Navigatort).
/// - A navigációs logika alapján az alkalmazás állapottól függően
/// létrehozza a Navigator-t, a képernyők stackjével (build() metódus).
/// - a mi implementációnkban a navigációs logika a navigációs bloc-ban van
/// implementálva, ezért ez az osztály annak állapotváltozásait figyeli csak,
/// és állapotváltozáskor értesíti a Router-t, hogy újraépítés szükséges
/// (2: nem értesíti, e helyett a NavigationBloc állapotváltozásai
/// fogják a build() metódusban újraépíteni a Navigatort).
/// - újraépítéskor a Router az itteni build() metódussal, a navigációs állapot
/// alapján felépíti a képernyők stackjét (a legfelső jelenik meg, az alatta
/// levők takarásban vannak, de állapotuk él)
/// - kezeli a mobil "vissza" gombját, és a "pop"-ot (a stack legfelső
/// képernyője eltűnik, és az alatta levő jelenik meg) úgy, hogy a szükséges
/// állapotra állítja a navigációs állapotot, majd szól a Routernek hogy
/// újraépítés szükséges (a mi implementációnkban ezt a navigációs bloc
/// állapotváltozásával éri el).
/// (3: nem szól a Router-nek, csak a NavigationBloc-nak küld egy
/// "PagePopped" eventet, a NavigationBloc pedig a saját aktuális állapotából
/// eldönti, hogy melyik oldalt poppolták, és mi legyen a következő állapot)
///
/// Navigation 2.0 nagyon bonyolult, de ezáltal szét lehet választani az
/// alkalmazásban a navigációt és az egyes navigációs állapotokban megjelenő
/// képernyők definícióját (deklaratív route-olás).
/// Még most fejlődik, érdemes követni, valamint készülnek rá az egyszerűbben
/// használható könyvtárak is.
/// A mi egyszerű appunkra jó ez az alacsonyszintű megoldás, komolyabb
/// feladatnál (pl. tabbed navigation nested route-okkal) esetleg érdemes lesz
/// figyelni a külső könyvtárak fejlesztését.
///
/// Elég magasszintű tutorial:
/// https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade
///
/// Példa:
/// - imperatív route-olás:
///   A: - Hova akarsz menni?
///   B: - Itt egyenesen, majd az első kereszteződésnél balra, utána a másodiknál
///     jobbra stb.
///   A: (fogalma sincs, hol a cél, csak megy az instrukciók alapján)
/// - deklaratív route-olás:
///   A: - Hova akarsz menni?
///   B: - A könyvtárba.
///   A: (megnézi térképen, hol a könyvtár vagy tudja fejből az utat stb.)
///
class XYRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  XYRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  /// Router hívja, amikor beszóltunk neki, hogy újraépítsen
  /// 1: nem szólunk be neki soha, mert a NavigationBloc
  /// állapotváltozásai fogják újraépíteni a Navigator-t.
  ///
  /// Az állapot alapján felépíti a Navigator-t z aktuális képernyő stackkel
  /// ("pages" paraméter)
  /// pages: képernyők listája, ami egy stack, a legelső elem van legalul, a
  /// legutolsó elem legfelül, tehét a legutolsó látszik
  ///
  /// Navigator megoldja, hogy megnézi a korábbi stacket valamint az újat, és
  /// csak a módosításokat játssza le, a megfelelő animálásokkal. Ehhez fontos,
  /// hogy a key-ek jól legyenek megadva.
  /// Tehát nem mi mondjuk meg, hogy "pusholj a stackre egy rendelés részelek
  /// képernyőt" vagy "popold a legfelső képernyőt", hanem odaadjuk a
  /// Navigator-nak az aktuális navigációs állapotnak megfelelő stacket, és ő
  /// majd eldönti, hogy pushol vagy popol, vagy módosít. Így akár több képernyő
  /// pusholásra vagy popolásra is van lehetőség, vagy akár teljes képernyő-
  /// cserére is úgy, hogy nekünk nem kell a push és pop műveletekkel
  /// foglalkozni, és nem kell azokat bedrótozni a képernyő kódjába, így
  /// a képernyő elrendezés elválik a navigációs folyamunktól.
  ///
  /// 2: nem a Router dönti el, hogy mikor legyen újraépítés,
  /// hanem a NavigationBloc állapotváltozásai, ezért nem hívjuk sehol a
  /// notifyListeners() függvényt.
  ///
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      // ez a BlocBuilder biztosítja, hogy minden egyes NavigationState
      // változásnál újraépül a Navigator (az már intelligensen megoldja, hogy
      // csak az oldalak stackjének változásakor változtatja meg  a képernyőket
      // a megfelelő animációkkal)
      builder: (context, navigationState) {
        return Navigator(
          key: navigatorKey,
          pages: [
            if (navigationState is SplashNavigationState)
              const MaterialPage(
                  key: ValueKey('splash_page'), child: SplashPage()),
            if (navigationState is LoginNavigationState)
              const MaterialPage(
                  key: ValueKey('login_page'),
                  child: LoginPage(),
                  maintainState: false),
            if (navigationState is RegistrationNavigationState)
              const MaterialPage(
                  key: ValueKey('registration_page'),
                  child: RegistrationPage()),
            if (navigationState is ForgottenPwNavigationState)
              const MaterialPage(
                  key: ValueKey('forgotten_pw_page'), child: ForgottenPwPage()),
            if (navigationState is CategoryNavigationState)
              MaterialPage(
                  key: const ValueKey('category_page'),
                  child: CategoryListPage()),
            if (navigationState is ProfileNavigationState)
              const MaterialPage(
                  key: ValueKey('profile_page'), child: ProfilePage()),
            if (navigationState is ItemDetailsNavigationState)
              const MaterialPage(
                  key: ValueKey('item_details_page'), child: ItemDetailsPage()),
            //else if (navigationState is OrderListNavigationState)
            // minden olyan route, ahol a stack alján a listaképernyő van
            // illetve a listaképernyő maga
            //MaterialPage(key: const ValueKey('order_list_page'),child: OrderListPage()),
            //if (navigationState is OrderDetailsNavigationState)
            //MaterialPage(key: ValueKey('order_details_${navigationState.orderHeaderId}_${navigationState.orderId}_page'),
            //child: const OrderDetailsPage())
            //else if (navigationState is SettingsNavigationState)
            //const MaterialPage(key: ValueKey('settings_page'), child: SettingsPage()),
            //if (navigationState is OrderDetailsAddProductNavigationState)
            //MaterialPage(key: ValueKey('add_product_${navigationState.partnerId}_page'), child:
            //ProductListPage( partnerId: navigationState.partnerId, orderStatus: navigationState.orderStatus,
            //phase: navigationState.phase, deliveryDate: navigationState.deliveryDate))
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) return false;
            BlocProvider.of<NavigationBloc>(context).add(PagePopped());
            return true;
          },
        );
      },
    );
  }

  /// Amikor a rendszer tetszőleges címmel indítja
  /// el az alkalmazást (deep-linking), akkor ezt hívja meg, itt kell az
  /// ehhez tartozó navigációs állapotot beállítani (újraépítés követi).
  ///
  /// Mobilon egyelőre ez sohasem hívódik (illetve a setInitialRoutePath()
  /// default implementációja igazából ezt hívja).
  ///
  /// 3: jelenleg ezt nem használjuk. A kezdeti állapot a
  /// NavigationBloc-ban dől el.
  ///
  @override
  Future<void> setNewRoutePath(configuration) async {}
}
