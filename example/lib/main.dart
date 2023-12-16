import 'package:ez_validator/ez_validator.dart';
import 'package:ez_validator_example/error_widget.dart';
import 'package:ez_validator_example/fr.dart';
// import 'package:ez_validator_example/french_locale.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  /// set this in the main to set your custom locale
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
  Map<String, dynamic> form = {
    "number": '5',
    "pos": '-5',
    "date": "00-00-00", //DateTime.now().toIso8601String()
  };
  Map<String?, String?> errors = {};

  EzSchema mySchema = EzSchema.shape(
    {
      "email": EzValidator<String>(label: "l'email").required().email(),
      "password":
          EzValidator<String>(label: 'le mot de passe').required().minLength(8),
      "age": EzValidator<num>(label: 'l\'age').required().number(),
    },
  );

  validate() {
    /// wrap your validation method with try..catch when you add the
    /// identicalKeys clause to your schema
    try {
      setState(() {
        errors = mySchema.validateSync(form);
      });
      // ignore: avoid_print
      errors.forEach((key, value) {
        // ignore: avoid_print
        print('$key ===> $value');
      });
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
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (value) => _onChange('email', value),
                        decoration: _getInputDecoration(Icons.email, "Email"),
                      ),
                      ErrorWIdget(name: errors['email']),
                      const SizedBox(height: 10.0),
                      TextField(
                        onChanged: (value) => _onChange('password', value),
                        decoration:
                            _getInputDecoration(Icons.password, "Password"),
                      ),
                      ErrorWIdget(name: errors['password']),
                      const SizedBox(height: 10.0),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => _onChange('age', value),
                        decoration: _getInputDecoration(
                            Icons.supervised_user_circle_outlined, "Age"),
                      ),
                      ErrorWIdget(name: errors['age']),
                      const SizedBox(height: 10.0),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => _onChange('birth_year', value),
                        decoration: _getInputDecoration(
                            Icons.date_range_outlined, "Birth Year"),
                      ),
                      ErrorWIdget(name: errors['birth_year']),
                      const SizedBox(height: 10.0),
                      MaterialButton(
                        onPressed: validate,
                        color: Colors.white,
                        highlightColor: Colors.red,
                        child: const Text("Submit"),
                      ),
                      MaterialButton(
                        onPressed: () {
                          EzValidator.setLocale(const FrLocale());
                        },
                        color: Colors.white,
                        highlightColor: Colors.red,
                        child: const Text("Fr Locale"),
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
