import 'package:pod_player/pod_player.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:url_launcher/url_launcher.dart';

const String key = 'AIzaSyB_fKvogfXZ1aVVDYJVP602doLJ9lNis9I';
YoutubeAPI ytApi = YoutubeAPI(key, maxResults: 2, type: "video");


playsong(String query)
async{
  List<YouTubeVideo> videoResult = await ytApi.search(query);
  launchUrl(Uri.parse(videoResult[0].url));
}