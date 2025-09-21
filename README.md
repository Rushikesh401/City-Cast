# CityCast Weather App

CityCast is a clean, modern iOS weather application built as a technical assignment for Quin. It allows users to search for cities, view live weather data, and maintain a persistent list of saved locations.

---

## Features

* **City Search**: Search for any city in the world using the GeoDB Cities API.
* **Live Weather Data**: View current temperature and weather conditions from the OpenWeatherMap API.
* **Recent Searches**: The app automatically saves your last 10 search terms for quick access.
* **Saved Cities**: Save your favorite cities for quick access. All saved cities are stored persistently using Core Data.
* **Offline Support**: View the last known weather data for your saved cities even without an internet connection.
* **Current Location Map**: View your current location on a map directly on the home screen.
* **Polished UI**: A clean, responsive, and user-friendly interface with automatic keyboard handling.

---

## Setup Instructions

To build and run this project, you will need API keys for both GeoDB Cities and OpenWeatherMap.

1.  **Clone the Repository**
    ```bash
    git clone https://github.com/Rushikesh401/City-Cast.git
    ```

2.  **Configure API Keys**
    * In the project's root directory, find the `Keys.xcconfig.example` file.
    * Make a copy of this file and rename the copy to `Keys.xcconfig`.
    * Open the new `Keys.xcconfig` file and replace the placeholder text with your actual API keys.

3.  **Open in Xcode**
    * Open the `CityCast.xcodeproj` file in Xcode.
    * Select your target device or simulator.
    * Build and run the project (Cmd + R).

---

## Technical Details

* **Architecture**: MVVM (Model-View-ViewModel)
* **Language**: Swift
* **UI Framework**: SwiftUI
* **Networking**: Native `URLSession` with modern `async/await`.
* **Persistence**:
    * **UserDefaults**: For storing simple search history.
    * **Core Data**: For robustly storing the list of saved cities and their cached weather data.
* **Dependency Management**: Swift Package Manager (SPM)
* **API Key Management**: Securely managed using `.xcconfig` files to keep secrets out of source code.
