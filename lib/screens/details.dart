import 'package:flutter/material.dart';
import 'package:food_recipe/database/helper.dart';
import 'package:food_recipe/database/recipes.dart';
import 'package:food_recipe/models/information_res.dart';
import 'package:food_recipe/models/results.dart';
import '../api/api_info.dart';

class Details extends StatefulWidget {
  Results data;
  Details(this.data, {Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool toggle = false;
  late int id;
  final infoApi = RecipeInfo();
  late Information response;
  int num = 1;
  @override
  void initState() {
    super.initState();
    id = widget.data.id;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff0A947D),
            size: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                toggle = !toggle;
                if (toggle == false) {
                  RecipesHelper.instance.deleteRecipe(widget.data.id);
                } else {
                  RecipesHelper.instance.insertRecipe(
                    Recipes(
                      name: response.title,
                      image: response.image,
                      id: response.id,
                    ),
                  );
                }
              });
            },
            icon: toggle
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(Icons.favorite_border, color: Colors.red),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.play_arrow_outlined,
                size: 25,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                size: 25,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                size: 25,
                color: Colors.black,
              )),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Information>(
          future: infoApi.getApiInfo(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              response = snapshot.data!;
              return Column(
                children: [
                  Image(
                    image: NetworkImage(snapshot.data!.image),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      snapshot.data!.title,
                      style: const TextStyle(
                          color: Color(0xff0A947D),
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                            width: 130,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.transparent,
                                  blurRadius: 9,
                                  offset: Offset(2, 4), // Shadow position
                                ),
                              ],
                            ),
                            child: const Center(child: Text('Easy'))),
                        Container(
                            width: 130,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.white10,
                                  blurRadius: 4,
                                  offset: Offset(4, 8), // Shadow position
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Center(
                                    child: Icon(Icons.timer,
                                        color: Color(0xff0A947D))),
                                const SizedBox(
                                  height: 5,
                                ),
                                Center(
                                    child: Text(
                                        response.readyInMinutes.toString())),
                              ],
                            )),
                        Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.white10,
                                  blurRadius: 4,
                                  offset: Offset(4, 8), // Shadow position
                                ),
                              ],
                            ),
                            child: Column(
                              children: const [
                                Center(
                                    child: Text('15',
                                        style: TextStyle(
                                            color: Color(0xff0A947D)))),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(child: Text('Ingredient')),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      response.summary,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${response.servings} Serving',
                          style: const TextStyle(
                              color: Color(0xff0A947D),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  num == 1 ? num = 1 : num--;
                                });
                              },
                              color: Colors.white,
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  num++;
                                });
                              },
                              color: Colors.white,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 210),
                    child: Text(
                      "Ingredient's",
                      style: TextStyle(
                          color: Color(0xff0A947D),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              return Container();
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    ));
  }
}
