import 'dart:math';

import 'locations.dart';

List<Scenario> scenarios = [
  // Low impact scenarios
  Scenario(
      name: 'Recycling Campaign',
      temperatureImpact: -0.3,
      sustainabilityImpact: 0.05,
      locationType: LocationType.urban),
  Scenario(
      name: 'Forest Conservation and Protection',
      temperatureImpact: -0.4,
      sustainabilityImpact: 0.08,
      locationType: LocationType.forest),
  Scenario(
      name: 'Agroforestry Practices:',
      temperatureImpact: -0.4,
      sustainabilityImpact: 0.08,
      locationType: LocationType.rural),
  Scenario(
      name: 'Burning of Agricultural Residues',
      temperatureImpact: 0.2, // slightly raise temperature
      sustainabilityImpact: -0.1, // slightly reduce sustainability,
      locationType: LocationType.rural),
  Scenario(
      name: 'Single-use Plastic Usage',
      temperatureImpact: 0.1, // Increase global temperature slightly
      sustainabilityImpact: -0.05,
      locationType: LocationType.urban),
  Scenario(
      name: 'Mining and Extraction Activities',
      temperatureImpact: 0.3, // slightly raise temperature
      sustainabilityImpact: -0.15, // slightly reduce sustainability
      locationType: LocationType.desert),
  Scenario(
      name: 'Increase in Coastal Tourism',
      temperatureImpact: 0.15, // slightly raise temperature
      sustainabilityImpact: -0.08, // slightly reduce sustainability
      locationType: LocationType.coastal),
  Scenario(
      name: 'Forest Fires due to Human Activities',
      temperatureImpact: 0.2, // Increase global temperature slightly
      sustainabilityImpact: -0.08, // Reduce sustainability slightly
      locationType: LocationType.forest),
  Scenario(
      name: 'Increased Use of Fertilizers and Pesticides',
      temperatureImpact: 0.15, // Increase global temperature slightly
      sustainabilityImpact: -0.06, // Reduce sustainability slightly
      locationType: LocationType.rural),
  // Moderate impact scenarios
  Scenario(
      name: 'Implementation of Solar Energy Projects',
      temperatureImpact: -0.6, // Moderate impact on reducing temperature
      sustainabilityImpact:
          0.2, // Significant positive impact on sustainability
      locationType: LocationType.desert),
  Scenario(
      name: 'Rural Energy Efficiency Initiatives',
      temperatureImpact: -0.5, // Moderate impact on reducing temperature
      sustainabilityImpact: 0.12, // Moderate positive impact on sustainability
      locationType: LocationType.rural),
  Scenario(
      name: 'Government Policy on Carbon Emissions',
      temperatureImpact:
          -0.7, // Complex feat with moderate impact on reducing temperature
      sustainabilityImpact:
          0.3, // Significant positive impact on sustainability
      locationType: LocationType.urban),
  Scenario(
      name: 'Commercial Logging and Clearcutting',
      temperatureImpact: 0.5, // Increase global temperature moderately
      sustainabilityImpact: -0.2, // Moderate negative impact on sustainability
      locationType: LocationType.forest),
  Scenario(
      name: 'Large-scale Industrial Emissions',
      temperatureImpact: 0.6, // Increase global temperature moderately
      sustainabilityImpact: -0.25, // Moderate negative impact on sustainability
      locationType: LocationType.urban),
  Scenario(
      name: 'Forest Conversion for Biofuel Production',
      temperatureImpact: 0.7, // Increase global temperature moderately
      sustainabilityImpact: -0.3, // Moderate negative impact on sustainability
      locationType: LocationType.forest),
  Scenario(
      name: 'Intensive Livestock Grazing',
      temperatureImpact: 0.45, // Increase global temperature moderately
      sustainabilityImpact: -0.18, // Moderate negative impact on sustainability
      locationType: LocationType.desert),
  Scenario(
      name: 'Infrastructure Projects for Water Diversion',
      temperatureImpact: 0.5, // Increase global temperature moderately
      sustainabilityImpact: -0.15, // Moderate negative impact on sustainability
      locationType: LocationType.desert),
  Scenario(
      name: 'Use of Fossil Fuels for Heating and Cooking',
      temperatureImpact: 0.6, // Increase global temperature moderately
      sustainabilityImpact: -0.28, // Moderate negative impact on sustainability
      locationType: LocationType.rural),
  Scenario(
      name: 'Coastal Urbanization and Infrastructure Development',
      temperatureImpact: 0.55, // Increase global temperature moderately
      sustainabilityImpact: -0.3, // Moderate negative impact on sustainability
      locationType: LocationType.coastal),
  Scenario(
      name: 'Investment in Coastal Renewable Energy Projects',
      temperatureImpact: -0.5,
      sustainabilityImpact: 0.3,
      locationType: LocationType.coastal),
  Scenario(
      name: 'Intensive Use of Chemical Fertilizers and Pesticides',
      temperatureImpact: 0.7,
      sustainabilityImpact: -0.3,
      locationType: LocationType.rural),
  // high-impact scenarios
  Scenario(
      name: 'Conversion of Peatlands and Wetlands for Agriculture',
      temperatureImpact: 0.8, // Increaes global temperature moderately
      sustainabilityImpact: -0.2, // Decrease sustainability significantly
      locationType: LocationType.rural),
  Scenario(
      name: 'Agroforestry and Silvopasture Practices',
      temperatureImpact: -0.8, // Increaes global temperature moderately
      sustainabilityImpact: 0.35, // Decrease sustainability significantly
      locationType: LocationType.rural),
  Scenario(
      name: 'Creation of Coastal Protected Areas and Marine Reserves',
      temperatureImpact:
          -0.9, // Complex feat with high impact on reducing temperature
      sustainabilityImpact:
          0.25, // Significant positive impact on sustainability
      locationType: LocationType.coastal),
  Scenario(
      name: 'Deforestation for Agriculture',
      temperatureImpact: 0.8, // Increase global temperature signficantly
      sustainabilityImpact: -0.35, // Decrease sustainability significantly
      locationType: LocationType.forest),
  Scenario(
      name: 'Heatwaves and Urban Heat Islands',
      temperatureImpact: 0.9, // Increase global temperature signficantly
      sustainabilityImpact: -0.4, // Decrease sustainability significantly
      locationType: LocationType.urban),
  Scenario(
      name: 'Destruction of Coastal Vegetation for Tourism Development',
      temperatureImpact: 0.75, // Increase global temperature signficantly
      sustainabilityImpact: -0.36, // Decrease sustainability significantly
      locationType: LocationType.coastal),
  Scenario(
      name: 'Large-scale Land Conversion for Renewable Energy Projects',
      temperatureImpact: 0.85, // Increase global temperature signficantly
      sustainabilityImpact: -0.38, // Decrease sustainability significantly
      locationType: LocationType.desert),
  Scenario(
      name: 'Urban Sprawl and Land Use Conversion',
      temperatureImpact: 0.8,
      sustainabilityImpact: -0.3,
      locationType: LocationType.urban)
];

class Scenario {
  final String name;
  final double temperatureImpact;
  final double sustainabilityImpact;
  final LocationType locationType;

  Scenario(
      {required this.name,
      required this.temperatureImpact,
      required this.sustainabilityImpact,
      required this.locationType});
}

Scenario getRandomScenario() {
  final random = Random();
  final index = random.nextInt(scenarios.length);
  return scenarios[index];
}
