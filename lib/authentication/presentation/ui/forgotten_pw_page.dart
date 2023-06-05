// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xy_mobil_app/authentication/presentation/bloc/forgotten_pw_cubit.dart';
import 'package:xy_mobil_app/core/api_state.dart';
import 'package:xy_mobil_app/core/failure.dart';
import 'package:xy_mobil_app/injection_container.dart';
//import 'package:xy_mobil_app/tlog/tlog.dart';

class ForgottenPwPage extends StatelessWidget {
  const ForgottenPwPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TLOG
    //sl<TLog>().move('');

    return BlocProvider(
      create: (_) => sl<ForgottenPwCubit>(),
      child: const ForgottenPwForm(),
    );
  }
}

// Create a Form widget.
class ForgottenPwForm extends StatefulWidget {
  const ForgottenPwForm({Key? key}) : super(key: key);

  @override
  _ForgottenPwFormState createState() => _ForgottenPwFormState();
}

class _ForgottenPwFormState extends State<ForgottenPwForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String _email = '';

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
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
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 25,
                      ),
                      Image.asset(
                        'assets/images/parola.png',
                        height: 70.0,
                        fit: BoxFit.contain,
                      ),
                      const Text(
                        'ELFELEJTETT JELSZÓ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          height: 1.2,
                          fontFamily: 'SairaCondensed',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        height: 60.0,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(left: 20, right: 30),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Theme(
                          data: ThemeData(
                            hintColor: Colors.transparent,
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: TextStyle(color: Color(0xffff5e38)),
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xffff5e38),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Az e-mail kitöltése kötelező!';
                              } else if (!EmailValidator.validate(value)) {
                                return 'Nem megfelelő e-mail formátum!';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _email = newValue ?? '',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      BlocConsumer<ForgottenPwCubit, ApiState<void>>(
                        listener: (context, state) {
                          if (state.status.isFailure) {
                            _displayError(context, state.error);
                          }
                        },
                        builder: (context, state) {
                          return TextButton(
                            child: Container(
                              height: 55,
                              alignment: FractionalOffset.center,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black38, blurRadius: 15.0)
                                  ],
                                  borderRadius: BorderRadius.circular(30.0),
                                  gradient: const LinearGradient(
                                      colors: <Color>[
                                        Colors.red,
                                        Colors.orange
                                      ])),
                              child: const Text(
                                'JELSZÓ ÚJRAKÜLDÉSE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  height: 1.2,
                                  fontFamily: 'SairaCondensed',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            onPressed: state.status.isLoading
                                ? null // bejelentkezés folyamata alatt a gomb le van tiltva
                                : () {
                                    final form = _formKey.currentState;
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (form!.validate()) {
                                      form.save();
                                      context
                                          .read<ForgottenPwCubit>()
                                          .lostPassword(_email);
                                      // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                                    }
                                  },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
