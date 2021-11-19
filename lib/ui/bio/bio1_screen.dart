import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';

class SliverBiographyScreen extends StatefulWidget {
  static const routeName = '/biography';
  const SliverBiographyScreen({Key? key}) : super(key: key);

  @override
  State<SliverBiographyScreen> createState() => _SliverBiographyScreenState();
}

class _SliverBiographyScreenState extends State<SliverBiographyScreen> {
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
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: FlexibleHeaderDelegate(
                      statusBarHeight: MediaQuery.of(context).padding.top,
                      expandedHeight: 240,
                      background: MutableBackground(
                        expandedWidget: Container(
                          color: Theme.of(context).primaryColor,
                          child: Stack(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                margin: EdgeInsets.only(
                                  top: screenHeight * 0.09,
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
                                  padding: const EdgeInsets.all(10.0),
                                  child: CachedNetworkImage(
                                    imageUrl: state.about.headMonkImageUrl!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          width: 4,
                                        ),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        collapsedColor: Theme.of(context).primaryColor,
                      ),
                      children: [
                        FlexibleTextItem(
                          //textAlign: TextAlign.center,
                          text: 'သစ္စာပါရမီဆရာတော်ထေရုပ္ပတ္တိ',
                          collapsedStyle: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.white),
                          expandedStyle: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.white),
                          expandedAlignment: Alignment.bottomCenter,
                          collapsedAlignment: Alignment.center,
                          expandedPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                        ),
                      ]),
                ),
                SliverFillRemaining(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 0,
                      right: 0,
                      top: 0,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      //borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 0, left: 20, right: 20, bottom: 50),
                      child: Flexible(
                        child: Html(
                          data: state.about.biography,
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
                )
              ],
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
