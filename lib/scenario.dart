List<Scenario> scenarios = [
  Scenario(
      name: 'Recycling campaign',
      temperatureImpact: -0.3,
      sustainabilityImpact: 0.05),
  Scenario(
      name: 'Planting trees',
      temperatureImpact: -0.4,
      sustainabilityImpact: 0.08),
  Scenario(
    name: 'Renewable Energy Investment',
    temperatureImpact: -0.6, // Moderate impact on reducing temperature
    sustainabilityImpact: 0.2, // Significant positive impact on sustainability
  ),
  Scenario(
    name: 'Community Garden Project',
    temperatureImpact: -0.5, // Moderate impact on reducing temperature
    sustainabilityImpact: 0.12, // Moderate positive impact on sustainability
  ),
  Scenario(
    name: 'Carbon Capture Technology Implementation',
    temperatureImpact:
        -0.9, // Complex feat with high impact on reducing temperature
    sustainabilityImpact: 0.25, // Significant positive impact on sustainability
  ),
  Scenario(
    name: 'Government Policy on Carbon Emissions',
    temperatureImpact:
        -0.7, // Complex feat with moderate impact on reducing temperature
    sustainabilityImpact: 0.3, // Significant positive impact on sustainability
  ),
  Scenario(
    name: 'Burning fossil fuels',
    temperatureImpact: 0.2, // slightly raise temperature
    sustainabilityImpact: -0.1, // slightly reduce sustainability
  ),
  Scenario(
    name: 'Deforestation',
    temperatureImpact: 0.3, // slightly raise temperature
    sustainabilityImpact: -0.15, // slightly reduce sustainability
  ),
  Scenario(
    name: 'Industrial pollution',
    temperatureImpact: 0.15, // slightly raise temperature
    sustainabilityImpact: -0.08, // slightly reduce sustainability
  ),
  Scenario(
    name: 'Single-use Plastic Usage',
    temperatureImpact: 0.1, // Increase global temperature slightly
    sustainabilityImpact: -0.05, // Reduce sustainability slightly
  ),
  Scenario(
    name: 'Landfill Expansion',
    temperatureImpact: 0.2, // Increase global temperature slightly
    sustainabilityImpact: -0.08, // Reduce sustainability slightly
  ),
  Scenario(
    name: 'Excessive Water Consumption',
    temperatureImpact: 0.15, // Increase global temperature slightly
    sustainabilityImpact: -0.06, // Reduce sustainability slightly
  ),
  Scenario(
    name: 'Mass Deforestation',
    temperatureImpact: 0.5, // Increase global temperature moderately
    sustainabilityImpact: -0.2, // Moderate negative impact on sustainability
  ),
  Scenario(
    name: 'Large-scale Industrial Emissions',
    temperatureImpact: 0.6, // Increase global temperature moderately
    sustainabilityImpact: -0.25, // Moderate negative impact on sustainability
  ),
  Scenario(
    name: 'Expansion of Coal Mining',
    temperatureImpact: 0.7, // Increase global temperature moderately
    sustainabilityImpact: -0.3, // Moderate negative impact on sustainability
  ),
  Scenario(
    name: 'Oil Spill Pollution',
    temperatureImpact: 0.4, // Increase global temperature moderately
    sustainabilityImpact: -0.18, // Moderate negative impact on sustainability
  ),
  Scenario(
    name: 'Urban Sprawl',
    temperatureImpact: 0.3, // Increase global temperature moderately
    sustainabilityImpact: -0.15, // Moderate negative impact on sustainability
  ),
  Scenario(
    name: 'Intensive Livestock Farming',
    temperatureImpact: 0.6, // Increase global temperature moderately
    sustainabilityImpact: -0.28, // Moderate negative impact on sustainability
  ),
  Scenario(
    name: 'Expansion of Oil Drilling',
    temperatureImpact: 0.8, // Increase global temperature signficantly
    sustainabilityImpact: -0.35, // Decrease sustainability significantly
  ),
  Scenario(
    name: 'Deforestation for Agriculture',
    temperatureImpact: 0.9, // Increase global temperature signficantly
    sustainabilityImpact: -0.4, // Decrease sustainability significantly
  ),
  Scenario(
    name: 'Increased Urbanization',
    temperatureImpact: 0.7, // Increaes global temperature moderately
    sustainabilityImpact: -0.32, // Decrease sustainability significantly
  ),
  Scenario(
    name: 'Expansion of Cement Production',
    temperatureImpact: 0.75, // Increase global temperature signficantly
    sustainabilityImpact: -0.36, // Decrease sustainability significantly
  ),
  Scenario(
    name: 'Industrial Chemical Waste Dumping',
    temperatureImpact: 0.85, // Increase global temperature signficantly
    sustainabilityImpact: -0.38, // Decrease sustainability significantly
  )
];

class Scenario {
  final String name;
  final double temperatureImpact;
  final double sustainabilityImpact;

  Scenario(
      {required this.name,
      required this.temperatureImpact,
      required this.sustainabilityImpact});
}
