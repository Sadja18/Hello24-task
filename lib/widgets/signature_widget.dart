// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hmail_settings_general_clone/extra/common_functions.dart';

class SignatureWrapperWidget extends StatefulWidget {
  const SignatureWrapperWidget({super.key});

  @override
  State<SignatureWrapperWidget> createState() => _SignatureWrapperWidgetState();
}

class _SignatureWrapperWidgetState extends State<SignatureWrapperWidget> {
  bool signatureExists = false;

  TextEditingController signatureNameController = TextEditingController();

  List<dynamic> signatureNames = [];

  void processSignatureNamesFromStorage() async {
    var value = await getKeyFromLocalStorage("signatureNames");

    if (value is String) {
      var jsonParsed = jsonDecode(value);

      if (jsonParsed != null && jsonParsed is List) {
        if (kDebugMode) {
          log("${jsonParsed.runtimeType}");
          // log("${jsonParsed is List}");
        }
        setState(() {
          signatureNames = jsonParsed;
          signatureExists = true;
        });
      } else {
        setState(() {
          signatureExists = false;
        });
      }
    }
  }

  void updateSignatureNameInStorage(String signatureValue) async {
    var tmp = {"name": signatureValue};

    signatureNames.add(tmp);

    var stringifiedSignatureNames = jsonEncode(signatureNames);

    await saveToLocalStorage("signatureNames", stringifiedSignatureNames);
  }

  void checkIfSignatureExists() async {
    if (kDebugMode) {
      log("checkign if signature exists");
    }
    processSignatureNamesFromStorage();
  }

