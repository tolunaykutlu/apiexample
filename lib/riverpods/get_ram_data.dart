import 'dart:convert';

import 'package:apiexample/models/rick_morty_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final pageProvider = StateProvider<int>((ref) {
  return 1;
});

Future<RaMData> fetchData(int pageNumber) async {
  String url = "https://rickandmortyapi.com/api/character/?page=$pageNumber";

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = RaMData.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception("gelmedi");
    }
  } catch (e) {
    throw Exception("hata $e");
  }
}

final dataProvider = FutureProvider<RaMData>((ref) async {
  final pNumber = ref.watch(pageProvider);
  return fetchData(pNumber);
});
