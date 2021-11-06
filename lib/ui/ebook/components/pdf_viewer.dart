import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:thitsarparami/models/models.dart';

class PdfViewer extends StatefulWidget {
  final Ebook? eBook;
  const PdfViewer({Key? key, this.eBook}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  // PDFDocument? document;
  // bool _isLoading = true;

  // loadDocument() async {
  //   document = await PDFDocument.fromURL(widget.eBook!.url);

  //   setState(() => _isLoading = false);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   loadDocument();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: AutoSizeText(
          widget.eBook!.title,
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
      body: Container()
      // Center(
      //   child: _isLoading
      //       ? const Center(child: CircularProgressIndicator())
      //       : PDFViewer(document: document!),
      // ),
    );
  }
}
