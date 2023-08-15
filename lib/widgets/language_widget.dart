import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hmail_settings_general_clone/extra/dropdown_options.dart';
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
            LanguageRowOne(),
          ],
        ),
      ),
    );
  }
}

class LanguageRowOne extends StatefulWidget {
  const LanguageRowOne({super.key});

  @override
  State<LanguageRowOne> createState() => _LanguageRowOneState();
}

class _LanguageRowOneState extends State<LanguageRowOne> {
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
              "Gmail Display Language",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: DropdownButtonFormField(
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
                    child: Text(
                      e['value'].toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
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
