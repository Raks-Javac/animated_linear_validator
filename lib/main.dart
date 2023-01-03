import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String appName = 'Flutter Animated Validator';
const Color backgroundColor = Colors.black45;
const Color containerColor = Color(0xFF3A3A3A);

enum PasswordStrengthEnum { weak, medium, strong, great }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black45,
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(title: appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isObscure = true;
  isObscureState() {
    isObscure = !isObscure;
    setState(() {});
  }

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  RegExp symbolReg = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  String password = '';
  changePasswordStringState() {
    password = textEditingController.text.trim();
    setState(() {});
  }

  Color indicatorColor = Colors.red;
  double indicatorValue = 0;

  validationCheck(BuildContext context) {
    if (password.length < 6) {
      setState(() {
        strengthState = PasswordStrengthEnum.weak;
        indicatorColor = Colors.red;
        indicatorValue = 15;
        // _displayText = 'Your password is acceptable but not strong';
      });
    }

    if (password.length == 6 || password.length == 7) {
      if (password.contains(letterReg) && password.contains(numReg)) {
        setState(() {
          strengthState = PasswordStrengthEnum.medium;
          indicatorColor = Colors.yellow;
          indicatorValue = MediaQuery.of(context).size.width / 2.5;
          // _displayText = 'Your password is acceptable but not strong';
        });
      } else {
        setState(() {
          strengthState = PasswordStrengthEnum.weak;
          indicatorColor = Colors.red;
          indicatorValue = MediaQuery.of(context).size.width / 15;
          // _displayText = 'Your password is acceptable but not strong';
        });
      }
    }

    if (password.length >= 8) {
      if (password.contains(letterReg) && password.contains(numReg)) {
        setState(() {
          strengthState = PasswordStrengthEnum.strong;
          indicatorColor = Colors.green;
          indicatorValue = MediaQuery.of(context).size.width;
        });
      }
    }
  }

  PasswordStrengthEnum strengthState = PasswordStrengthEnum.weak;

  String get returnStringBasedOnValidation {
    switch (strengthState) {
      case PasswordStrengthEnum.medium:
        return "Password is medium";
      case PasswordStrengthEnum.strong:
        return "Password is strong";
      case PasswordStrengthEnum.great:
        return "Password is great";
      default:
        return "Password is weak";
    }
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password Strength Checker",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      cursorColor:
                                          Colors.white.withOpacity(0.5),
                                      cursorWidth: 1.0,
                                      controller: textEditingController,
                                      obscureText: isObscure,
                                      onChanged: (val) {
                                        changePasswordStringState();
                                        validationCheck(context);
                                      },
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(color: Colors.white),
                                      decoration: InputDecoration(
                                        fillColor: backgroundColor,
                                        isCollapsed: false,
                                        focusedBorder: InputBorder.none,
                                        hintText: "password",
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        disabledBorder: InputBorder.none,
                                        hintStyle: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: Colors.white
                                                    .withOpacity(0.4)),
                                        enabled: true,
                                        focusColor: backgroundColor,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MaterialButton(
                                      color: containerColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      onPressed: () {
                                        isObscureState();
                                      },
                                      child: Text(
                                        isObscure == true ? "Show" : "Hide",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.white),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                            child: (password.isNotEmpty &&
                                    textEditingController.text.isNotEmpty)
                                ? Text(
                                    returnStringBasedOnValidation,
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: indicatorColor),
                                  )
                                : const SizedBox.shrink(),
                          )
                        ],
                      ),
                    ),
                    if (password.isNotEmpty &&
                        textEditingController.text.isNotEmpty)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: indicatorColor,
                        ),
                        width: indicatorValue,
                        height: 5,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
