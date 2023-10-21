import 'package:geolocator/geolocator.dart';

Future<String> getLong()
async{
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  String long = position.longitude.toString();
  return long;

}

Future<String> getLat()
async{
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  String lat = position.latitude.toString();
  return lat;

}