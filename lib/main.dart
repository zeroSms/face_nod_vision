import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// StatefulWidget: 状態が変化するWidget
class MyHomePage extends StatefulWidget {
  // @required 必須なパラメータに付与．不指定の場合に警告を出してくれるため，引数の渡し忘れに気づける．
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // このウィジェットは，アプリケーションのホーム・ページです．ステートフルとは、見た目に影響を与えるフィールドを含むステート・オブジェクト（以下に定義）を持つことを意味します。このクラスは、ステートの設定です。このクラスは、親(ここではAppウィジェット)から提供され、Stateのbuildメソッドで使用される値(ここではタイトル)を保持します。Widgetサブクラスのフィールドは、常に "final "と表示されます。

  final String title;

  // StatefulWidget(imutable) 自体は build() メソッドを持たず、代わりに createState() で生成した State オブジェクトが子孫となる Widget を生成。その State オブジェクトは可変（mutable) で任意のデータを保持できるため、ユーザー操作などに応じてデータを変化させつつ State.setState で能動的にリビルドを発生させられるのが StatefulWidget
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   // setState（状態を保持するメソッド）によって再度画面が描画
  //   setState(() {
  //     _counter++;
  //   });
  // }

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
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.

          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.

          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: style,
              onPressed: () {},
              child: const Text('Connection'),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Placeholder 仮置きの表示画面（バッテン）．作業途中であることが明確化
// リファクター スニペットのようなもの
