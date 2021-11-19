import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/address/components/address_tile.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = '/address';
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  _loadAddress() async {
    BlocProvider.of<AboutBloc>(context).add(const GetAboutEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final double screenHeight = MediaQuery.of(context).size.height;
    //final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: AutoSizeText(
          'သစ္စာပါရမီဘုန်းကြီးကျောင်းလိပ်စာ',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryIconTheme.color!,
          ),
        ),
      ),
      body: BlocBuilder<AboutBloc, AboutState>(
        builder: (context, state) {
          if (state is AboutError) {
            return const SomethingWentWrongScreen();
          } else if (state is AboutLoaded) {
            List<Address> addresses = state.about.addresses!;
            return ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                //Appointment appointment = value[index];
                // ignore: avoid_unnecessary_containers
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [AddressTile(about: state.about, index: index,)],
                      ),
                    ),
                  ),
                );
              },
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
