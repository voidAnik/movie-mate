# Movie Mate

## Table of Contents
1. [Project Overview](#project-overview)
2. [Resources](#resources)
3. [Features](#features)
4. [App Screenshots](#app-screenshots)
5. [Technical Specifications](#technical-specifications)
    - [Architecture](#architecture)
    - [State Management](#state-management)
    - [Database](#database)
    - [Networking](#networking)
    - [Routing](#routing)
    - [Pagination](#pagination)
    - [Flavor Configuration](#flavor-configuration)
    - [Handling Data and Internet Connectivity](#handling-data-and-internet-connectivity)
6. [Installation](#installation)
7. [Running the App](#running-the-app)
    - [With Android Studio](#with-android-studio)
    - [From Command Line](#from-command-line)

## Project Overview
Movie Mate is a Flutter-based mobile application designed to integrate with the TMDB API to manage and display movie data. This application includes core features such as trending movies, movie search, detailed movie views, and favorites management, along with advanced functionalities like genre preferences and a map showing nearby theaters. It is optimized for both online and offline use, supports multiple languages, and follows clean code practices and modern architectural patterns.

## Resources
- **TMDB API**: Provides movie data. Base URL: `https://api.themoviedb.org/3`. API Key: `Your_API_Key`.
- **OpenStreetMap/FlutterMap**: Used for map integration and displaying nearby theaters. Chosen for its free availability.
- **Firestore**: Used for demo purposes alongside local cache for managing favorites and genre preferences.
- **Dio**: For network requests.
- **sqflite**: For local data storage.

## Features
### Core Functionality
- **Trending Movies**: Displays a list of trending movies on the home screen with title, year of release, genre, and thumbnail.
- **Upcoming Movies**: Shows a list of upcoming movies with similar details as the trending section, including title, year of release, genre, and thumbnail.
- **Search Functionality**: Includes a search bar to find movies by title, showing results with movie titles, release years, and poster thumbnails.
- **Movie Details**: Detailed view includes movie title, release year, genre, director, plot, full-size poster, Screenshots and a YouTube trailer. Also, you can share the link to others.
- **Favorites**: Users can mark movies as favorites. The app stores favorites locally for offline access and also stores in firestore and provides a screen to manage them.
- **Genre Preferences**: Users can select favorite genres and filter movies by these genres in the trending and upcoming sections. Genre preferences are stored locally & in firebase if user online.

### Map and Nearby Theaters
- **Map Integration**: Shows the user's current location and nearby movie theaters on a map. Markers display theater names, addresses, ratings, and distances from the user.
- **Map Provider**: OpenStreetMap/FlutterMap is used due to its free availability. Nearby theaters are fetched using OpenStreetMap's Nominatim API.

## App Screenshots
<p float="left">
  <img src="/assets/ss/1.jpg" width="200" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/2.jpg" width="200" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/3.jpg" width="200" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/4.jpg" width="200" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/5.jpg" width="200" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/6.jpg" width="200" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/7.jpg" width="200" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/8.jpg" width="200" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/9.jpg" width="200" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/10.jpg" width="200" />
</p>

## Technical Specifications
### Architecture
- **Clean Architecture**: Applied to ensure separation of concerns, scalability, maintainability, and testability. The architecture is divided into data, domain, and presentation layers.

### State Management
- **BLoC**: Used for managing the app's state, handling different states like loading, success, and error efficiently.

### Database
- **Local Storage**: `sqflite` is used for caching data, enabling offline access. The database includes tables for movies, favorites, and genre preferences.
- **Firestore**: Utilized for demo purposes to complement local caching for favorites and genre preferences.

### Networking
- **Dio**: Handles network requests with a retry mechanism. `cached_network_image` is used for efficient image loading and caching.

### Routing
- **go_router**: Manages navigation and routing within the app, providing a clear and concise setup for different screens and flows.

### Pagination
- **Infinite Scrolling**: Implemented for both trending and upcoming movies to handle large lists and enhance user experience.

### Flavor Configuration
- **Flavors**: Configured for development and production environments. Different build variants are used to test across various environments without affecting the production build.
  
### Dependency Injection
**GetIt**: GetIt is utilized for dependency injection, managing and providing instances of services and repositories throughout the app, which improves modularity and testability.

### Localization
**Language Support**: The app supports multiple languages using EasyLocalization, allowing users to switch between different languages based on their preferences or system settings.

### Handling Data and Internet Connectivity
- **Connectivity Check**: The app checks for internet connectivity and fetches data from the API using `Dio` or personalized data from firestore. When offline, data is retrieved from the local `sqflite` database.

## Installation
1. Clone the repository:
   ```terminal
   git clone https://github.com/voidAnik/tr-store-demo
   ```
3. Navigate to the project directory and install dependencies:
   ```terminal
   flutter pub get
   ```
   

## Running the App
### With Android Studio
- Open the project in Android Studio, where launch configurations for different flavors (**development** and **production**) are saved.
- Select the appropriate configuration and run the app.
- Also Select **Run All Tests** to run the tests.

### From Command Line
- For development flavor:
  ```terminal
  flutter run --flavor development -t lib/app/env/main_development.dart
  ```
  
- For production flavor:
  ```terminal
  flutter run --flavor production -t  lib/app/env/main_production.dart
  ```

- For test:
  ```terminal
  flutter test
  ```

- For Building Apk
    ```terminal
    flutter build apk --flavor development -t lib/app/env/main_development.dart
    ```
    ```terminal
    flutter build apk --flavor production -t  lib/app/env/main_production.dart
    ```
