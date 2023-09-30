import 'dart:convert';

import 'package:find_house/models/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SpaceProvider extends ChangeNotifier {
  Future<List<Space>> getRecomendedSpace() async {
    var result = await http
        .get(Uri.parse('https://bwa-cozy-api.vercel.app/recommended-spaces'));

    if (result.statusCode == 200) {
      List data = jsonDecode(result.body);
      List<Space> spaces = data.map((item) => Space.fromJson(item)).toList();
      print(result.statusCode);
      print(result.body);
      return spaces;
    } else {
      return <Space>[];
    }
  }
}
