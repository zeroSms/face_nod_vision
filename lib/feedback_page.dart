import 'package:face_nod_vision/requests.dart';
import 'package:flutter/material.dart';

@immutable
class FirstPage extends StatelessWidget {
  var rcvjson, port, radVal;
  final Map<String, dynamic> initialdata = {'Sum': 0, 'ID': {}};

  FirstPage({Key? key, required this.rcvjson, this.port, this.radVal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("フィードバック")),
        body: Center(
          child: StreamBuilder(
              stream: getJson(const Duration(seconds: 3), port, radVal),
              initialData: initialdata,
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
  'images/neutral.PNG',
  'images/smile.PNG',
  'images/surprise.PNG',
  'images/angry.PNG',
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
    } else {
      num = 3;
    }
    return num;
  }

  @override
  Widget build(BuildContext context) {
    int sum = data['Sum'];
    List idList = _returnID(data['ID']);
    String img = imgList[_returnFace(data['ID'][idList[0]]['face'])];
    print(img);
    return Image(image: AssetImage(img), fit: BoxFit.cover);
  }
}
