import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'model/list_of_photos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Exam Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var defaultListOtPhotos = ListOtPhotos();

  void getPhotoAndUpdateUi () async {
    ListOtPhotos randomPhoto = await getPhoto();

    setState(() {
      defaultListOtPhotos.imageUrl = randomPhoto.imageUrl;
      defaultListOtPhotos.title = randomPhoto.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(defaultListOtPhotos.imageUrl),
          Text(
            defaultListOtPhotos.title,
            style: const TextStyle(fontSize: 20.0),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getPhotoAndUpdateUi(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<ListOtPhotos> getPhoto() async {
    var url = Uri.parse('608bd4239f42b20017c3cee6.mockapi.io/photos');

    var response = await http.get(url, headers: {
      "accept": "application/json",
    });

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      return ListOtPhotos(imageUrl: json['icon_url'], title: json['value']);


    } else {
      debugPrint(response.body);

      return ListOtPhotos();
    }
  }
}