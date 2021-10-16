import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Week4: Changing font size',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var txtController = TextEditingController();

  //размер шрифта текста для изменения
  double fontSize = 10;

  //введённый текст в TextField
  String strSize = "";

  @override
  void initState() {
    super.initState();
    txtController = TextEditingController(text: "10");
  }

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Week4: Changing font size'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(70),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink(
                  decoration: const ShapeDecoration(
                      shape: CircleBorder(), color: Colors.grey),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Increase by 1',
                    onPressed: () {
                      setState(() {
                        strSize = txtController.text;
                        if (isValidSize(strSize)) {
                          fontSize = double.parse(strSize) + 1;
                          txtController.text = fontSize.toString();
                        } else {
                          dialogWrongSize();
                        }
                      });
                    },
                  ),
                ),
                Spacer(),
                Container(
                  child: TextField(
                    controller: txtController,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    onSubmitted: (strSize) {
                      setState(() {
                        if (isValidSize(strSize)) {
                          fontSize = double.parse(strSize);
                        } else {
                          dialogWrongSize();
                        }
                      });
                    },
                  ),
                  color: Colors.grey,
                  height: 40,
                  width: 150,
                ),
                Spacer(),
                Ink(
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(), color: Colors.grey),
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      tooltip: 'Decrease by 1',
                      onPressed: () {
                        setState(() {
                          strSize = txtController.text;
                          if (isValidSize(strSize)) {
                            double textFieldSize = double.parse(strSize);
                            //уменьшать шрифт только если
                            //не получится отрицательное число после вычитания 1
                            //иначе ничего не делать
                            if (textFieldSize >= 1) {
                              fontSize = double.parse(strSize) - 1;
                              txtController.text = fontSize.toString();
                            }
                          } else {
                            dialogWrongSize();
                          }
                        });
                      },
                    ))
              ],
            ),
            Container(
              height: 20,
            ),
            Expanded(
                //для прокрутки текста
                child: SingleChildScrollView(
                    //для прокрутки текста
                    child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              style: TextStyle(
                fontSize: fontSize,
              ),
              //overflow: TextOverflow.visible,
            )))
          ],
        ),
      ),
    );
  }

  bool isValidSize(String strSize) {
    double? dSize = double.tryParse(strSize);
    if (dSize == null) return false;
    if (dSize >= 0) return true;
    return false;
  }

  void dialogWrongSize() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("In the TextField there is no correct font size"),
          );
        });
  }
}
