import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {    
  Map? data = {};

  @override
  Widget build(BuildContext context) {

    data = data!.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;

    // Set Background
    String bgImage = data!['isDayTime'] ? 'dayTime.jpg' : 'nightTime.jpg';
    Color? bgColor = data!['isDayTime'] ? Colors.blue : Colors.indigo[700]; 

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                    onPressed: (() async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'location': result['location'],
                          'flag': result['flag'],
                          'time': result['time'],
                          'isDayTime' : result['isDayTime'],
                        };
                      });
                    }),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.yellowAccent),
                    ),
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Edit Location',
                      style: TextStyle(
                        color: Colors.black
                      ),
                    )
                    ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data!['location'],
                      style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  data!['time'],
                  style: TextStyle(
                    fontSize: 66,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
