import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
class AllVets extends StatefulWidget {
  const AllVets({
    Key? key,
    required this.latLng,
    required this.currentLocation,
  }) : super(key: key);

  final List<LatLng>? latLng;
  final LatLng? currentLocation;

  @override
  _AllVetsState createState() => _AllVetsState();
}

class _AllVetsState extends State<AllVets> {
  late GoogleMapController _googleMapController;
  late LatLng _initialLocation;

  @override
  void initState() {
    super.initState();
    // Set the initial location
    _initialLocation = widget.currentLocation ?? widget.latLng!.first;
    //_initialLocation=LatLng(23.83839616689758, 90.36708542688567);
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/vet');
          },
        ),
        title: Text('Our Vets'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                onMapCreated: (controller) {
                  _googleMapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: _initialLocation,
                  zoom: 14,
                ),
                markers: widget.latLng!
                    .map(
                      (latLng) => Marker(
                        markerId: MarkerId(latLng.toString()),
                        position: latLng,
                      ),
                    )
                    .toSet(),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
