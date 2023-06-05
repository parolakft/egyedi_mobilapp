// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:xy_mobil_app/authentication/presentation/bloc/logout_cubit.dart';
import 'package:xy_mobil_app/authentication/repository/model/user.dart';
import 'package:xy_mobil_app/core/failure.dart';
import 'package:xy_mobil_app/info/presentation/bloc/privacy_bloc.dart';
import 'package:xy_mobil_app/injection_container.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:xy_mobil_app/profiledetails/presentation/bloc/profile_bloc.dart';
//import 'package:xy_mobil_app/tlog/tlog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TLOG
    //sl<TLog>().move('');

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProfileBloc>(
            param1: context.read<NavigationBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => sl<PrivacyBloc>(
            param1: context.read<NavigationBloc>(),
          ),
        ),
        BlocProvider<LogoutCubit>(create: (_) => sl<LogoutCubit>()),
      ],
      child: const ProfileForm(),
    );
  }
}

// Create a Form widget.
class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final PageController _pageController = PageController(
    initialPage: 0,
  );

  double currentPage = 0;

  String _gender = '';
  String _birthDate = '';
  String _password = '';
  String _newPassword = '';

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });
    super.initState();
  }

  changeState(item) {
    setState(() {
      item['active'] = !item['active'];
    });
  }

  customBoxDecoration(isActive) {
    return BoxDecoration(
      color: isActive ? Colors.white : Colors.transparent,
      border: const Border(
          left: BorderSide(color: Colors.white, width: 1.0),
          bottom: BorderSide(color: Colors.white, width: 1.0),
          top: BorderSide(color: Colors.white, width: 1.0),
          right: BorderSide(color: Colors.white, width: 1.0)),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  getGender(String gender) {
    switch (gender) {
      case 'MALE':
        return Gender.Male;
      case 'FEMALE':
        return Gender.Female;
      case 'UNSPECIFIED':
        return Gender.Others;
    }
  }

  changeGender(Gender gender) {
    switch (gender) {
      case Gender.Male:
        _gender = 'MALE';
        break;
      case Gender.Female:
        _gender = 'FEMALE';
        break;
      case Gender.Others:
        _gender = 'UNSPECIFIED';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final User user = context.select((ProfileBloc bloc) => bloc.state.user);
        List allergensList =
            context.select((ProfileBloc bloc) => bloc.state.allergensList);
        final String privacy =
            context.select((PrivacyBloc bloc) => bloc.state.privacy);
        if (_gender.isEmpty) {
          _gender = user.gender;
        }
        if (_birthDate.isEmpty) {
          if (user.birthdate != '') {
            _birthDate = user.birthdate;
          } else {
            _birthDate = 'nincs megadva';
          }
        }
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
                body: PageView(
                  controller: _pageController,
                  children: [
                    ConstrainedBox(
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
                            const Text(
                              'Személyes adatok',
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
                              height: 40,
                            ),
                            Container(
                              height: 170.0,
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.0),
                                color: Colors.white,
                              ),
                              padding:
                                  const EdgeInsets.only(left: 20, right: 30),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Theme(
                                data: ThemeData(
                                  hintColor: Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GenderPickerWithImage(
                                      showOtherGender: true,
                                      verticalAlignedText: true,
                                      equallyAligned: true,
                                      isCircular: true,
                                      selectedGender: getGender(_gender),
                                      selectedGenderTextStyle: const TextStyle(
                                        color: Colors.orange,
                                        fontSize: 20,
                                      ),
                                      unSelectedGenderTextStyle:
                                          const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      opacityOfGradient: 0.2,
                                      linearGradient: const LinearGradient(
                                        colors: [Colors.orange, Colors.orange],
                                        tileMode: TileMode.clamp,
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        stops: [0.0, 1.0],
                                      ),
                                      padding: const EdgeInsets.all(3),
                                      size: 100,
                                      onChanged: (Gender? value) {
                                        changeGender(value!);
                                      },
                                      maleText: 'Férfi',
                                      femaleText: 'Nő',
                                      otherGenderText: 'Egyéb',
                                      otherGenderImage: const AssetImage(
                                          'assets/images/gender_unspecified.png'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              child: Container(
                                height: 55,
                                alignment: FractionalOffset.center,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 15.0)
                                    ],
                                    borderRadius: BorderRadius.circular(30.0),
                                    gradient: const LinearGradient(
                                        colors: <Color>[
                                          Colors.red,
                                          Colors.orange
                                        ])),
                                child: const Text(
                                  'MENTÉS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    height: 1.2,
                                    fontFamily: 'SairaCondensed',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<ProfileBloc>()
                                    .add(GenderChangeRequested(_gender));
                                // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 120.0,
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.0),
                                color: Colors.white,
                              ),
                              padding:
                                  const EdgeInsets.only(left: 20, right: 30),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Theme(
                                data: ThemeData(
                                  hintColor: Colors.transparent,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Születési év',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.orange,
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      child: Text(
                                        _birthDate,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate:
                                              DateTime.tryParse(_birthDate) ??
                                                  DateTime.now(),
                                          firstDate: DateTime.now().subtract(
                                              const Duration(days: 50000)),
                                          lastDate: DateTime.now(),
                                          currentDate: DateTime.now(),
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor: Colors.orange,
                                                colorScheme:
                                                    const ColorScheme.light(
                                                  primary: Colors.orange,
                                                ),
                                                buttonTheme:
                                                    const ButtonThemeData(
                                                        textTheme:
                                                            ButtonTextTheme
                                                                .primary),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        ).then((date) {
                                          setState(() {
                                            if (date != null) {
                                              _birthDate =
                                                  date.toString().split(" ")[0];
                                            }
                                          });
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              child: Container(
                                height: 55,
                                alignment: FractionalOffset.center,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 15.0)
                                    ],
                                    borderRadius: BorderRadius.circular(30.0),
                                    gradient: const LinearGradient(
                                        colors: <Color>[
                                          Colors.red,
                                          Colors.orange
                                        ])),
                                child: const Text(
                                  'MENTÉS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    height: 1.2,
                                    fontFamily: 'SairaCondensed',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<ProfileBloc>()
                                    .add(BirthDateChangeRequested(_birthDate));
                                // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              'Mire vagy allergiás?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                height: 1.2,
                                fontFamily: 'SairaCondensed',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              width: 220,
                              child: Text(
                                'Emeld ki azokat az allergéneket, amivel nem akarsz találkozni!',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 250,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 12.0,
                                runSpacing: 14.0,
                                children: allergensList
                                    .map(
                                      (allergen) => Container(
                                        margin: const EdgeInsets.all(5),
                                        decoration: customBoxDecoration(
                                            allergen['active']),
                                        child: InkWell(
                                          onTap: () {
                                            changeState(allergen);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              allergen['name'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: allergen['active']
                                                      ? Colors.orange
                                                      : Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextButton(
                              child: Container(
                                height: 55,
                                alignment: FractionalOffset.center,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 15.0)
                                    ],
                                    borderRadius: BorderRadius.circular(30.0),
                                    gradient: const LinearGradient(
                                        colors: <Color>[
                                          Colors.red,
                                          Colors.orange
                                        ])),
                                child: const Text(
                                  'MENTÉS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    height: 1.2,
                                    fontFamily: 'SairaCondensed',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<ProfileBloc>()
                                    .add(AllergiesChangeRequested());
                                // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    ConstrainedBox(
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
                            const Text(
                              'Profil',
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
                              height: 40,
                            ),
                            Container(
                              height: 60.0,
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.0),
                                color: Colors.white,
                              ),
                              padding:
                                  const EdgeInsets.only(left: 20, right: 30),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Theme(
                                data: ThemeData(
                                  hintColor: Colors.transparent,
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Régi jelszó',
                                    labelStyle:
                                        TextStyle(color: Color(0xffff5e38)),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: Color(0xffff5e38),
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'A mező kitöltése kötelező!';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  onChanged: (newValue) => _password = newValue,
                                ),
                              ),
                            ),
                            Container(
                              height: 60.0,
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.0),
                                color: Colors.white,
                              ),
                              padding:
                                  const EdgeInsets.only(left: 20, right: 30),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Theme(
                                data: ThemeData(
                                  hintColor: Colors.transparent,
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Új jelszó',
                                    labelStyle:
                                        TextStyle(color: Color(0xffff5e38)),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: Color(0xffff5e38),
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'A mező kitöltése kötelező!';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  onChanged: (newValue) =>
                                      _newPassword = newValue,
                                ),
                              ),
                            ),
                            TextButton(
                              child: Container(
                                height: 55,
                                alignment: FractionalOffset.center,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 15.0)
                                    ],
                                    borderRadius: BorderRadius.circular(30.0),
                                    gradient: const LinearGradient(
                                        colors: <Color>[
                                          Colors.red,
                                          Colors.orange
                                        ])),
                                child: const Text(
                                  'JELSZÓ VÁLTOZTATÁS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    height: 1.2,
                                    fontFamily: 'SairaCondensed',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                context.read<ProfileBloc>().add(
                                    PasswordChangeRequested(
                                        _password, _newPassword));
                                // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                              },
                            ),
                            TextButton(
                              child: Container(
                                height: 55,
                                alignment: FractionalOffset.center,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 15.0)
                                    ],
                                    borderRadius: BorderRadius.circular(30.0),
                                    gradient: const LinearGradient(
                                        colors: <Color>[
                                          Colors.red,
                                          Colors.orange
                                        ])),
                                child: const Text(
                                  'KIJELENTKEZÉS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    height: 1.2,
                                    fontFamily: 'SairaCondensed',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                context.read<LogoutCubit>().logout();
                                // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                child: const Text(
                                  'Adatvédelem',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                ),
                                onTap: () {
                                  // adatvédelem
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
                                        contentPadding:
                                            const EdgeInsets.all(10.0),
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
                                                Html(data: privacy),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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

class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.only(left: 20, right: 20),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Switch(
              value: value,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xffff5e38),
              inactiveTrackColor: Colors.grey,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
