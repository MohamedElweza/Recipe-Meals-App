import 'package:food_recipe/database/recipes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String columnId = 'id';
final String columnName = 'name';
final String columnImage = 'image';
final String recipeTable = 'recipe_table';

class RecipesHelper {
  late Database db;
  static final RecipesHelper instance = RecipesHelper._internal();

  factory RecipesHelper() {
    return instance;
  }
  RecipesHelper._internal();
  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'recipesList.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
          create table $recipeTable (
          $columnId integer not null,
          $columnName text not null,
          $columnImage text not null
          )
          ''');
    });
  }

  Future<Recipes> insertRecipe(Recipes recipe) async {
    recipe.id = await db.insert(recipeTable, recipe.toMap());
    return recipe;
  }

  Future<int> deleteRecipe(int id) async {
    return await db
        .delete(recipeTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Recipes>> getAllRecipes() async {
    List<Map<String, dynamic>> RecipeMaps = await db.query(recipeTable);
    if (RecipeMaps.isEmpty) {
      return [];
    } else {
      List<Recipes> recipes = [];
      for (var element in RecipeMaps) {
        recipes.add(Recipes.fromMap(element));
      }
      return recipes;
    }
  }

  Future close() async => db.close();
}
