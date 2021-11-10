import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:intl/intl.dart';

class MyanmarCalender extends StatefulWidget {
  const MyanmarCalender({Key? key}) : super(key: key);

  @override
  State<MyanmarCalender> createState() => _MyanmarCalenderState();
}

class _MyanmarCalenderState extends State<MyanmarCalender> {
  final dateString = ValueNotifier("");

  @override
  void initState() {
    super.initState();
    try {
      JavascriptRuntime jsRuntime = getJavascriptRuntime();
      getMyanmardate(jsRuntime, "my-en").then(
        (value) => {
          dateString.value = value.toString(),
        },
      );
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('error: ${e.details}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: dateString,
        builder: (context, value, widget) {
          return AutoSizeText(
            '${value.toString()} (${DateFormat('d MMMM y','my_MM').format(DateTime.now())})',
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
            maxLines: 2,
            //overflow: TextOverflow.ellipsis,
          );
        });
  }

  Future<String> getMyanmardate(
      JavascriptRuntime jsRuntime, String lang) async {
    String mcalrsJs = await rootBundle.loadString("assets/js/mcalrs.js");
    final jsResult = jsRuntime.evaluate(mcalrsJs + """getCalender()""");
    final jsStringResult = jsResult.stringResult;
    return jsStringResult;
  }
}
