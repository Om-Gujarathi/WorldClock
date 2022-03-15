import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  String? time;
  String? flag;
  String? url;
  bool isDayTime = false;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // Response response =
      //     await get(Uri.http('jsonplaceholder.typicode.com', '/todos/1'));
      // Map data = jsonDecode(response.body);
      // print(data);
      // print(data['title']);

      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map? data = jsonDecode(response.body);

      //geting properties from data
      String datetime = data!['datetime'];
      String offset = data['utc_offset'];
      String offset1 = offset.substring(1, 3);
      String offset2 = offset.substring(4, 6);

      // print(datetime);
      // print(offset);
      //Create DateTime Object
      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));

      //set the Time Property
      isDayTime = (now.hour > 6) && (now.hour) < 20 ? true : false ;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Something went Wrong --> $e');
      time = 'Could not get Time data';
    }
  }
}
