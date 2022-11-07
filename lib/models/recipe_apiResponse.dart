import 'package:food_recipe/models/results.dart';

class RecipeApiResponse {
  late List<Results> result;
  late int offset;
  late int number;
  late int totalResults;

  RecipeApiResponse({
    required this.result,
    required this.offset,
    required this.number,
    required this.totalResults,
  });
  RecipeApiResponse.fromMap(Map<String, dynamic> map) {
    this.result = [];
    (map['results'] as List).forEach((element) {
      this.result.add(Results.fromMap(element));
    });
    this.offset = map['offset'];
    this.number = map['number'];
    this.totalResults = map['totalResults'];
  }
  Map<String, dynamic> toMap() {
    List<Map> resultList = [];
    this.result.forEach((element) {
      resultList.add(element.toMap());
    });
    Map<String, dynamic> map = {
      'result': resultList,
      'offset': this.offset,
      'number': this.number,
      'totalResult': this.totalResults,
    };
    return map;
  }
}
