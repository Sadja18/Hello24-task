import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:hmail_settings_general_clone/extra/common_data.dart';
import 'package:hmail_settings_general_clone/extra/common_functions.dart';

class DefaultTextStyleWidget extends StatefulWidget {
  const DefaultTextStyleWidget({super.key});

  @override
  State<DefaultTextStyleWidget> createState() => _DefaultTextStyleWidgetState();
}

class _DefaultTextStyleWidgetState extends State<DefaultTextStyleWidget> {
  Color fontColor = Colors.black;
  String fontSize = "normal";
  String fontFamily = "sans-serif";

  void instantiate() async {
    var tmpCol = await getKeyFromLocalStorage('fontColor');
    var tmpSize = await getKeyFromLocalStorage('fontSize');
    var tmpFamily = await getKeyFromLocalStorage('fontFamily');

    if (kDebugMode) {
      log('tmpcol');
      log(tmpCol.toString());
      log('tmpfam');
      log(tmpFamily.toString());
      log('tmpsize');
      log(tmpSize.toString());
    }

    if (tmpCol != null && tmpCol is String) {
      // convert tmpCol string to a valid col;

      var hexColor = tmpCol.replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      if (hexColor.length == 8) {
        var col = Color(int.parse("0x$hexColor"));

        setState(() {
          fontColor = col;
        });
      }
    }

    if (tmpFamily != null && tmpFamily is String) {
      var foundMap = fontFamilyOptions.firstWhere(
        (element) => element['value'] == tmpFamily,
        orElse: () => {},
      );

      if (foundMap.containsKey("value")) {
        setState(() {
          fontFamily = foundMap['name'].toString();
        });
      }
    }

    if (tmpSize != null && tmpSize is String) {
      var foundMap = fontFamilyOptions.firstWhere(
        (element) => element['value'] == tmpSize,
        orElse: () => {},
      );

      if (foundMap.containsKey("value")) {
        setState(() {
          fontFamily = foundMap['name'].toString();
        });
      }
    }
  }

  double getFontSizeDouble() {
    switch (fontSize) {
      case 'sm':
        return 10;

      case 'md':
        return 12;

      case 'lg':
        return 14;

      case 'xl':
        return 16;

      default:
        return 12;
    }
  }

  @override
  void initState() {
    instantiate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.22,
      height: MediaQuery.of(context).size.height * 0.10,
      child: Card(
        elevation: 4.0,
        shape: const RoundedRectangleBorder(
          //<-- SEE HERE
          side: BorderSide(
            color: Colors.white,
          ),
        ),
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.22,
          alignment: Alignment.topLeft,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  // vertical: 2.0,
                ),
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.22,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FontFamilyDropdownWidget(),
                      const FontSizeWidget(),
                      const FontColorPicker(),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(
                          top: 7.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.02,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.format_clear_sharp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "This is what your body text will look like",
                  style: TextStyle(
                    color: fontColor,
                    fontSize: getFontSizeDouble(),
                    fontFamily: fontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FontFamilyDropdownWidget extends StatefulWidget {
  const FontFamilyDropdownWidget({super.key});

  @override
  State<FontFamilyDropdownWidget> createState() => _FontFamilyDropdownWidgetState();
}

class _FontFamilyDropdownWidgetState extends State<FontFamilyDropdownWidget> {
  String _selection = "sans-serif";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.08,
      height: MediaQuery.of(context).size.height * 0.05,
      child: DropdownButtonFormField(
          alignment: Alignment.topLeft,
          isDense: true,
          isExpanded: false,
          focusColor: Colors.white,
          // padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0,),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              //<-- SEE HERE
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              //<-- SEE HERE
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          value: _selection,
          items: fontFamilyOptions
              .map(
                (Map<String, String> e) => DropdownMenuItem(
                  value: e['value'].toString(),
                  child: Text(
                    e['name'].toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (String? value) {
            if (kDebugMode) {
              log("selected $value");
            }
            setState(() {
              _selection = value.toString();
            });

            saveToLocalStorage("fontFamily", value.toString());
          }),
    );
  }
}

class FontSizeWidget extends StatefulWidget {
  const FontSizeWidget({super.key});

  @override
  State<FontSizeWidget> createState() => _FontSizeWidgetState();
}

class _FontSizeWidgetState extends State<FontSizeWidget> {
  String _selection = "md";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.08,
      height: MediaQuery.of(context).size.height * 0.05,
      child: DropdownButtonFormField(
        alignment: Alignment.topLeft,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          suffixIcon: Icon(
            Icons.format_size_sharp,
          ),
        ),
        value: _selection,
        items: fontSizeOptions
            .map(
              (Map<String, String> e) => DropdownMenuItem(
                value: e['value'].toString(),
                child: Text(
                  e['name'].toString(),
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (String? value) {
          if (kDebugMode) {
            log("selected $value");
          }
          setState(() {
            _selection = value.toString();
          });

          saveToLocalStorage("fontSize", value.toString());
        },
      ),
    );
  }
}

class FontColorPicker extends StatefulWidget {
  const FontColorPicker({super.key});

  @override
  State<FontColorPicker> createState() => _FontColorPickerState();
}

class _FontColorPickerState extends State<FontColorPicker> {
  Color startColor = Colors.black;

  void changeColor(Color color) {
    if (kDebugMode) {
      log("selected color ${colorToHex(color)}");
    }
    setState(() => startColor = color);

    saveToLocalStorage("fontColor", colorToHex(color).toString());
  }

  void openColorPicker(BuildContext contxt) async {
    await showDialog(
        context: contxt,
        builder: (BuildContext ctx) {
          return AlertDialog(
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: MaterialPicker(pickerColor: startColor, onColorChanged: changeColor),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.02,
      height: MediaQuery.of(context).size.height * 0.05,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        icon: const Icon(Icons.format_color_text_sharp),
        onPressed: () {
          openColorPicker(context);
        },
      ),
    );
  }
}
