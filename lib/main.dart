import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(Ratatouille());
}

class Ratatouille extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ratatouille',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SearchPage(title: 'Ratatouille'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);

  final String title;
  final dio = Dio(BaseOptions(
    baseUrl: 'https://developers.zomato.com/api/v2.1/search',
    headers: {
      'user-key' : DotEnv().env['ZOMATO_API_KEY'],
      'Accept' : 'application/json',
    }
  ));

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  String query;

  Future<List> searchRestaurant(String query) async {
    final response = await widget.dio.get('',
        queryParameters: {
          'q' : query,
        },
    );

    return response.data['restaurants'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SearchForm(onSearch: (q){
              setState(() {
                query = q;
              });
            },),
            query == null
                ? Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, color: Colors.black12, size: 100,),
                        Text('No results to display', style: TextStyle(
                            color: Colors.black12,
                            fontSize: 20,
                          ),
                        )
                      ],
                    )
                  )
                  : FutureBuilder(
                      future: searchRestaurant(query),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if(snapshot.hasData) {
                          return Expanded(
                            child: ListView(
                              children: snapshot.data.map<Widget>( (json) => RestaurantItem(Restaurant(json))
                              ).toList(),
                            ),
                          );
                        }

                        return Text('Error getting results: ${snapshot.error}');
                      },
                    )
          ],
        ),
      ),
    );
  }
}

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantItem(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            restaurant.thumbnail != null && restaurant.thumbnail.isNotEmpty ?
              Ink(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(restaurant.thumbnail),
                  ),
                ),
              )
                :
              Container(
                width: 100,
                height: 100,
                color: Colors.grey,
                child: Icon(
                  Icons.restaurant,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurant.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 15,
                        ),
                        SizedBox(width: 5,),
                        Text(restaurant.locality),
                      ],
                    ),
                    SizedBox(height: 5,),
                    RatingBarIndicator(
                      rating: double.parse(restaurant.rating),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemSize: 20,
                    )
                  ],
                ),
              )
            )
          ],
        ),
      )
    );
  }
}

class Restaurant {
  final String id;
  final String name, address, rating, thumbnail;
  final String locality;
  final int reviews;

  Restaurant._({
    this.id,
    this.name,
    this.address,
    this.rating,
    this.locality,
    this.reviews,
    this.thumbnail,
  });

  factory Restaurant(Map json) => Restaurant._(
    id: json['restaurant']['id'],
    name: json['restaurant']['name'],
    address: json['restaurant']['location']['address'],
    rating: json['restaurant']['user_rating']['aggregate_rating'].toString(),
    reviews: json['restaurant']['all_reviews_count'],
    locality: json['restaurant']['location']['locality'],
    thumbnail:
      json['restaurant']['featured_image'] ?? json['restaurant']['thumb']
  );
}

class SearchForm extends StatefulWidget{

  SearchForm({this.onSearch});

  final void Function(String search) onSearch;

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {

  final _formkey = GlobalKey<FormState>();
  String _search;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Enter Restaurant Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  errorStyle: TextStyle(fontSize: 15)
              ),
              validator: (value) {
                if(value.isEmpty){
                  return 'Please enter restaurant name!';
                }
                return null;
              },
              onChanged: (value){
                setState(() {
                  _search = value;
                });
              },
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                onPressed: () {
                  final isValid = _formkey.currentState.validate();
                  if(isValid){
                    widget.onSearch(_search);
                    FocusManager.instance.primaryFocus.unfocus();
                  }
                  else{

                  }
                },
                fillColor:  Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}