import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class GoogleMapScreen extends StatefulWidget {
  final double lng;
  final double lat;
  final double currentlat;
  final double currentlng;
  final int idevent;
  const GoogleMapScreen(
      this.currentlat, this.currentlng, this.idevent, this.lat, this.lng,
      {Key key})
      : super(key: key);
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  double lng = 0;
  double lat = 0;
  double _originLatitude;
  double _originLongitude;
  double _destLatitude;
  double _destLongitude;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  GoogleMapController mapController;
  List<LatLng> polylineCoordinates = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      _destLatitude = widget.lat;
      _destLongitude = widget.lng;
      _originLatitude = widget.currentlat;
      _originLongitude = widget.currentlng;
    });

    _getPolyline();
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: cherry,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      keymap,
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        setState(() {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
    } else {
      // ignore: avoid_print
      print(result.errorMessage);
    }

    _addPolyLine(polylineCoordinates);
  }

  @override
  Widget build(BuildContext context) {
    final _initialCameraPosition =
        CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 14.0);
    final Marker marker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(_destLatitude, _destLongitude),
        markerId: MarkerId(widget.idevent.toString()));

    return Scaffold(
      backgroundColor: gray,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: indigo,
        title: const AutoSizeText(
          "Location",
          style: TextStyle(color: white),
          textAlign: TextAlign.center,
          maxLines: 2,
          maxFontSize: 16,
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        markers: {marker},
        onMapCreated: _onMapCreated,
        polylines: Set<Polyline>.of(polylines.values),
        initialCameraPosition: _initialCameraPosition,
      ),
    );
  }
}
