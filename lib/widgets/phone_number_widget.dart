import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hmail_settings_general_clone/extra/common_data.dart';
import 'package:hmail_settings_general_clone/extra/common_functions.dart';

class PhoneNumberWidget extends StatefulWidget {
  const PhoneNumberWidget({super.key});

  @override
  State<PhoneNumberWidget> createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
  String _selectedCountryCode = "+91";
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            child: Text(
              "Default country code:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
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
                value: _selectedCountryCode,
                items: countryCodeOptions.map((Map<String, String> e) {
                  return DropdownMenuItem(
                    value: e['dial_code'],
                    child: Text(
                      e['name'].toString().trim(),
                      softWrap: true,
                      maxLines: 3,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (kDebugMode) {
                    log("message $value");
                    log(kIsWeb.toString());
                  }
                  setState(() {
                    _selectedCountryCode =
                        value.toString(); // Update the selectedLanguage when the user selects a different option
                  });

                  if (kIsWeb) {
                    saveToLocalStorage(
                      "countryCode",
                      value.toString(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
