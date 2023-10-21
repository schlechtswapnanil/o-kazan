import 'dart:convert';

import 'dart:io';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:contacts_service/contacts_service.dart';
import "package:alan_voice/alan_voice.dart";

import 'location.dart';
import 'package:http/http.dart' as http;

Item callable = [] as Item;
String fi = '';

List<dynamic> places = [];
Map<String, dynamic>? placeDetails;


void contactCall(String to_be_called) async {
  List<Contact> con = await ContactsService.getContacts(query: to_be_called);
  callable = con[0].phones!.first;
  fi = callable.value!;
  dialler(fi);
}

void callNearest(String namae) async {
    final apiKey = 'AIzaSyDXwA7VypcKXuVi7OoWqnhcgIxvSTz4X7o';
    final baseUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';
    String lat=getLat().toString();
    String long=getLong().toString();
    final location = lat+long ; // Example location (San Francisco)
    final url = '$baseUrl&location=$location&types=$namae&rankby=distance&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final jsonData = json.decode(response.body);
    places=jsonData['results'];
    final id= places[0]['place_id'];
    final url2 ='https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&key=$apiKey';

    final response2 = await http.get(Uri.parse(url2));
    final data = json.decode(response2.body);
    placeDetails=data['results'];
    String phoneNumber=placeDetails!['formatted_phone_number'];
    AlanVoice.playText('Calling ${placeDetails!['name']} now');
    sleep(Duration(seconds: 4));
    dialler(phoneNumber);


}

void dialler(String dial) {
  FlutterPhoneDirectCaller.callNumber(dial);
}
