import 'package:flutter/material.dart';

// 自作ライブラリ
import 'feedback_page.dart';

enum Feedback { all, positive }

void main() {
  runApp(const MyApp());
}

// StatelessWidget: 状態が変化しないWidget
// 「stl」と入力することで生成可能
// ここはビルドされると、return文以下が実行されるだけで、それ以降は外部からの（ユーザーのインタラクション等）影響を受けない。つまり一度画面が描画されると、あとから再描画されることはなく状態も変わらない。
//そして、状態が変わる部分を MyHomePage に切り分けている。
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo Home Page'),
        ),
        body: const MyHomePage(),
      ),
    );
  }
}

// StatefulWidget: 状態が変化するWidget
class MyHomePage extends StatefulWidget {
  // @required 必須なパラメータに付与．不指定の場合に警告を出してくれるため，引数の渡し忘れに気づける．
  const MyHomePage({Key? key}) : super(key: key);

  // StatefulWidget(imutable) 自体は build() メソッドを持たず、代わりに createState() で生成した State オブジェクトが子孫となる Widget を生成。その State オブジェクトは可変（mutable) で任意のデータを保持できるため、ユーザー操作などに応じてデータを変化させつつ State.setState で能動的にリビルドを発生させられるのが StatefulWidget
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String _port = '';
  Map<String, dynamic> _rcvjson = {};

  // ラジオボタンのonChangedハンドラ
  Feedback _radVal = Feedback.all; // 初期値

  void _onChanged(value) {
    setState(() {
      _radVal = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              // 文章ガイドを薄く表示
              decoration: const InputDecoration(hintText: 'port番号を入力してください'),
              // Boxに入力されているかを判定．されていなければ以下の文章を返す．
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else {
                  setState(() {
                    _port = value;
                  });
                }
                return null;
              },
            ),
            // 空白スペースを挿入
            const SizedBox(height: 30),
            const Text(
              'フィードバック内容の選択',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile(
                title: const Text('すべての反応'),
                value: Feedback.all,
                groupValue: _radVal,
                onChanged: (value) => _onChanged(value)),
            RadioListTile(
                title: const Text('ポジティブな反応のみ'),
                value: Feedback.positive,
                groupValue: _radVal,
                onChanged: (value) => _onChanged(value)),

            // 空白スペースを挿入
            const SizedBox(height: 30),
            // Connectionボタンの実装
            ElevatedButton(
              style: style,
              onPressed: () {
                // 入力スペースが空であるか否かを判定．空でなければ通信処理．
                if (_formKey.currentState!.validate()) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Processing Data')));

                  // 画面遷移
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FirstPage(
                                rcvjson: _rcvjson,
                                port: _port,
                                radVal: _radVal,
                              )));
                }
              },
              child: const Text('Connection'),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder 仮置きの表示画面（バッテン）．作業途中であることが明確化
// リファクター スニペットのようなもの
