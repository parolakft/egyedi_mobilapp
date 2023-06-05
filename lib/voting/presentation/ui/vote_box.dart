// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:flutter/material.dart';
import 'package:xy_mobil_app/voting/presentation/bloc/vote_bloc.dart';

class VoteBox extends StatelessWidget {
  const VoteBox({
    Key? key,
    required this.voteBloc,
    required this.id,
    required this.label,
  }) : super(key: key);

  final VoteBloc voteBloc;
  final int id;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'SairaCondensed',
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Image.asset(
                      'assets/images/ertekeles_piros.png',
                      height: 60.0,
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      voteBloc.add(DoVote(id, 'LOW'));
                    },
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    child: Image.asset(
                      'assets/images/ertekeles_sarga.png',
                      height: 60.0,
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      voteBloc.add(DoVote(id, 'MID'));
                    },
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    child: Image.asset(
                      'assets/images/ertekeles_zold.png',
                      height: 60.0,
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      voteBloc.add(DoVote(id, 'HIGH'));
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
