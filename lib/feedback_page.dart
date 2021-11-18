import 'package:face_nod_vision/requests.dart';
import 'package:flutter/material.dart';

// @immutable
class FirstPage extends StatelessWidget {
  var rcvjson, port, radVal;
  // Map<String, dynamic> initialJson = {
  //   'Sum': 0,
  //   'ID': {'head': 0, 'face': 'z'}
  // };

  FirstPage({Key? key, required this.rcvjson, this.port, this.radVal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("フィードバック")),
        body: Center(
          child: StreamBuilder(
              stream: getJson(const Duration(seconds: 30), port, radVal),
              // initialData: initialJson,
              builder: (context, stream) {
                if (stream.connectionState == ConnectionState.done) {
                  return const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20,
                  );
                }
                if (stream.hasData) {
                  return LikeCounter();
                  const Text('aaaa');
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ));
    // child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //   Text(rcvjson['ID']['192.168.2.111']['face']),
    // ])));
  }
}

class LikeCounter extends StatelessWidget {
  static List<Color> colors = [
    Colors.green,
    Colors.purpleAccent,
    Colors.deepPurple,
    Colors.blueAccent,
    Colors.deepOrangeAccent
  ];
  final int num = 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: colors[num % colors.length],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.favorite, color: Colors.white),
          Text(
            " $num Likes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
