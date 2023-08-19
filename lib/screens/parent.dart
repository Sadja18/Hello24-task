// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hmail_settings_general_clone/widgets/language_widget.dart';
import 'package:hmail_settings_general_clone/widgets/phone_number_widget.dart';
import 'package:hmail_settings_general_clone/widgets/signature_widget.dart';
import 'package:hmail_settings_general_clone/widgets/star_widget.dart';
import 'package:hmail_settings_general_clone/widgets/text_style_widget.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  Color colorOfButtonOnHover = Colors.blue.shade800;
  Color colorOfButtonNormal = Colors.black;
  Color colorOfButton = Colors.black;

  bool tryCode = true;

  List<Widget> generateTabs() {
    List<Widget> widgets = [];

    List<String> names = [
      "General",
      "Labels",
      "Inbox",
      "Accounts and Import",
      "Filters and Blocked Addresses",
      "Forwarding and POP/IMAP",
      "Add-ons",
      "Chat and Meet",
      "Advanced",
      "Offline",
      "Themes"
    ];

    for (var name in names) {
      widgets.add(
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: SizedBox(
              child: Text(
                name,
                style: TextStyle(
                  color: names.indexOf(name) == 0 ? colorOfButtonOnHover : colorOfButtonNormal,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  void initState() {
    setState(() {
      colorOfButton = colorOfButtonNormal;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xf6f8fcff),
          backgroundBlendMode: BlendMode.color,
        ),
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.only(
          top: 18.0,
          left: 18.0,
        ),
        height: MediaQuery.of(context).size.height * 0.70,
        width: MediaQuery.of(context).size.width * 0.50,
        child: tryCode
            ? MyApp1()
            // DragAndDropLists(
            //     listPadding: const EdgeInsets.all(8.0),
            //     children: lists,
            //     onItemReorder: onReorderListItem,
            //     onListReorder: onReorderList,
            //     axis: Axis.vertical,
            //     listWidth: MediaQuery.of(context).size.width * 0.40,
            //     contentsWhenEmpty: SizedBox(
            //       height: 0,
            //       width: 0,
            //     ),
            //     constrainDraggingAxis: false,
            //     horizontalAlignment: MainAxisAlignment.spaceBetween,
            //     verticalAlignment: CrossAxisAlignment.start,
            //     itemDragHandle: dragHandle(),
            //   )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      // decoration: BoxDecoration(color: Colors.red),
                      height: MediaQuery.of(context).size.height * 0.03,
                      margin: const EdgeInsets.only(top: 1),
                      child: const Text(
                        'Settings',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                      ),
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 0.90,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: generateTabs(),
                        ),
                      ),
                    ),
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      columnWidths: const {
                        0: FractionColumnWidth(0.20),
                        1: FractionColumnWidth(0.80),
                      },
                      children: [
                        const TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 8.0,
                                  left: 18.0,
                                ),
                                child: SizedBox(
                                  child: Text(
                                    "Language:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            LanguageWidget(),
                          ],
                        ),
                        const TableRow(children: [
                          TableCell(
                            child: Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                          ),
                          TableCell(
                            child: Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        const TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 8.0,
                                  left: 18.0,
                                ),
                                child: SizedBox(
                                  child: Text(
                                    "Phone numbers:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            PhoneNumberWidget(),
                          ],
                        ),
                        const TableRow(
                          children: [
                            TableCell(
                              child: Divider(
                                thickness: 1.0,
                                color: Colors.black,
                              ),
                            ),
                            TableCell(
                              child: Divider(
                                thickness: 1.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      columnWidths: const {
                        0: FractionColumnWidth(0.20),
                        1: FractionColumnWidth(0.22),
                      },
                      children: const [
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 8.0,
                                  left: 18.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        "Default text style:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: Text(
                                        "(Use the 'Remove formatting' button on the toolbar to reset the default text style)",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                        maxLines: 3,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DefaultTextStyleWidget(),
                          ],
                        ),
                      ],
                    ),
                    Table(
                      columnWidths: {0: FractionColumnWidth(1)},
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                          ),
                        ])
                      ],
                    ),
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      columnWidths: const {
                        0: FractionColumnWidth(0.20),
                        1: FractionColumnWidth(0.60),
                      },
                      children: [
                        TableRow(
                          children: [
                            const TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 8.0,
                                  left: 18.0,
                                ),
                                child: SizedBox(
                                  child: Text(
                                    "Stars:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            StarsWrapper(),
                          ],
                        ),
                      ],
                    ),
                    Table(
                      columnWidths: {0: FractionColumnWidth(1)},
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                          ),
                        ])
                      ],
                    ),
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      columnWidths: const {
                        0: FractionColumnWidth(0.20),
                        1: FractionColumnWidth(0.40),
                      },
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  left: 18.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      child: Text(
                                        "Signature:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      child: Text(
                                        "(appended at the end of all outgoing messages)",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: InkWell(
                                        onTap: () {},
                                        child: const Text(
                                          "Learn more",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SignatureWrapperWidget(),
                          ],
                        ),
                      ],
                    ),
                    Table(
                      columnWidths: {0: FractionColumnWidth(1)},
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                          ),
                        ])
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<int> inUseWidgets = [1];
  List<int> notInUseWidgets = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            // In use section
            Row(
              children: <Widget>[
                    SizedBox(
                      child: const Text("In use: "),
                    ),
                  ] +
                  inUseWidgets
                      .map((index) => Draggable(
                            data: index,
                            child: Icon(Icons.ac_unit),
                            onDragEnd: (details) {
                              // Rebuild the not in use section and add the widget at the
                              // beginning of the list.
                              setState(() {
                                notInUseWidgets.insert(0, index);
                                inUseWidgets.remove(index);
                              });
                            },
                            feedback: const Text(""),
                          ))
                      .toList(),
            ),
            // Not in use section
            Row(
              children: <Widget>[
                    SizedBox(
                      child: const Text("Not in use: "),
                    ),
                  ] +
                  notInUseWidgets
                      .map((index) => Draggable(
                            data: index,
                            child: Icon(Icons.ac_unit),
                            onDragEnd: (details) {
                              // Rebuild the in use section and add the widget at the
                              // position defined by its own position value.
                              setState(() {
                                int position = notInUseWidgets.indexOf(index);
                                inUseWidgets.insert(position, index);
                                notInUseWidgets.remove(index);
                              });
                            },
                            feedback: const Text(""),
                          ))
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp1 extends StatefulWidget {
  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  Map<String, Widget> widgets = {
    "ac_unit": Icon(Icons.ac_unit),
    "alarm": Icon(Icons.alarm),
    "car": Icon(Icons.drive_eta),
    "face": Icon(Icons.face),
    "flower": Icon(Icons.mobile_friendly),
    "food": Icon(Icons.local_pizza),
    "home": Icon(Icons.home),
    "lightbulb": Icon(Icons.lightbulb),
    "map": Icon(Icons.map),
    "phone": Icon(Icons.phone),
    "star": Icon(Icons.star),
  };

  List<String> inUseWidgets = ["ac_unit"];
  List<String> notInUseWidgets = [
    "alarm",
    "car",
    "face",
    "flower",
    "food",
    "home",
    "lightbulb",
    "map",
    "phone",
    "star"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
// In use section
            Row(
              children: inUseWidgets
                  .map(
                    (widgetName) => Draggable(
                      data: widgetName,
                      child: widgets[widgetName]!,
                      onDragEnd: (details) {
// Rebuild the not in use section and add the widget at the
// beginning of the list.
                        setState(() {
                          notInUseWidgets.insert(0, widgetName);
                          inUseWidgets.remove(widgetName);
                        });
                      },
                      feedback: const Text(
                        "",
                      ),
                    ),
                  )
                  .toList(),
            ),
// Not in use section
            Row(
              children: notInUseWidgets
                  .map(
                    (widgetName) => Draggable(
                      data: widgetName,
                      child: widgets[widgetName]!,
                      onDragEnd: (details) {
// Rebuild the in use section and add the widget at the
// position defined by its own position value.
                        setState(() {
                          int position = notInUseWidgets.indexOf(widgetName);
                          inUseWidgets.insert(position, widgetName);
                          notInUseWidgets.remove(widgetName);
                        });
                      },
                      feedback: const Text(
                        "",
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
