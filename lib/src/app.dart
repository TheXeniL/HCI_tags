import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_tags/src/models/place.dart';
import 'package:map_tags/src/widgets/cloud_tag.dart';

import 'api/place_api_provider.dart';

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  Set<Marker> _markers = {};
  List<Place> _places = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  static const LatLng _center = const LatLng(55.751483, 48.743836);

  @override
  void initState() {
    PlaceApiProvider().getAllPlaces().then((result) {
      setState(() {
        _places = result.places;
        _markers = _buidMarkers(result.places);
      });
    });
  }

  Set<Marker> _buidMarkers(List<Place> places) {
    setState(() {
      for (var place in places) {
        _markers.add(Marker(
          markerId: MarkerId(place.id),
          position: LatLng(
              double.parse(place.latitude), double.parse(place.longtitude)),
          infoWindow: InfoWindow(
              title: place.name,
              snippet: "Press for more info",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPlaceInfoDialog(
                      context,
                      place.name,
                      place.description,
                      place.image,
                      place.tags),
                );
              }),
          icon: BitmapDescriptor.defaultMarker,
        ));
      }
    });
    return _markers;
  }

  Widget _buildCloudTag(Map<String, dynamic> tags) {
    if (tags.length == 0) {
      return Text("Tags are not available right now");
    } else {
      return CloudTag(tags);
    }
  }

  Widget _buildPlaceInfoDialog(BuildContext context, String name,
      String description, String imageURL, Map<String, dynamic> tags) {
    return new SimpleDialog(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(0),
                  child: Image.network(imageURL, width: 350, height: 200)),
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
              _buildCloudTag(tags)
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
            title: Text('Cava'),
            onTap: () {
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(double.parse(_places[3].latitude),
                          double.parse(_places[3].longtitude)),
                      zoom: 17.0),
                ),
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Nashe Mesto'),
            onTap: () {
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(double.parse(_places[2].latitude),
                          double.parse(_places[2].longtitude)),
                      zoom: 17.0),
                ),
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Burger & Beer 108'),
            onTap: () {
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(double.parse(_places[0].latitude),
                          double.parse(_places[0].longtitude)),
                      zoom: 17.0),
                ),
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Cacio e vino'),
            onTap: () {
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(double.parse(_places[1].latitude),
                          double.parse(_places[1].longtitude)),
                      zoom: 17.0),
                ),
              );
              Navigator.pop(context);
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
            markers: _markers,
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: _center, zoom: 15.0),
          ),
          Container(
            margin: EdgeInsets.only(top: 250, right: 10),
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
            margin: EdgeInsets.only(top: 320, right: 10),
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