  void addSignatureDialog(BuildContext ctx) async {
    return showDialog(
        context: ctx,
        builder: (BuildContext c) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            title: const Text("Name new signature"),
            content: SizedBox(
              width: MediaQuery.of(ctx).size.width * 0.30,
              height: MediaQuery.of(ctx).size.height * 0.04,
              child: TextFormField(
                controller: signatureNameController,
                validator: (value) {
                  if (signatureNameController.text.length <= 1) {
                    return "Please provide a discernable name for signature";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Signature name",
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 150, 148, 148),
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(ctx).size.width * 0.30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: MediaQuery.of(ctx).size.width * 0.05,
                        height: MediaQuery.of(ctx).size.height * 0.05,
                        child: InkWell(
                          onTap: () {
                            if (kDebugMode) {
                              log("close dialog");
                            }
                            Navigator.pop(c);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: MediaQuery.of(ctx).size.width * 0.05,
                        height: MediaQuery.of(ctx).size.height * 0.05,
                        child: InkWell(
                          onTap: () {
                            if (kDebugMode) {
                              log("ontap create ${signatureNameController.text}");
                            }
                            if (signatureNameController.text.length <= 1) {
                              var message = "Please provide a discernable name for signature";
                              ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(message)));
                            } else {
                              updateSignatureNameInStorage(signatureNameController.text);
                              Navigator.pop(c);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: const Text(
                              "Create",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    checkIfSignatureExists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return signatureExists
        ? SignatureExistsWidget(signatureNames: signatureNames)
        : NoSignatureWidget(addSignatureDialog: addSignatureDialog);
  }
}

class NoSignatureWidget extends StatefulWidget {
  final Function(BuildContext) addSignatureDialog;
  const NoSignatureWidget({super.key, required this.addSignatureDialog});

  @override
  State<NoSignatureWidget> createState() => _NoSignatureWidgetState();
}

class _NoSignatureWidgetState extends State<NoSignatureWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width * 0.20,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.20,
              child: const Text(
                "No signatures",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.08,
              height: MediaQuery.of(context).size.height * 0.05,
              child: InkWell(
                onTap: () {
                  widget.addSignatureDialog(context);
                },
                child: Card(
                  elevation: 4.0,
                  shape: const RoundedRectangleBorder(
                    //<-- SEE HERE
                    side: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.zero,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                        Text(
                          "Create new",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignatureExistsWidget extends StatefulWidget {
  final List signatureNames;
  const SignatureExistsWidget({super.key, required this.signatureNames});

  @override
  State<SignatureExistsWidget> createState() => _SignatureExistsWidgetState();
}

class _SignatureExistsWidgetState extends State<SignatureExistsWidget> {
  late String selectedSignatureForNewEmail = widget.signatureNames[0]['name'];

  bool checkBoxVal = true;

  List signatureNames = [];

  late String selectedSignatureForReply = widget.signatureNames[0]['name'];

  @override
  void initState() {
    if (kDebugMode) {
      log("$selectedSignatureForNewEmail $selectedSignatureForReply");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        // height: MediaQuery.of(context).size.height*0.40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // height: MediaQuery.of(context).size.height * 0.40,
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const <int, TableColumnWidth>{
                  0: FractionColumnWidth(0.30),
                  1: FractionColumnWidth(0.55),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.30,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.signatureNames.map((e) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue.shade100,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        e["name"].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: IconButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit_sharp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: IconButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.delete_outlined,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.25,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    left: BorderSide.none,
                                    bottom: BorderSide.none,
                                    right: BorderSide.none,
                                  ),
                                ),
                                height: MediaQuery.of(context).size.height * 0.04,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.format_size_sharp,
                                      ),
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.format_bold_sharp,
                                      ),
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.format_italic_sharp,
                                      ),
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.format_underline_sharp,
                                      ),
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.format_color_text_sharp,
                                      ),
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.link_sharp,
                                      ),
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.image_sharp,
                                      ),
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.format_align_left_sharp,
                                      ),
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.format_list_numbered_sharp,
                                      ),
                                    ),
                                    // IconButton(onPressed: (){}, icon: Icons)
                                    PopupMenuButton(
                                      padding: const EdgeInsets.all(0),
                                      itemBuilder: (BuildContext ctx) {
                                        return [
                                          PopupMenuItem(
                                            padding: const EdgeInsets.all(0),
                                            onTap: () {},
                                            child: Icon(
                                              Icons.format_clear_sharp,
                                            ),
                                          ),
                                          PopupMenuItem(
                                            padding: const EdgeInsets.all(0),
                                            onTap: () {},
                                            child: Icon(
                                              Icons.format_quote_sharp,
                                            ),
                                          ),
                                          PopupMenuItem(
                                            padding: const EdgeInsets.all(0),
                                            onTap: () {},
                                            child: Icon(
                                              Icons.format_indent_increase_sharp,
                                            ),
                                          ),
                                          PopupMenuItem(
                                            padding: const EdgeInsets.all(0),
                                            onTap: () {},
                                            child: Icon(
                                              Icons.format_indent_decrease_sharp,
                                            ),
                                          ),
                                          PopupMenuItem(
                                            padding: const EdgeInsets.all(0),
                                            onTap: () {},
                                            child: Icon(
                                              Icons.format_list_numbered_sharp,
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 14.0,
                          ),
                          child: SizedBox(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Icon(
                                      Icons.add_sharp,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    child: const Text(
                                      "Create new",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: const SizedBox(
                          width: 0,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                child: Text(
                  "Signature defaults",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const <int, TableColumnWidth>{
                0: FractionColumnWidth(0.40),
                1: FractionColumnWidth(0.40),
              },
              children: [
                const TableRow(
                  children: [
                    TableCell(
                      child: SizedBox(
                        child: Text(
                          "FOR NEW EMAILS USE",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: SizedBox(
                        child: Text(
                          "ON REPLY/FORWARD USE",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: DropdownButtonFormField(
                            alignment: Alignment.centerLeft,
                            isDense: true,
                            isExpanded: true,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            value: selectedSignatureForNewEmail,
                            items: widget.signatureNames
                                .map(
                                  (element) => DropdownMenuItem(
                                    value: element['name'].toString(),
                                    child: Text(
                                      element['name'].toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              if (kDebugMode) {
                                log("For new email signature: $value");
                              }
                              setState(() {
                                selectedSignatureForNewEmail = value.toString();
                              });
                              saveToLocalStorage('selectedSignatureForNewEmail', selectedSignatureForNewEmail);
                            },
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: DropdownButtonFormField(
                            alignment: Alignment.centerLeft,
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            value: selectedSignatureForReply,
                            items: widget.signatureNames
                                .map(
                                  (element) => DropdownMenuItem(
                                    value: element['name'].toString(),
                                    child: Text(
                                      element['name'].toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              if (kDebugMode) {
                                log("For new email signature: $value");
                              }
                              setState(() {
                                selectedSignatureForReply = value.toString();
                              });
                              saveToLocalStorage("selectedSignatureForReply", value.toString());
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FractionColumnWidth(0.05),
                1: FractionColumnWidth(0.80),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          child: Checkbox(
                            activeColor: Colors.blue,
                            value: checkBoxVal,
                            onChanged: (value) {
                              if (kDebugMode) {
                                log('checkbox val $value');
                              }
                              setState(() {
                                checkBoxVal = !checkBoxVal;
                              });
                              saveToLocalStorage("insert_sign_before", checkBoxVal.toString());
                            },
                          ),
                        ),
                      ),
                    ),
                    const TableCell(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          child: Text(
                              'Insert signature before quoted text in replies and remove the "--" line that precedes it.'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
