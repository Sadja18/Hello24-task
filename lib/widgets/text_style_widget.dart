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

  double fontSizeDouble = 12;

  void reload() {
    if (kDebugMode) {
      log("reloading");
    }
    instantiate();
    getFontSizeDouble();

    if (kDebugMode) {
      log("afer reloading");
      log(" $fontFamily $fontColor $fontSize $fontSizeDouble ");
    }
  }

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
      var foundMap = fontSizeOptions.firstWhere(
        (element) => element['value'] == tmpSize,
        orElse: () => {},
      );

      if (foundMap.containsKey("value")) {
        setState(() {
          fontSize = foundMap['value'].toString();
        });

        var t = getFontSizeDouble();
        setState(() {
          fontSizeDouble = t;
        });
        if (kDebugMode) {
          log("Fontsize == $t");
        }
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

  void clearFormatting() {
    setState(() {
      fontFamily = "serif";
      fontSize = "md";
      fontSizeDouble = 12;
      fontColor = Colors.black;
    });

    saveToLocalStorage("fontFamily", fontFamily);
    saveToLocalStorage("fontSize", fontSize);
    saveToLocalStorage("fontColor", fontColor.toString());

    reload();
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
                      FontFamilyDropdownWidget(
                        reload: reload,
                      ),
                      FontSizeWidget(
                        reload: reload,
                      ),
                      FontColorPicker(
                        reload: reload,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(
                          top: 7.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.02,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: IconButton(
                          onPressed: () {
                            if (kDebugMode) {
                              log("clearing formatting");
                            }
                            clearFormatting();
                          },
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
                    fontSize: fontSizeDouble,
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
  final VoidCallback reload;
  const FontFamilyDropdownWidget({super.key, required this.reload});

  @override
  State<FontFamilyDropdownWidget> createState() => _FontFamilyDropdownWidgetState();
}

class _FontFamilyDropdownWidgetState extends State<FontFamilyDropdownWidget> {
  String _selection = "sans-serif";

  void initialize() async {
    var fontFamily = await getKeyFromLocalStorage("fontFamily");
    if (fontFamily != null && fontFamily is String) {
      var tmpMap = fontFamilyOptions.firstWhere((element) => element['value'] == fontFamily);

      if (tmpMap.containsKey("value")) {
        setState(() {
          _selection = tmpMap['value'].toString();
        });
      }
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

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

            widget.reload();
          }),
    );
  }
}

class FontSizeWidget extends StatefulWidget {
  final VoidCallback reload;
  const FontSizeWidget({super.key, required this.reload});

  @override
  State<FontSizeWidget> createState() => _FontSizeWidgetState();
}

class _FontSizeWidgetState extends State<FontSizeWidget> {
  String _selection = "md";
  void initialize() async {
    var fontSize = await getKeyFromLocalStorage("fontSize");
    if (fontSize != null && fontSize is String) {
      var tmpMap = fontSizeOptions.firstWhere((element) => element['value'].toString() == fontSize);

      if (tmpMap.containsKey("value")) {
        setState(() {
          _selection = tmpMap['value'].toString();
        });
      }
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

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

          widget.reload();
        },
      ),
    );
  }
}

class FontColorPicker extends StatefulWidget {
  final VoidCallback reload;
  const FontColorPicker({super.key, required this.reload});

  @override
  State<FontColorPicker> createState() => _FontColorPickerState();
}

class _FontColorPickerState extends State<FontColorPicker> {
  Color startColor = Colors.black;

  late BuildContext dcontxt;

  void changeColor(Color color) {
    if (kDebugMode) {
      log("selected color ${colorToHex(color)}");
    }
    setState(() => startColor = color);

    saveToLocalStorage("fontColor", colorToHex(color).toString());

    Navigator.pop(dcontxt);

    widget.reload();
  }

  void openColorPicker(BuildContext contxt) async {
    await showDialog(
        context: contxt,
        builder: (BuildContext ctx) {
          dcontxt = ctx;
          return AlertDialog(
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: MaterialPicker(pickerColor: startColor, onColorChanged: changeColor),
            ),
          );
        });
  }

  void initialize() async {
    var fontColor = await getKeyFromLocalStorage("fontColor");
    if (fontColor != null && fontColor is String) {
      var hexColor = fontColor.replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      if (hexColor.length == 8) {
        var col = Color(int.parse("0x$hexColor"));

        setState(() {
          startColor = col;
        });
      }
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
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
