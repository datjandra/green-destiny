<p align="center">
  <img src="assets/images/portrait.png" width="320" alt="Green Destiny heroine portrait">
</p>

<p align="center">
  <em>
    A strategic environmental decision-making game blending fantasy 
    themes with climate and sustainability challenges.
  </em>
</p>

<p align="center">
  <a href="https://datjandra.github.io/green-destiny/#/">
    <img src="https://img.shields.io/badge/PLAY-LIVE_DEMO-2ea44f?style=for-the-badge" alt="Play Live Demo">
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Web-blue?style=flat-square">
  <img src="https://img.shields.io/badge/License-LGPL_2.1-green?style=flat-square">
  <img src="https://img.shields.io/badge/Status-Playable-success?style=flat-square">
</p>

---

## Overview

Green Destiny is an interactive strategy game where players assume the role of a mystical guardian wielding probability-altering powers to influence global environmental outcomes. Navigate geographically diverse locations—from urban centers to remote forests—and make critical choices about climate action, resource management, and sustainability. Every decision impacts the planet's fate.

## Core Gameplay

**Three Actions, Infinite Consequences:**
- **Boost** - Amplify probability to increase your environmental impact (risks sustainability depletion)
- **Weaken** - Reduce negative effects with lower success rates
- **Do Nothing** - Accept the scenario's natural outcome without intervention

**Key Mechanics:**
- **30+ Dynamic Scenarios** - Environmental challenges ranging from recycling campaigns to large-scale industrial emissions
- **Global Temperature System** - Win by cooling the planet below 10°C; lose if it exceeds 20°C
- **Sustainability Index** - Track planetary resource health; depletion triggers game over
- **Probability Power System** - Grow your mystical power through successful interventions, but risk overuse penalties
- **Real-Time Map Integration** - Interactive OpenStreetMap visualization showing event locations across multiple biomes (urban, forest, desert, coastal, rural)

## Difficulty Levels

Challenge yourself with three difficulty tiers:
- **Normal** - Balanced gameplay with forgiving starting conditions
- **Harder** - Increased baseline temperature and reduced power reserves
- **Hardest** - Extreme constraints demanding strategic precision

## Game Win/Loss Conditions

**Victory:** Reduce global temperature to ≤ 10°C through calculated interventions

**Defeat:** 
- Global temperature exceeds 20°C (runaway warming)
- Sustainability index depletes to zero (planetary collapse from power overuse)

## Technical Details

**Built With:**
- **Flutter** - Cross-platform mobile framework
- **Dart** (90.7% of codebase) - Primary language
- **flutter_map & OpenStreetMap** - Interactive geospatial visualization
- **Custom Animation System** - Temporal shift visual feedback
- **LGPL 2.1 License** - Open-source project

**Supported Platforms:**
- iOS
- Android
- Web

## Getting Started

### Prerequisites
- Flutter SDK (≥ 3.0.0)
- Dart SDK (≥ 3.0.0)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/datjandra/green-destiny.git
   cd green-destiny
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Development

To explore the codebase:
- **`lib/main.dart`** - App entry point and theme configuration
- **`lib/game.dart`** - Core game logic, state management, and UI
- **`lib/scenarios.dart`** - Environmental scenario definitions and impact calculations
- **`lib/locations.dart`** - Geographic location data and mapping
- **`pubspec.yaml`** - Project dependencies and configuration

## Project Structure

```
lib/
├── main.dart           # Application entry point
├── game.dart           # Game page and core logic
├── scenarios.dart      # Environmental scenario library
├── locations.dart      # Geographic location types
├── splash.dart         # Splash screen
├── theme.dart          # UI theme configuration
├── painter.dart        # Custom animation painter
└── ...

assets/
├── images/
│   ├── chaos.png       # Game over visual
│   ├── peace.png       # Victory visual
│   └── portrait.png    # Character artwork
```

## Environmental Scenarios

The game features a diverse range of real-world environmental scenarios:

**Positive Impact (Temperature Reducing):**
- Recycling campaigns
- Forest conservation
- Solar energy implementation
- Coastal renewable energy projects
- Marine protected areas

**Negative Impact (Temperature Increasing):**
- Deforestation for agriculture
- Industrial emissions
- Mining activities
- Forest fires
- Urban sprawl

## Strategic Depth

Success requires balancing multiple systems:
- **Temperature vs. Sustainability** - Aggressive power use cools the planet faster but depletes resources
- **Probability Management** - Higher power levels increase success rates but accelerate sustainability loss
- **Geographic Diversity** - Each biome presents unique environmental challenges
- **Risk/Reward Decisions** - Choose between guaranteed minimal impact or high-risk, high-reward interventions

## Resources & References

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [OpenStreetMap](https://www.openstreetmap.org)

## License

This project is licensed under the **GNU Lesser General Public License v2.1** - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Feel free to fork the repository and submit pull requests for improvements, bug fixes, or new environmental scenarios.

---

*"With great power comes great responsibility. Will you save the world or watch it burn?"*
