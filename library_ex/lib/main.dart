import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LibraryExample(),
    );
  }
}

class LibraryExample extends StatefulWidget {
  @override
  State<LibraryExample> createState() => _LibraryExample();
}

class _LibraryExample extends State<LibraryExample> {
  String result = '';
  List? data;
  TextEditingController? _editingController;
  ScrollController? _scrollController;
  int page = 1;

  @override
  void initState() {
    super.initState();
    data = List.empty(growable: true);
    _editingController = TextEditingController();
    _scrollController = ScrollController();

    _scrollController!.addListener(() {
      if (_scrollController!.offset >=
              _scrollController!.position.maxScrollExtent &&
          !_scrollController!.position.outOfRange) {
        page++;
        getJSONData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: 'Input searching word'),
        ),
      ),
      body: Center(
        child: data!.isEmpty
            ? const Text('No Data',
                style: TextStyle(fontSize: 20), textAlign: TextAlign.center)
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Image.network(
                            data![index]['thumbnail'] == ""
                                ? "https://image.kyobobook.co.kr/newimages/apps/b2b_academy/common/noimage_150_215.gif"
                                : data![index]['thumbnail'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain),
                        Column(
                          children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width - 150,
                                child: Text(
                                  data![index]['title'].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                )),
                            SizedBox(
                                width: MediaQuery.of(context).size.width - 150,
                                child: Text(
                                  'Author: ${data![index]["authors"].toString()}',
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Text(
                                'Price: ${data![index]["sale_price"].toString()}'),
                            Text(
                                'Status: ${data![index]["status"].toString()}'),
                          ],
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  );
                },
                itemCount: data!.length,
                controller: _scrollController,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          page = 1;
          data!.clear();
          getJSONData();
        },
        child: const Icon(Icons.file_download),
      ),
    );
  }

  Future<String> getJSONData() async {
    var url =
        'https://dapi.kakao.com/v3/search/book?target=title&page=$page&query=${_editingController!.value.text}';
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "KakaoAK NEED_KAKAO_REST_API_KEY"});

    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];
      data!.addAll(result);
    });
    return response.body;
  }
}
