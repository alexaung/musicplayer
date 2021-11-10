import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/ebook/components/pdf_viewer.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';
import 'package:thitsarparami/widgets/base_widget.dart';

class EbookScreen extends StatefulWidget {
  static const routeName = '/ebook';
  final Monk? monk;
  const EbookScreen({Key? key, this.monk}) : super(key: key);

  @override
  State<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {
  // List Ebooks = [];
  _loadEbooks() async {
    BlocProvider.of<EbookBloc>(context).add(const GetEbooksEvent());
  }

  @override
  void initState() {
    super.initState();
    _loadEbooks();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Monk;

    return BaseWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: AutoSizeText(
            widget.monk!.title,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          leading: IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const RootScreen()),
              // );
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryIconTheme.color!,
            ),
          ),
        ),
        body: BlocBuilder<EbookBloc, EbookState>(
          builder: (BuildContext context, EbookState eBookState) {
            if (EbookState is EbookError) {
              // final error = EbookState.error;
              // String message = '$error\n Tap to Retry.';
              return const SomethingWentWrongScreen();
            } else if (eBookState is EbookLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      itemCount: eBookState.eBooks.length,
                      itemBuilder: (_, int index) {
                        return GestureDetector(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: PdfViewer(eBook: eBookState.eBooks[index],),
                              withNavBar: false
                            );
                          },
                          child: _listView(index, eBookState.eBooks[index]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _listView(int index, Ebook eBook) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
          height: 170.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 180,
                      child: AutoSizeText(
                        eBook.title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          top: 15.0,
          bottom: 15.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              width: 110.0,
              image: NetworkImage(
                eBook.thumbnail,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
