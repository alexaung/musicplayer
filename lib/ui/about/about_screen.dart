import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = '/about';
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
    _loadAbout();
  }

  _loadAbout() async {
    BlocProvider.of<AboutBloc>(context).add(const GetAboutEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<AboutBloc, AboutState>(
        builder: (context, state) {
          if (state is AboutError) {
            return const SomethingWentWrongScreen();
          } else if (state is AboutLoaded) {
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColorDark,
                      Theme.of(context).primaryColorLight,
                    ],
                    begin: const FractionalOffset(0.0, 0.4),
                    end: Alignment.centerRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 0,
                        left: 0,
                        right: 0,
                      ),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: IconButton(
                          onPressed: () {
                            // advancedPlayer.stop();
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 0,
                        left: 0,
                        right: 0,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColorDark,
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColorLight,
                          ],
                          stops: const [
                            0.0,
                            0.5,
                            0.7,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 0,
                        right: 0,
                        top: screenHeight * 0.11 + 75,
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 70, left: 20, right: 20, bottom: 50),
                        child: Flexible(
                          child: Html(
                            data: state.about.aboutThitsarparami,
                            style: {
                              "body": Style(
                                  fontSize: const FontSize(18.0),
                                  //fontWeight: FontWeight.w600,
                                  lineHeight: LineHeight.em(1.5)),
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.11,
                        left: (screenWidth - 150) / 2,
                        right: (screenWidth - 150) / 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).primaryColorLight,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).primaryColorDark,
                              width: 4,
                            ),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
