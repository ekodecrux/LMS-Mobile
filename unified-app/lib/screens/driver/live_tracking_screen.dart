import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import '../services/gps_service.dart';
import '../services/api_service.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  Position? _currentPosition;
  bool _isTracking = false;
  StreamSubscription<Position>? _positionStream;
  DateTime? _lastUpdate;

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  Future<void> _startTracking() async {
    final gpsService = Provider.of<GpsService>(context, listen: false);
    final apiService = Provider.of<ApiService>(context, listen: false);

    final hasPermission = await gpsService.checkPermissions();
    if (!hasPermission) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission required')),
        );
      }
      return;
    }

    setState(() => _isTracking = true);

    _positionStream = gpsService.getPositionStream().listen((Position position) {
      setState(() {
        _currentPosition = position;
        _lastUpdate = DateTime.now();
      });

      // Send location to backend every 30 seconds
      if (_lastUpdate == null ||
          DateTime.now().difference(_lastUpdate!).inSeconds >= 30) {
        apiService.updateLocation(
          position.latitude,
          position.longitude,
        ).catchError((e) {
          // Silent fail - continue tracking
        });
      }
    });
  }

  void _stopTracking() {
    _positionStream?.cancel();
    setState(() => _isTracking = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: _isTracking
                      ? Colors.green.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  _isTracking ? Icons.my_location : Icons.location_off,
                  size: 80,
                  color: _isTracking ? Colors.green : Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                _isTracking ? 'Tracking Active' : 'Tracking Inactive',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _isTracking ? Colors.green : Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              if (_currentPosition != null) ..[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          'Latitude',
                          _currentPosition!.latitude.toStringAsFixed(6),
                        ),
                        const Divider(),
                        _buildInfoRow(
                          'Longitude',
                          _currentPosition!.longitude.toStringAsFixed(6),
                        ),
                        const Divider(),
                        _buildInfoRow(
                          'Speed',
                          '${_currentPosition!.speed.toStringAsFixed(1)} m/s',
                        ),
                        const Divider(),
                        _buildInfoRow(
                          'Accuracy',
                          '${_currentPosition!.accuracy.toStringAsFixed(1)} m',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (_lastUpdate != null)
                Text(
                  'Last update: ${_lastUpdate!.hour}:${_lastUpdate!.minute}:${_lastUpdate!.second}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isTracking ? _stopTracking : _startTracking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isTracking ? Colors.red : const Color(0xFFEF4444),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_isTracking ? Icons.stop : Icons.play_arrow),
                      const SizedBox(width: 8),
                      Text(
                        _isTracking ? 'Stop Tracking' : 'Start Tracking',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'GPS tracking sends your location to school every 30 seconds',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
