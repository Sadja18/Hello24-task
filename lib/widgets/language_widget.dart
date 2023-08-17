import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hmail_settings_general_clone/extra/common_data.dart';
import 'package:hoverover/hoverover.dart';

import '../extra/common_functions.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        alignment: Alignment.centerLeft,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LanguageRow1(),
            LanguageRow2(),
            LanguageRow3(),
          ],
        ),
      ),
    );
  }
}

class LanguageRow1 extends StatefulWidget {
  const LanguageRow1({super.key});

  @override
  State<LanguageRow1> createState() => _LanguageRow1State();
}

class _LanguageRow1State extends State<LanguageRow1> {
  String selectedLanguage = "en"; // Set the default value to "en" (English (US))

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Gmail Display Language:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.14,
              height: MediaQuery.of(context).size.height * 0.05,
              child: DropdownButtonFormField(
                // itemHeight: 25,
                isDense: true,
                isExpanded: false,
                // padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0,),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                ),
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                value: selectedLanguage,
                items: languageOptions.map((Map<String, String> e) {
                  return DropdownMenuItem(
                    value: e['key'],
                    child: Text(e['value'].toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (kDebugMode) {
                    log("message $value");
                    log(kIsWeb.toString());
                  }
                  setState(() {
                    selectedLanguage =
                        value.toString(); // Update the selectedLanguage when the user selects a different option
                  });

                  if (kIsWeb) {
                    saveToLocalStorage(
                      "default_display_language",
                      value.toString(),
                    );
                  }
                },
              ),
            ),
          ),
          HoverOver(
            builder: (isHovered) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Change language settings for other Google products",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: isHovered ? TextDecoration.underline : TextDecoration.none,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class LanguageRow2 extends StatefulWidget {
  const LanguageRow2({super.key});

  @override
  State<LanguageRow2> createState() => _LanguageRow2State();
}

class _LanguageRow2State extends State<LanguageRow2> {
  bool _checkBoxValue = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Checkbox(
              value: _checkBoxValue,
              onChanged: (newValue) {
                setState(() {
                  _checkBoxValue = bool.parse(newValue.toString());
                });
              },
              activeColor: Colors.blue.shade500,
            ),
          ),
          const SizedBox(
            child: Text(
              "text",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            child: Text(
              " - text - ",
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          HoverOver(
            builder: (isHovered) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Edit tools",
                    style: TextStyle(
                      color: Colors.blue.shade500,
                      decoration: isHovered ? TextDecoration.underline : TextDecoration.none,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            child: Text(
              " - ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Learn more",
                style: TextStyle(
                  color: Colors.blue.shade400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LanguageRow3 extends StatefulWidget {
  const LanguageRow3({super.key});

  @override
  State<LanguageRow3> createState() => _LanguageRow3State();
}

class _LanguageRow3State extends State<LanguageRow3> {
  radioSelection? _primaryRadioButtonValue = radioSelection.rtlOff;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 8.0,
      ),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 1.0,
            ),
            title: const SizedBox(
              child: Text(
                "Right to Left editing support off",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            leading: Radio<radioSelection>(
              activeColor: Colors.blue.shade600,
              value: radioSelection.rtlOff,
              groupValue: _primaryRadioButtonValue,
              onChanged: (radioSelection? value) {
                setState(() {
                  _primaryRadioButtonValue = value;
                });
              },
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 1.0,
            ),
            title: const SizedBox(
              child: Text(
                "Right to Left editing support on",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            leading: Radio<radioSelection>(
              activeColor: Colors.blue.shade600,
              value: radioSelection.rtlOn,
              groupValue: _primaryRadioButtonValue,
              onChanged: (radioSelection? value) {
                setState(() {
                  _primaryRadioButtonValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
