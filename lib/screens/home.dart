import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/models/recipe_apiResponse.dart';
import 'package:food_recipe/models/results.dart';
import 'package:food_recipe/screens/favorites.dart';

import '../api/api.dart';
import 'details.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late RecipeApiResponse response;
  final recipeApi = RecipefoodApp();
  int _selectedIndex = 0;
   void _onItemTapped(int index) {
     setState(() {
       _selectedIndex = index;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar:
          Row(children: [
          // IconButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Favorite() )
          // , icon: null,, icon: null,],
            IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Favorite()));}, icon: Icon(Icons.favorite_border)),
            IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Favorite()));}, icon: Icon(Icons.home_filled)),
  ]
    ),
      // BottomNavigationBar(

        // currentIndex: _selectedIndex,
        // onTap: _onItemTapped,
        // type: BottomNavigationBarType.fixed,
        // selectedFontSize: 20,
        // unselectedItemColor: Colors.black,
        // selectedIconTheme: const IconThemeData(color: Color(0xff0A947D)),
        // selectedItemColor: const Color(0xff0A947D),
        // selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold,color: Color(0xff0A947D)),
        // unselectedLabelStyle: const TextStyle(color: Colors.black),
        // items:   [
        //   Row(children: [],),
          // BottomNavigationBarItem(
          //   // activeIcon: IconButton(onPressed: () {  }, icon: Icon(Icons.home_filled,size: 30,)),
          //   label: 'Home',icon: Icon(Icons.home_filled),
          // ),
          // BottomNavigationBarItem(
          //   // activeIcon: IconButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Favorite() )); },
          //   // icon: Icon(Icons.favorite_border,size: 30),
          //   label: 'Favorites', icon: Icon(Icons.favorite_border),
          // ),
      //   ],
      // ),

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
         title: const Text('Recipes', style: TextStyle(color: Color(0xff0A947D), fontWeight:FontWeight.bold, fontSize: 25 ),),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search, color: Color(0xff0A947D), size: 30,)),
        ],
      ),
      body: FutureBuilder<RecipeApiResponse>(
        future: recipeApi.getApiData(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            response = snapshot.data!;
            // print(snapshot.data!.result.first.title.split(','));
        return GridView.builder(
          physics: BouncingScrollPhysics(),
            itemCount: response.result.length,
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (BuildContext context, int index) {
              Results recipe = response.result[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Details(recipe);
                      },
                    ),
                  );
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius. circular(8.0),
                          child:  Image(image:NetworkImage(response.result.elementAt(index).image ,),
                        )),
                         Text(response.result.elementAt(index).title, style: TextStyle(
                             overflow: TextOverflow.ellipsis,
                             fontWeight: FontWeight.bold, fontSize: 20),),
                      ],
                    ),
                  ),
                ),
              );
            },);}
          if (snapshot.hasError) {
          print(snapshot.error);
          return Container();
          }

          return const Center(
          child: CircularProgressIndicator(),
          );
        }
      ),
    );
  }
}
