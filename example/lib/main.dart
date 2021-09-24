import 'package:ez_validator/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  Map<String, dynamic> form = {'email': '', 'password': '', 'age': ''};
  Map<String, String> errors = {};

  EzSchema mySchema = EzSchema.shape({
    "email": EzValidator().required().email().build(),
    "password": EzValidator()
        .required()
        .minLength(6)
        .matches(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
        .build(),
    "age": EzValidator().required().min(18).build()
  }, identicalKeys: true);

  validate() {
    /// wrap your validation method with try..catch when you add the
    /// identicalKeys clause to your schema
    try {
      Map<String, String> errors = mySchema.validateSync(form);
      // ignore: avoid_print
      print(errors);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Missing fields input",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  InputDecoration _getInputDecoration(IconData icon, String label) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      border: InputBorder.none,
      fillColor: const Color(0xfff3f3f4),
      filled: true,
      hintText: label,
    );
  }

  _onChange(String name, String value) {
    form[name] = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title as String),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                color: Colors.blueGrey.withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        onChanged: (value) => _onChange('email', value),
                        decoration: _getInputDecoration(Icons.email, "Email"),
                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        onChanged: (value) => _onChange('password', value),
                        decoration:
                            _getInputDecoration(Icons.password, "Password"),
                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => _onChange('age', value),
                        decoration: _getInputDecoration(
                            Icons.supervised_user_circle_outlined, "Age"),
                      ),
                      const SizedBox(height: 10.0),
                      MaterialButton(
                        onPressed: validate,
                        color: Colors.white,
                        child: const Text("Sumbit"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
