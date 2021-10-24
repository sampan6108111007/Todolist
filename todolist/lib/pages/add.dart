import 'package:flutter/material.dart';
// http method package
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการใหม่'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // ช่องกรอกข้อมูล Todolist
            TextField(
                controller: todo_title,
                decoration: InputDecoration(
                    labelText: 'รายการที่ต้องทำ', border: OutlineInputBorder())),
            SizedBox(
              height: 30,
            ),
            TextField(
                minLines: 4,
                maxLines: 8,
                controller: todo_detail,
                decoration: InputDecoration(
                    labelText: 'รายละเอียด', border: OutlineInputBorder())),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                    print('------------');
                    print('title: ${todo_title.text}');
                    print('detial: ${todo_detail.text}');
                    postTodo();
                    setState(() {
                      todo_title.clear();
                      todo_detail.clear();
                    });
                    

                },
                child: Text(
                  "เพิ่มรายการ",
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(30, 10, 30, 10)),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ใช้สำหรับการทำงานที่มีการรอเวลาจากการ respons จาก server จากฟังชั่น async
  Future postTodo() async {
    //var url = Uri.https('2ea5-49-228-243-218.ngrok.io', '/api/post-todolist');
    var url = Uri.http('192.168.7.4:8000', '/api/post-todolist');
    Map<String, String> header = {"content-type":"application/json"};
    String jsondata = '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header , body: jsondata);
    print('------result------');
    print(response.body);
  }


}
