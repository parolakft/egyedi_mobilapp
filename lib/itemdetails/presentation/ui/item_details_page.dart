// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:xy_mobil_app/core/failure.dart';
import 'package:xy_mobil_app/info/presentation/bloc/info_bloc.dart';
import 'package:xy_mobil_app/injection_container.dart';
import 'package:xy_mobil_app/itemdetails/presentation/bloc/item_details_bloc.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_details.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:xy_mobil_app/voting/presentation/bloc/vote_bloc.dart';
import 'package:xy_mobil_app/voting/presentation/ui/vote_box.dart';
import 'package:xy_mobil_app/voting/repository/model/vote_detail.dart';

class ItemDetailsPage extends StatelessWidget {
  const ItemDetailsPage({Key? key}) : super(key: key);

  String getAllergens(ItemDetails item) {
    String allergens = '';
    for (var allergen in item.allergens) {
      if (allergen.info == 'YES') {
        allergens = allergens + allergen.allergen.name + ', ';
      }
    }
    return allergens;
    // return allergens.substring(0, allergens.length - 2);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ItemDetailsBloc>(
            param1: context.read<NavigationBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => sl<VoteBloc>(
            param1: context.read<NavigationBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => sl<InfoBloc>(
            param1: context.read<NavigationBloc>(),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          final List<VoteDetail> voteDetailedList =
              context.select((VoteBloc bloc) => bloc.state.voteDetailedList);
          final VoteBloc voteBloc = context.read<VoteBloc>();

          final String info =
              context.select((InfoBloc bloc) => bloc.state.info);

          final ItemDetails item =
              context.select((ItemDetailsBloc bloc) => bloc.state.item);
          return Stack(
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
                  toolbarHeight: 41,
                  title: Column(
                    children: [
                      Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          height: 1.2,
                          fontFamily: 'SairaCondensed',
                          fontWeight: FontWeight.w700,
                        ),
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
                        height: 640,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                "https://xyegyedidev1.intranet.parola.hu/api/egyedi/rest/images/items/" +
                                    item.id.toString(),
                                fit: BoxFit.fill,
                                errorBuilder: (context, exception, stackTrace) {
                                  return Container();
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Allergének',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontFamily: 'SairaCondensed',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      getAllergens(item),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        height: 1.2,
                                        fontFamily: 'SairaCondensed',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const Text(
                                      'Összetevők',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontFamily: 'SairaCondensed',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Html(
                                      data: item.ingredients,
                                    ),
                                    const Text(
                                      'Leírás',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontFamily: 'SairaCondensed',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      item.description,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        height: 1.2,
                                        fontFamily: 'SairaCondensed',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const Text(
                                      'Tápértékek',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontFamily: 'SairaCondensed',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Column(
                                    children: item.nutritions
                                        .map(
                                          (nutrition) => Column(
                                            children: [
                                              const Divider(
                                                thickness: 1.0,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/' +
                                                        nutrition.detail.icon +
                                                        '.png',
                                                    height: 40.0,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    nutrition.detail.fullName,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      height: 1.2,
                                                      fontFamily:
                                                          'SairaCondensed',
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    nutrition.value,
                                                    style: const TextStyle(
                                                      color: Colors.orange,
                                                      fontSize: 16,
                                                      height: 1.2,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  const Divider(
                                    thickness: 1.0,
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Column(
                                  children: [
                                    VoteBox(
                                      voteBloc: voteBloc,
                                      id: 0,
                                      label: 'Tetszett?',
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    BlocConsumer<ItemDetailsBloc,
                                        ItemDetailsState>(
                                      listener: (context, state) {
                                        // if (state.status.isFailure) {
                                        //   _displayError(context, state.error);
                                        // }
                                      },
                                      builder: (context, state) {
                                        return TextButton(
                                          child: Container(
                                            height: 40,
                                            alignment: FractionalOffset.center,
                                            decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Colors.black38,
                                                      blurRadius: 15.0)
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                gradient: const LinearGradient(
                                                    colors: <Color>[
                                                      Colors.red,
                                                      Colors.orange
                                                    ])),
                                            child: const Text(
                                              'Részletes értékelés',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                height: 1.2,
                                                fontFamily: 'SairaCondensed',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          onPressed:
                                              // state.status.isLoading
                                              //     ? null
                                              //     :
                                              () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                        20.0,
                                                      ),
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    vertical: 10.0,
                                                  ),
                                                  content: SizedBox(
                                                    height: 540,
                                                    child:
                                                        SingleChildScrollView(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6.0),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children:
                                                            voteDetailedList
                                                                .map((voteDetailed) =>
                                                                    Column(
                                                                        children: [
                                                                          VoteBox(
                                                                              voteBloc: voteBloc,
                                                                              id: voteDetailed.id,
                                                                              label: voteDetailed.detail),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          const Divider(),
                                                                        ]))
                                                                .toList(),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
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
                                  .read<NavigationBloc>()
                                  .add(CategoryRequested());
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
          );
        },
      ),
    );
  }

  void _displayError(BuildContext context, Exception? error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            mapExceptionToErrorMessage(error),
            // SnackBar színek
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xffff5e39),
        ),
      );
  }
}
