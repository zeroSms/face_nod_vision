import 'package:face_nod_vision/requests.dart';
import 'package:flutter/material.dart';

@immutable
class FirstPage extends StatelessWidget {
  var rcvjson, port, radVal;
  // final Map<String, dynamic> initialdata = {
  //   'Sum': 0,
  //   'ID': {
  //     '0': {'head': 0, 'face': 'a'}
  //   }
  // };

  FirstPage({Key? key, required this.rcvjson, this.port, this.radVal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("フィードバック")),
        body: Center(
          child: StreamBuilder(
              stream: getJson(const Duration(seconds: 7), port, radVal),
              // initialData: initialdata,
              builder: (context, stream) {
                if (stream.connectionState == ConnectionState.done) {
                  return const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20,
                  );
                }
                if (stream.hasData) {
                  return FeedbackAction(data: stream.data);
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

enum Expression { neutral, smile, surprise, angry }

const imgList = [
  [
    'images/NoEmotion.png',
    'images/joy.png',
    'images/surprise.png',
    'images/sad.png',
    'images/angry.png',
    'images/fear.png',
    'images/disgust.png',
  ],
  [
    'images/gif/NoEmotion_nod.gif',
    'images/gif/joy_nod.gif',
    'images/gif/surprise_nod.gif',
    'images/gif/sad_nod.gif',
    'images/gif/angry_nod.gif',
    'images/gif/fear_nod.gif',
    'images/gif/disgust_nod.gif',
  ],
  [
    'images/gif/NoEmotion_shake.gif',
    'images/gif/joy_shake.gif',
    'images/gif/surprise_shake.gif',
    'images/gif/sad_shake.gif',
    'images/gif/angry_shake.gif',
    'images/gif/fear_shake.gif',
    'images/gif/disgust_shake.gif',
  ]
];

class FeedbackAction extends StatelessWidget {
  dynamic data;
  FeedbackAction({Key? key, required this.data}) : super(key: key);

  // IDをリストで返す
  List _returnID(Map<String, dynamic> map) {
    final idList = <String>[];
    map.forEach((key, value) {
      idList.add(key);
    });
    return idList;
  }

  int _returnFace(String face) {
    int num;
    if (face == 'a' || face == 'z') {
      num = 0;
    } else if (face == 'b') {
      num = 1;
    } else if (face == 'c') {
      num = 2;
    } else if (face == 'd') {
      num = 3;
    } else if (face == 'e') {
      num = 4;
    } else if (face == 'f') {
      num = 5;
    } else if (face == 'g') {
      num = 6;
    } else {
      num = 0;
    }
    return num;
  }

  @override
  Widget build(BuildContext context) {
    int sum = data['Sum'];
    List idList = _returnID(data['ID']);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < sum; i++)
          Image(
              width: 400 / sum,
              image: AssetImage(imgList[data['ID'][idList[i]]['head']]
                  [_returnFace(data['ID'][idList[i]]['face'])]),
              fit: BoxFit.cover),
      ],
    );
  }
}
