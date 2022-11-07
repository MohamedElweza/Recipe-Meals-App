import 'dart:convert';
import 'package:food_recipe/models/information_res.dart';
import 'package:http/http.dart' as http;

class RecipeInfo {
  Future<Information> getApiInfo(int? id) async {
    final http.Response info = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/$id/information?apiKey=73e96478bba64a83b619435ea1b0268d'));
    if (info.statusCode <= 299 && info.statusCode >= 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(info.body);
      Information infoApiResponse = Information.fromMap(jsonBody);
      return infoApiResponse;
    } else {
      throw ('Request Fail${info.body}');
    }
  }
}
