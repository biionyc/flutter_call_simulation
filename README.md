# Call Simulation Flutter App

This is a Flutter-based application designed to simulate call functionalities.

## Getting Started

This project is a starting point for a Flutter application. Below are the steps to get started and run the app on your local machine.

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (comes with Flutter)
- Android Studio or VS Code with Flutter and Dart plugins
- An Android/iOS device or emulator

### Steps to Run the App

1. **Clone the Repository**:  
   Clone this repository to your local machine.

2. **Install Dependencies**:  
   Navigate to the project directory and install the required dependencies.
   Run "flutter pub get"

3. **Run the App**:  
   To run the app, connect a physical device or start an emulator, and run the app.

### Summary of Implementation

This application simulates call functionalities, allowing users to interact with a user interface that mimics real-time call scenarios. The key features implemented are:

- **Home Screen**: There are 3 buttons - "Start Video Call", "Start Audio Call" and "Simulate Incoming call".
- **Call Simulation**: A dialog for the incoming call with option to accept it as a Voice Call or Video Call, it also has option to Reject the call.
- **State Management**: User Provider and ChangeNotifier to implement basic state management for the call states - idle, ringing, inCall, callEnded.
- **Call Screen**: Based on the type of call user will have either a simple user placeholder with caller name for Audio Call or a caller's image placeholder with a floating camera view of the user in the right bottom of the screen. User will have the option to end call or mute himself. User can also swith between front and back cameras in Video Call.
