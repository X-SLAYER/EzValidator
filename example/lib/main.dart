import 'package:ez_validator/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'exemple',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'EzValidator Exemple'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EzSchema mySchema = EzSchema.shape({
    "email": EzValidator().email().required().build(),
    "password": EzValidator().required().minLength(6).build(),
    "options": EzValidator().notOneOf(['A', 'B']).build(),
    "age": EzValidator()
        .required()
        .defaultTest(
            'Test not valid please recheck', (v) => int.parse(v as String) > 18)
        .build()
  }, identicalKeys: true);

  validate() {
    try {
      Map<String, String> errors = mySchema.validateSync({
        "email": 'iheb@pixelium.tn',
        "password": '787898989898',
        "options": 'D',
        "age": "29"
      });
      // ignore: avoid_print
      print(errors);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title as String),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () => validate(),
              tooltip: 'Validate',
              child: const Icon(Icons.vertical_distribute_sharp),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
