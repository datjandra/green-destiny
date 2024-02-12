import 'package:latlong2/latlong.dart';
import 'dart:math';

enum LocationType { urban, rural, coastal, forest, desert }

Map<LocationType, List<LatLng>> mappedLocations = {
  LocationType.urban: [
    LatLng(40.7128, -74.0060), // New York City, USA
    LatLng(37.66611, -122.44640), // San Francisco, USA
    LatLng(28.6139, 77.2090), // New Delhi, India
    LatLng(30.0444, 31.2357), // Cairo, Egypt
    LatLng(35.6895, 139.6917) // Tokyo, Japan
  ],
  LocationType.rural: [
    LatLng(31.1471, 75.3412), // Punjab, India
    LatLng(-2.8802, 113.9410), // Central Kalimantan, Indonesia
    LatLng(-12.6819, -56.9211), // Mato Grosso, Brazil
    LatLng(41.8780, -93.0977), // Iowa, USA
    LatLng(19.8563, 102.4955) //  Northern Laos
  ],
  LocationType.coastal: [
    LatLng(22.4196, 113.9793), // Pearl River Delta, China
    LatLng(51.95673, 4.25051), // Rotterdam, Netherlands
    LatLng(1.2903, 103.8523), // Singapore Strait
    LatLng(25.7617, -80.1918), // Miami, Florida, USA
    LatLng(7.8804, 98.3923) // Phuket, Thailand
  ],
  LocationType.forest: [
    LatLng(-3.4653, -62.2159), //  Amazon Rainforest, Brazil
    LatLng(6.5244, 3.3792), // Lagos, Nigeria
    LatLng(52.86928, -128.07809), // British Columbia, Canada
    LatLng(-4.0383, 21.7587), // Democratic Republic of the Congo
    LatLng(-11.7665, -70.8119) // Madre de Dios, Peru
  ],
  LocationType.desert: [
    LatLng(-14.92195, 133.06144), // Australian Outback, Australia
    LatLng(24.0000, 45.0000), // Arabian Desert, Middle East
    LatLng(43.0000, 106.0000), // Gobi Desert, Asia
    LatLng(23.4162, 25.6628), // Sahara Desert, Africa
    LatLng(-24.5197, -69.3169) // Atacama Desert, South America
  ]
};

LatLng getRandomLocationByType(LocationType locationType) {
  LatLng? location;
  List<LatLng>? locations = mappedLocations[locationType];
  if (locations != null) {
    location = locations[Random().nextInt(locations.length)];
  }

  if (location != null) {
    return location;
  } else {
    // Return Tokyo, Japan if something wrong happened
    return LatLng(35.6895, 139.6917);
  }
}
