// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xy_mobil_app/voting/presentation/bloc/vote_bloc.dart';
import 'package:xy_mobil_app/voting/presentation/ui/vote_box.dart';
import 'package:xy_mobil_app/voting/repository/model/vote_detail.dart';
//import 'package:xy_mobil_app/tlog/tlog.dart';

class VoteDetailedPage extends StatelessWidget {
  const VoteDetailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TLOG
    //sl<TLog>().move('');
    return Builder(
      builder: (context) {
        final List<VoteDetail> voteDetailedList =
            context.select((VoteBloc bloc) => bloc.state.voteDetailedList);
        // Build a Form widget using the _formKey created above.
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
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: voteDetailedList
                      .map(
                        (voteDetailed) => VoteBox(
                            voteBloc: context.read<VoteBloc>(),
                            id: voteDetailed.id,
                            label: voteDetailed.detail),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
