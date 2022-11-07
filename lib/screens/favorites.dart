import 'package:flutter/material.dart';
import 'package:food_recipe/database/helper.dart';
import 'package:food_recipe/database/recipes.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Recipes> recipes = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Favorites',
          style: TextStyle(
              color: Color(0xff0A947D),
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Color(0xff0A947D),
                size: 30,
              )),
        ],
      ),
      body: FutureBuilder<List<Recipes>>(
          future: RecipesHelper.instance.getAllRecipes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              recipes = snapshot.data!;
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: recipes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image(
                                image: NetworkImage(
                                  recipes.elementAt(index).image,
                                ),
                              )),
                          Text(
                            recipes.elementAt(index).name,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              return Container();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
