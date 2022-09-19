import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

String? stringResponse;
Map? mapResponse;
Map? dataResponse;
List? listResponse;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future apicall() async {
    http.Response response;
    // api link is parsed for getting responses
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse =
            mapResponse!['data']; // to get response from data in listResponse
      });
    }
  }

  @override
  void initState() {
    //initState will call apicall function
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //ui
        appBar: AppBar(
          title: Text('APIs'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.network(listResponse![index]['avatar']),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(listResponse![index]['id'].toString()),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            listResponse![index]['first_name'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight
                                    .w800), //firstname is done bold by fontweight
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(listResponse![index]['last_name'].toString()),
                          SizedBox(
                            height: 8,
                          ),
                          Text(listResponse![index]['email'].toString()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          //if response value is null it will give 0 else it will give complete length of the response list
          itemCount: listResponse == null ? 0 : listResponse!.length,
        ));
  }
}
