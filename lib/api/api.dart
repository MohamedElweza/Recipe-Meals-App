import 'dart:convert';
import '../models/recipe_apiResponse.dart';
import 'package:http/http.dart' as http;

class RecipefoodApp{

Future<RecipeApiResponse> getApiData() async{
  final http.Response request = await http.get(Uri.parse('https://api.spoonacular.com/recipes/complexSearch?apiKey=73e96478bba64a83b619435ea1b0268d'));

  if (request.statusCode <= 299 && request.statusCode >= 200){
    final Map<String, dynamic> jsonBody = jsonDecode(request.body);
    RecipeApiResponse recipeApiResponse = RecipeApiResponse.fromMap(jsonBody);
    return recipeApiResponse;
  }else{
    throw ('Request Fail${request.body}');
  }
}
}