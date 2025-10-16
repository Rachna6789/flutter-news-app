import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
// lib/main.dart


import 'news_article.dart';
import 'news_provider.dart';
import 'api_service.dart';
import 'news_screen_list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NewsProvider()..loadHeadlines(), // Load data immediately
      child: const MyApp(),
    ),
  );
}

// lib/main.dart

// ... existing imports ...

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the NewsProvider to get the theme state
    final newsProvider = Provider.of<NewsProvider>(context);

    return MaterialApp(
      title: 'Flutter News App',
      debugShowCheckedModeBanner: false,

      // Define Light Theme
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          color: Colors.red,
          iconTheme: const IconThemeData(
            color: Colors.white, // Change icons (search, moon/sun) to white
          ),
          // Change title color and font settings here for light mode
          titleTextStyle: TextStyle(
            fontFamily: 'poppins',
            color: Colors.white,       // <<< CHANGE COLOR HERE
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),

      // Define Dark Theme
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          color: Colors.grey[850],
          // Change title color and font settings here for dark mode
          titleTextStyle: TextStyle(
            fontFamily: 'RobotoMono', // <<< CHANGE FONT FAMILY HERE
            color: Colors.white,   // <<< CHANGE COLOR HERE
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),

      // Use the state to switch between themes
      themeMode: newsProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light, // <<< APPLY THEME MODE

      home: const NewsListScreen(),
    );
  }
}




class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
