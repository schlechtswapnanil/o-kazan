// ignore: unused_import
import 'dart:typed_data';
// ignore: unused_import
import 'dart:ui' as ui;
import 'dart:math';
import 'auto_caller_old.dart';
import 'dart:convert';
import 'youtube.dart';
import 'dart:io';
import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// ignore: unused_import
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';

//import 'heart.dart';
import 'package:external_app_launcher/external_app_launcher.dart';


String centext = 'No Info Yet';

int number = 1;
Random random = new Random();

String groceryReply = '';

const Color ap = Colors.black;
const Color bg = Colors.white;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = "O'Kazan"}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    void initState() async {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);

      AlanVoice.activate();
      Permission.contacts.request();
      Permission.locationWhenInUse.request();
      var status = await Permission.contacts.status;
      if (status.isDenied) {
        await Permission.contacts.request();

        // We didn't ask for permission yet or the permission has been denied before but not permanently.
      }
    }

    /// Init Alan Button with project key from Alan Studio - log in to https://studio.alan.app, go to your project > Integrations > Alan SDK Key
    AlanVoice.addButton(
        "729b8ad5b8540e380ef7cd1c577056d92e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);

    /// ... or init Alan Button with project key and additional params
    // var params = jsonEncode({"uuid":"111-222-333-444"});
    // AlanVoice.addButton("8e0b083e795c924d64635bba9c3571f42e956eca572e1d8b807a3e2338fdd0dc/stage", authJson: params);

    /// Set log level - "all", "none"
    AlanVoice.setLogLevel("none");

    /// Add button state handler
    AlanVoice.onButtonState.add((state) {
      debugPrint("got new button state ${state.name}");
    });

    sendGroceryData() {
      var params = jsonEncode({"reply": groceryReply});
      AlanVoice.callProjectApi("script: :groceryList", params);
    }

    void _callProjectApi() {
      AlanVoice.activate();
      // Calling the project API method on button click
      var params = jsonEncode({"user": "John Smith"});
      AlanVoice.callProjectApi("script::greetUser", params);
    }

    _handleCommand(Map<String, dynamic> command) {
      switch (command["command"]) {
        case "normal_call":
          contactCall(command["text"]);
          break;
        case "call_nearest":
          callNearest(command["text"]);
          break;
        case "song":
          playsong(command["text"]);
          break;
        case "bpm":
          AlanVoice.playText(
              "Hold Your Finger on the Camera lens for 10 seconds and then release. Hold Tightly.");
          sleep(Duration(seconds: 2));
          LaunchApp.openApp(
            androidPackageName: 'com.example.herzlich',
          );

          break;
        case 'dial':
          FlutterPhoneDirectCaller.callNumber(command["text"]);
          break;
        
      }
    }

    /// Add command handler
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));

    /// Add event handler
    AlanVoice.onEvent.add((event) {
      debugPrint("got new event ${event.data.toString()}");
    });

    /// Activate Alan Button
    // ignore: unused_element

    /// Deactivate Alan Button
    // ignore: unused_element
    void _deactivate() {
      AlanVoice.deactivate();
    }

    /// Play any text via Alan Button
    // ignore: unused_element
    void _playText() {
      /// Provide text as string param
      AlanVoice.playText("Hello from Okazan");
    }

    /// Execute any command locally (and handle it with onCommand callback)
    // ignore: unused_element
    void _playCommand() {
      /// Provide any params with json
      var command = jsonEncode({"command": "commandName"});
      AlanVoice.playCommand(command);
    }

    /// Call project API from Alan Studio script
    // ignore: unused_element

    /// Set visual state in Alan Studio script
    // ignore: unused_element
    void _setVisualState() {
      /// Provide any params with json
      var visualState = jsonEncode({"visualState": "stateValue"});
      AlanVoice.setVisualState(visualState);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text(widget.title,
              style: TextStyle(
                fontFamily: 'Michroma',
                fontSize: 37.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/image$number.jpg'),
                  //opacity: 0.4,
                  colorFilter:
                      ColorFilter.mode(Colors.black45, BlendMode.darken))),
          child: Center(
              child: Container(
            width: 100,
            height: 100,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(48.0),
              ))),
              onPressed: () => setState(() {
                number = random.nextInt(8) + 1;
              }),
              child: Icon(
                Icons.fingerprint,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 27, 28, 30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.lightBlueAccent,
                      blurRadius: 15,
                      spreadRadius: 15)
                ]),
          )),
        ));
  }
}
