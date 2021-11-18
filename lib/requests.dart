import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

//　HTTP通信処理関数
Future<Map<String, dynamic>> _handleHttp(port, radVal) async {
  Map<String, dynamic> rcvjson = {};

  // urlの取得
  var url = Uri.parse('http://192.168.2.111:$port');
  Map<String, String> headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> sendMsg = {
    "presenter": true,
    "setting": radVal.toString(),
    "finish": false
  };

  // パラメータの送信
  final response =
      await http.post(url, body: json.encode(sendMsg), headers: headers);

  // 視聴者の集約データを受信
  """
      rcv_msg = {
        Sum: ,
        ID: {Address: {head: 0-2},
                      {face: a-z}
            },
      }
    """;
  if (response.statusCode == 200) {
    rcvjson = jsonDecode(response.body) as Map<String, dynamic>;
    print(rcvjson);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  return rcvjson;
}

Stream<Map<String, dynamic>> getJson(
    Duration refreshTime, port, radVal) async* {
  while (true) {
    await Future.delayed(refreshTime);
    yield await _handleHttp(port, radVal);
  }
}
