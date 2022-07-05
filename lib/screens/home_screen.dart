import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth.dart';
import '../shared/constants.dart';
import '../model/data_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DataModel> dataList = [];
  dynamic name;

  Future<List<DataModel>> getData() async {
    final res =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(res.body.toString());
    if (res.statusCode == 200) {
      dataList.clear();
      for (Map i in data) {
        dataList.add(DataModel.fromJson(i));
      }
      return dataList;
    } else {
      return dataList;
    }
  }

  Future getUser() async {
    var pref = await SharedPreferences.getInstance();
    var data = jsonDecode(pref.getString('userData')!);
    setState(() {
      name = data['data']['user']['name'];
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: (name == null)
              ? CircularProgressIndicator(color: kPrimaryColor)
              : Text(
                  name,
                  style: kBodyText.copyWith(color: kWhite, fontSize: 22),
                ),
          actions: [
            GestureDetector(
              onTap: () {
                AuthController.logOut();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Icon(
                  Icons.logout,
                  color: kWhite,
                  size: 28,
                ),
              ),
            )
          ]),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(color: kPrimaryColor));
            } else {
              return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${dataList[index].id.toString()} ${dataList[index].title.toString()}",
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(dataList[index].body.toString(),
                                  style: kBodyText.copyWith(fontSize: 14))
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
