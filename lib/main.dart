import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                }
                return null;
              },
            ),
            // 空白スペースを挿入
            const SizedBox(height: 30),

            // 空白スペースを挿入
            const SizedBox(height: 30),
            // Connectionボタンの実装
            ElevatedButton(
              style: style,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')));
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
