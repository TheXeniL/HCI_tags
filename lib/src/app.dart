
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_tags/src/models/place_tags.dart';
import 'package:map_tags/src/widgets/cloud_tag.dart';

import 'api/place_api_provider.dart';

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  // List<Place> _places = [
  //   Place('Caffe Cava', 'Famous coffe place', LatLng(55.753353, 48.743817)),
  //   Place('Burger & Beer 108', 'Famoous Innopolis bar',
  //       LatLng(55.7487577, 48.74133))
  // ];

  // final Set<Marker> _markers = {};
  // var rng = new Random();
  // final List<PlaceTag> _tags = [
  //   PlaceTag('#Tasty', 67),
  //   PlaceTag('#Salty', 55),
  //   PlaceTag('#Amazing', 42),
  //   PlaceTag('#Boring', 22),
  //   PlaceTag('#Noisy', 15),
  //   PlaceTag('#Waiting', 37),
  //   PlaceTag('#Cakes!', 29),
  //   PlaceTag('#Capuccino', 48),
  //   PlaceTag('#Sushi', 15),
  //   PlaceTag('#Coisy', 33),
  //   PlaceTag('#Music', 55),
  //   PlaceTag('#Jazz', 16)
  // ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  static const LatLng _center = const LatLng(55.751483, 48.743836);

  // Set<Marker> _buidMarkers() {
  //   setState(() {
  //     for (var place in _places) {
  //       _markers.add(Marker(
  //         markerId: MarkerId(place.id),
  //         position: place.position,
  //         infoWindow: InfoWindow(
  //             title: place.tittle,
  //             snippet: "Press for more info",
  //             onTap: () {
  //               showDialog(
  //                 context: context,
  //                 builder: (BuildContext context) => _buildPlaceInfoDialog(
  //                     context, place.tittle, place.description, _tags),
  //               );
  //             }),
  //         icon: BitmapDescriptor.defaultMarker,
  //       ));
  //     }
  //   });
  //   return _markers;
  // }

  Widget _buildPlaceInfoDialog(BuildContext context, String name,
      String description, List<PlaceTag> tags) {
    return new SimpleDialog(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(0),
                  child: Image.asset('assets/images/cafe_cava.jpeg',
                      width: 350, height: 200)),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'Helvetica'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(description,
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey)),
              ),
              CloudTag(tags)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buidDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Nikita Elizarov"),
            accountEmail: Text("xenilcool@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("NE"),
            ),
          ),
          ListTile(
            title: Text('Nearby places'),
            leading: Icon(Icons.place),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              PlaceApiProvider().getAllPlaces();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buidDrawer(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: _center, zoom: 15.0),
          ),
          Container(
            margin: EdgeInsets.only(top: 350, right: 10),
            alignment: Alignment.topRight,
            child: Column(children: <Widget>[
              FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  elevation: 5,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomIn(),
                    );
                  }),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 420, right: 10),
            alignment: Alignment.topRight,
            child: Column(children: <Widget>[
              FloatingActionButton(
                  child: Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                  elevation: 5,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomOut(),
                    );
                  }),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.0, left: 10, right: 10),
            child: new Container(
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: new BorderRadius.circular(10.0),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black,
                    blurRadius: 0.5,
                    offset: new Offset(0.0, 1.0),
                  )
                ],
              ),
              child: TextFormField(
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search tags",
                  fillColor: Colors.blue,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.menu),
                    iconSize: 30.0,
                    onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.mic),
                    onPressed: () {},
                    iconSize: 30.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
