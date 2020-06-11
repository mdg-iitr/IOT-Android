import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:validators/validators.dart' as validator;
import 'package:iotapp/activity.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/' : (context)=>MyHomePage(),
      '/activity': (context)=>Activity(),
    },
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String ip_address;
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("IOT App"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: ScreenUtil.screenWidth,
                  height: ScreenUtil().setHeight(200),
                  child: InputForm(
                    hintText: 'IP Address of Arduino',
                    validator: (String value) {
                      if (!validator.isURL(value)) {
                        return 'Invalid IP Address';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (String value) {
                      ip_address = value;
                    },
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Navigator.pushNamed(
                        context,
                        '/activity',
                        arguments: ip_address,
                      );
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}

class InputForm extends StatelessWidget{
  final String hintText;
  final Function validator;
  final Function onSaved;

  InputForm({
    this.hintText,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          filled: true,
          border: InputBorder.none,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}