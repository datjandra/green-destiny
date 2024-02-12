import 'package:latlong2/latlong.dart';
import 'dart:math';

List<LatLng> eventLocations = [
  LatLng(40.7128, -74.0060), // New York City (Recycling campaign)
  LatLng(51.5171, 7.4500), // Ruhr Area, Germany (Industrial Area)
  LatLng(36.7372,
      -119.6951), // Central Valley, California, USA (Agricultural Region)
  LatLng(-3.4653, -62.2159), // Amazon Rainforest, Brazil (Rainforest Area)
  LatLng(4.6616, 6.9743), // Niger Delta, Nigeria
  LatLng(22.1920,
      113.5417), // Pearl River Delta, China (Highly Urbanized and Industrialized Area)
  LatLng(-6.9611,
      107.1394), // Citarum River, Indonesia (Industrial and Chemical Waste Area)
  LatLng(2.9046, 114.7277), // Borneo Island (Deforestation Hotspot)
  LatLng(37.76063,
      -122.44768), // San Francisco, USA (Technological Hub with Renewable Energy Investment potential)
  LatLng(
      30.0444, 31.2357), // Cairo, Egypt (Urban Sprawl and Industrial Pollution)
  LatLng(-33.96550,
      18.60244), // Cape Town, South Africa (Water Scarcity and Pollution)
  LatLng(19.4326,
      -99.1332), // Mexico City, Mexico (Urban Sprawl and Air Pollution)
  LatLng(28.6139, 77.2090), // New Delhi, India (Urbanization and Air Pollution)
  LatLng(51.5074,
      -0.1278), // London, UK (Government Policy on Carbon Emissions and Sustainability Initiatives)
  LatLng(-34.64830,
      -58.77762) // Buenos Aires, Argentina (Industrial Pollution and Urbanization)
];

LatLng getRandomLocation() {
  final random = Random();
  final index = random.nextInt(eventLocations.length);
  return eventLocations[index];
}
