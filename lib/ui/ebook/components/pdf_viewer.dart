import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:thitsarparami/helper/enum.dart';

class PdfViewer extends StatefulWidget {
  final String url;
  final LoadPDF loadPDF;
  final String title;
  const PdfViewer({Key? key,required this.title, required this.url, required this.loadPDF})
      : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  PDFDocument? document;
  bool _isLoading = true;

  loadDocument() async {
    switch (widget.loadPDF) {
      case LoadPDF.assets:
        document = await PDFDocument.fromAsset(widget.url);
        break;
      case LoadPDF.url:
        document = await PDFDocument.fromURL(widget.url);
        break;
      case LoadPDF.file:
        document = await PDFDocument.fromURL(widget.url);
        break;
    }

    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: AutoSizeText(
          widget.title,
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
      body: Center(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : PDFViewer(document: document!),
      ),
    );
  }
}
