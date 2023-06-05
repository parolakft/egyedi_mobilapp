// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:xy_mobil_app/categorylist/presentetion/bloc/category_list_bloc.dart';
import 'package:xy_mobil_app/categorylist/repository/model/category.dart';
import 'package:xy_mobil_app/info/presentation/bloc/info_bloc.dart';
import 'package:xy_mobil_app/injection_container.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_tile.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';
//import 'package:xy_mobil_app/tlog/tlog.dart';

class CategoryListPage extends StatelessWidget {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  CategoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CategoryListBloc>(
            param1: context.read<NavigationBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => sl<InfoBloc>(
            param1: context.read<NavigationBloc>(),
          ),
        ),
      ],
      child: const CategoryListForm(),
    );
  }
}

// Create a Form widget.
class CategoryListForm extends StatefulWidget {
  const CategoryListForm({Key? key}) : super(key: key);

  @override
  _CategoryListFormState createState() => _CategoryListFormState();
}

class _CategoryListFormState extends State<CategoryListForm> {
  final String imgPath = 'assets/images/';

  changeState(item) {
    setState(() {
      item['active'] = !item['active'];
    });
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        void _scrollListener() {
          if (controller.position.pixels ==
              controller.position.maxScrollExtent) {
            setState(() {
              context.read<CategoryListBloc>().add(LoadMoreRequested());
            });
          }
        }

        final List allergensList =
            context.select((CategoryListBloc bloc) => bloc.state.allergensList);

        final String info = context.select((InfoBloc bloc) => bloc.state.info);

        final List categories =
            context.select((CategoryListBloc bloc) => bloc.state.currentList);

        bool containsAllergen(category) {
          if (category.runtimeType == ItemTile) {
            if ((category as ItemTile).allergens.any((item) =>
                allergensList.any((element) =>
                    element["id"] == item.allergen.id &&
                    element["active"] &&
                    item.info == "YES"))) {
              return true;
            } else {
              return false;
            }
          } else {
            return false;
          }
        }

        return WillPopScope(
          onWillPop: () async {
            context.read<CategoryListBloc>().add(BackButtonPressed());
            return Future.value(false);
          },
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/pattern.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  toolbarHeight: 81,
                  title: Column(
                    children: <Widget>[
                      const Text(
                        'Összes termék',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          height: 1.2,
                          fontFamily: 'SairaCondensed',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: 'Milyen allergén ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                height: 1.2,
                                fontFamily: 'SairaCondensed',
                                fontWeight: FontWeight.w300,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'NE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    height: 1.2,
                                    fontFamily: 'SairaCondensed',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: ' legyen benne?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    height: 1.2,
                                    fontFamily: 'SairaCondensed',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                body: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                    maxHeight: 760,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 600,
                        alignment: AlignmentDirectional.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Theme(
                          data: ThemeData(
                            hintColor: Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: allergensList
                                      .map(
                                        (allergen) => InkWell(
                                          child: Container(
                                            width: 87,
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 2),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  imgPath +
                                                      allergen['icon'] +
                                                      (allergen['active']
                                                          ? '_piros'
                                                          : '') +
                                                      '.png',
                                                  height: 40.0,
                                                  fit: BoxFit.fill,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  allergen['name'],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    height: 1.2,
                                                    fontFamily:
                                                        'SairaCondensed',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            changeState(allergen);
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              SizedBox(
                                height: 522,
                                child: GridView.count(
                                  controller: controller
                                    ..addListener(_scrollListener),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 7),
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 7,
                                  crossAxisCount: 2,
                                  children: categories
                                      .map(
                                        (category) => InkWell(
                                          onTap: () {
                                            if (category.runtimeType ==
                                                Category) {
                                              context
                                                  .read<CategoryListBloc>()
                                                  .add(CategorySelected(
                                                      category));
                                            } else if (category.runtimeType ==
                                                ItemTile) {
                                              context
                                                  .read<NavigationBloc>()
                                                  .add(ItemDetailsRequested(
                                                      category));
                                            }
                                          },
                                          child: Stack(
                                            children: [
                                              category.runtimeType == ItemTile
                                                  ? Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Image.network(
                                                        "https://xyegyedidev1.intranet.parola.hu/api/egyedi/rest/images/items/" +
                                                            category.id
                                                                .toString(),
                                                        fit: BoxFit.fill,
                                                        errorBuilder: (context,
                                                            exception,
                                                            stackTrace) {
                                                          return Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/images/wood.png"),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  : Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Image.network(
                                                        "https://xyegyedidev1.intranet.parola.hu/api/egyedi/rest/images/cats/" +
                                                            category.id
                                                                .toString(),
                                                        errorBuilder: (context,
                                                            exception,
                                                            stackTrace) {
                                                          return Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/images/wood.png"),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                              containsAllergen(category)
                                                  ? Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/donotenter.png"),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  width: 200,
                                                  height: 50,
                                                  color: Colors.black38,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 15,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        category.name,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        category.runtimeType ==
                                                                Category
                                                            ? category
                                                                    .activeItemCount
                                                                    .toString() +
                                                                ' termék'
                                                            : '',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                            onTap: () {
                              context
                                  .read<NavigationBloc>()
                                  .add(ProfileRequested());
                            },
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          InkWell(
                            child: const Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 30,
                            ),
                            onTap: () {
                              context
                                  .read<CategoryListBloc>()
                                  .add(ManualRefreshRequested());
                            },
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          InkWell(
                            child: const Icon(
                              Icons.info,
                              color: Colors.white,
                              size: 30,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          20.0,
                                        ),
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(10.0),
                                    content: SizedBox(
                                      height: 540,
                                      child: SingleChildScrollView(
                                        padding: const EdgeInsets.all(6.0),
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Html(data: info),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
