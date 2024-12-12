# SwiftUI-CSGO

**SwiftUI-CSGO** is an app built with **SwiftUI** that provides an overview of Counter-Strike: Global Offensive (CS:GO) data, including player statistics, maps, and weapon information. The project is an example of using modern SwiftUI techniques for building dynamic and engaging iOS interfaces.

## Features
- **Player Stats**: Display player performance data, including kills, deaths, and headshot percentages.
- **Map Information**: Explore detailed descriptions and strategies for popular CS:GO maps.
- **Weapon Details**: View information on weapons, including damage, recoil, and recommended usage.
- **Dynamic UI**: A fully responsive interface created with **SwiftUI**.

## Technologies Used
- **Swift**: The primary language used for development.
- **SwiftUI**: For declarative and dynamic interface creation.
- **Combine**: To manage state and data flow within the app.
- **JSON Parsing**: For handling external or local data related to CS:GO.
- **MVVM**: Architectural pattern to ensure clean and maintainable code.

## Requirements
- iOS 15.0 or later.
- Xcode 14 or later.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/dmaia17/SwiftUI-CSGO.git
   ```
2. Navigate to the project directory:
   ```bash
   cd SwiftUI-CSGO
   ```
3. Open the `.xcodeproj` or `.xcworkspace` file in Xcode:
   ```bash
   open SwiftUI-CSGO.xcodeproj
   ```
4. Connect a device or use the simulator and run the project by pressing **Cmd + R**.

## How to Use
1. Open the app.
2. Browse through the different sections (Player Stats, Maps, Weapons).
3. Select a specific item to view detailed information.
4. Use the interactive UI for exploring and comparing data.

## Project Structure
The project is organized as follows to adhere to **MVVM** best practices:

```
SwiftUI-CSGO/
├── Models/
├── ViewModels/
├── Views/
├── Services/
├── Assets/
└── Tests/
```
- **Models**: Represents the app's data structures.
- **ViewModels**: Contains the business logic and state management for each feature.
- **Views**: SwiftUI views and reusable UI components.
- **Services**: Handles data fetching and processing.
- **Assets**: Images, JSON files, and other static resources.
- **Tests**: Unit tests for validating the app's logic and functionality.

## Contribution
We welcome contributions to improve this project! To contribute:
1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b my-feature
   ```
3. Make your changes and commit:
   ```bash
   git commit -m "Add new feature"
   ```
4. Submit a pull request for review.

## Author
Created by [@dmaia17](https://github.com/dmaia17).
