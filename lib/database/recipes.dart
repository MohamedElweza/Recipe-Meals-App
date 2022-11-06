import 'package:food_recipe/database/helper.dart';
class Recipes{

  int? id;
  late String image;
  late String name;

  Recipes({
    required this.id,
    required this.image,
    required this.name,
  });

  Recipes.fromMap(Map<String, dynamic> map){
    if(map[columnId] != null) id = map[columnId];
    name = map[columnName];
    image = map[columnImage];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map ={};
    if(id != null) map[columnId] = id;
    map[columnName] = name;
    map[columnImage] = image;
  return map;
  }

}