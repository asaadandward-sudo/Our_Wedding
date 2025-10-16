import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';

class InteractiveMapBox extends StatefulWidget {
  final String locationTitle;
  final double latitude;
  final double longitude;
  final double? height;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  const InteractiveMapBox({
    super.key,
    required this.locationTitle,
    required this.latitude,
    required this.longitude,
    this.height,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  });

  @override
  State<InteractiveMapBox> createState() => _InteractiveMapBoxState();
}

class _InteractiveMapBoxState extends State<InteractiveMapBox> {
  MapController? _mapController;
  bool _satelliteView = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? 25;
    final borderColor = widget.borderColor ?? InvitationColors.darkOlive;
    final borderWidth = widget.borderWidth ?? 2;
    final center = LatLng(widget.latitude, widget.longitude);

    return Container(
      height: widget.height ?? 300,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
        minWidth: MediaQuery.of(context).size.width * 0.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 15
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: center,
                initialZoom: 16,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.all,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: _satelliteView
                      ? 'https://api.maptiler.com/tiles/satellite/{z}/{x}/{y}.jpg?key=YOUR_MAPTILER_KEY'
                      : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: center,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.location_pin,
                        color: InvitationColors.error,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Zoom controls
            Positioned(
              bottom: 13,
              right: 13,
              child: Column(
                children: [
                  _MapButton(
                    icon: Icons.add,
                    onTap: () {
                      if (_mapController != null) {
                        _mapController!.move(
                          _mapController!.camera.center,
                          _mapController!.camera.zoom + 1,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  _MapButton(
                    icon: Icons.remove,
                    onTap: () {
                      if (_mapController != null) {
                        _mapController!.move(
                          _mapController!.camera.center,
                          _mapController!.camera.zoom - 1,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            // Toggle Map Type
            Positioned(
              top: 10,
              right: 10,
              child: _MapButton(
                icon: _satelliteView ? Icons.map : Icons.satellite_alt,
                onTap: () => setState(() => _satelliteView = !_satelliteView),
              ),
            ),

            // View Larger Map
            Positioned(
              bottom: 10,
              left: 10,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4169E1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () async {
                  final url = 'https://www.google.com/maps/search/?api=1&query=${widget.latitude},${widget.longitude}';
                  await launchUrl(Uri.parse(url));
                },
                icon: const Icon(Icons.open_in_new, color: Colors.white, size: 18),
                label: const Text('View larger map', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }
}
