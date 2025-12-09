# 🎨 DrawWithMe

## 📷 Screenshots

| Camera View | Tracing Mode |
|-------------|--------------|
| *Camera preview with balance indicators* | *Overlay image for tracing* |

**DrawWithMe** is a modern Flutter application designed to help artists and hobbyists trace images onto paper using their phone's camera as a lightbox. The app overlays any image from your gallery onto the live camera feed, allowing you to trace contours with precision.

The project is built following **Clean Architecture** principles using **Provider** for scalable, testable state management.

---

## ✨ Features

### 📹 Live Camera Preview
Real-time camera feed as the base layer for tracing.

### 🖼️ Image Overlay
Load any image from gallery and overlay it on the camera preview.

### 🔍 Dual Zoom Control
- **Camera Zoom**: Adjust the camera to get a 1:1 real-size view
- **Image Zoom**: Scale the overlay image independently (0.5x - 3x)

### 🎚️ Opacity Control
Adjust overlay transparency to see both the image and paper underneath.

### 📐 Precision Leveling
- **Horizontal Balance Bar**: Shows device tilt left/right
- **Vertical Balance Bar**: Shows device tilt forward/backward
- **Real-time sensor values**: Roll and pitch in degrees
- **Level Indicator**: Green "LEVEL" badge when perfectly flat

### 🔒 Lock Controls
Lock opacity, zoom, and position to prevent accidental changes while drawing.

### 🎯 Drag & Position
Pan and position the overlay image precisely where needed.

---

## 🏗️ Tech Stack

| Category | Technology | Purpose |
|----------|------------|---------|
| Language | Dart / Flutter | Cross-platform mobile app |
| Architecture | Clean Architecture | Scalability & testability |
| State Management | Provider | Robust & compile-time safe |
| Camera | camera | Live camera preview |
| Sensors | sensors_plus | Gyroscope & accelerometer |
| Image Selection | image_picker | Gallery access |
| Permissions | permission_handler | Camera permissions |

---

## 🧩 Architecture

```
lib/
├── features/
│   └── ar_viewer/
│       ├── adapters/
│       │   └── ar_viewer_presenter.dart
│       ├── application/
│       │   ├── ports/
│       │   │   └── sensor_service_port.dart
│       │   └── usecases/
│       │       └── update_orientation.dart
│       ├── domain/
│       │   └── orientation_data.dart
│       └── infrastructure/
│           ├── services/
│           │   └── sensor_service_impl.dart
│           └── widgets/
│               └── ar_viewer_screen.dart
├── widgets/
│   ├── control_panel.dart
│   ├── horizontal_balance_bar.dart
│   └── vertical_balance_bar.dart
├── injections.dart
└── main.dart
```

### Layer Responsibilities

#### Domain
- Contains pure business logic
- Defines:
  - `OrientationData` (sensor data model)
  - `SensorServicePort` (abstract interface)

#### Application
- Use cases orchestrating business logic
- `UpdateOrientation` manages sensor streaming

#### Infrastructure
- Implements sensor service using `sensors_plus`
- UI widgets and screens

#### Adapters
- `ARViewerPresenter` - state management with ChangeNotifier
- Bridges domain logic with UI

---

## 🔑 Setup & Installation

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/yourusername/drawwithme.git
cd drawwithme
```

### 2️⃣ Install Dependencies
```bash
flutter pub get
```

### 3️⃣ Android Setup
Add camera permission to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" />
<uses-feature android:name="android.hardware.camera.autofocus" />
```

### 4️⃣ iOS Setup
Add to `ios/Runner/Info.plist`:
```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required for tracing</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Photo library access is required to select images</string>
```

### 5️⃣ Run the App
```bash
flutter run
```

> ⚠️ **Note**: Run on a physical device. Camera and sensors don't work on emulators.

---

## 📝 Usage

1. **Open the app** - Camera preview starts automatically
2. **Tap the gallery icon** - Select an image to trace
3. **Adjust camera zoom** (left slider) - Get a 1:1 real-size view
4. **Adjust opacity** (bottom slider) - See paper through the image
5. **Level your device** - Use the balance bars to keep phone flat
6. **Drag the image** - Position it exactly where needed
7. **Lock controls** - Tap the lock icon to prevent accidental changes
8. **Start tracing!** - Draw the contours on your paper

---

## 🎯 UI Layout

```
┌─────────────────────────────────────┐
│      [Horizontal Balance Bar]       │  ← Top
│           ✓ LEVEL                   │
├────┬───────────────────────────┬────┤
│    │                           │    │
│ C  │                           │ V  │
│ A  │    CAMERA PREVIEW         │ E  │
│ M  │         +                 │ R  │
│    │    IMAGE OVERLAY          │ T  │
│ Z  │                           │    │
│ O  │                           │ B  │
│ O  │                           │ A  │
│ M  │                           │ R  │
│    │                           │    │
├────┴───────────────────────────┴────┤
│  [📷] [🔒] [Opacity] [Zoom] [↻]    │  ← Bottom
└─────────────────────────────────────┘
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  provider: ^6.1.2
  camera: ^0.11.0+2
  sensors_plus: ^6.1.1
  image_picker: ^1.1.2
  permission_handler: ^11.3.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

---

## 🎨 Use Cases

- **Sketching**: Trace photos onto paper
- **Calligraphy**: Copy lettering with precision
- **Technical Drawing**: Transfer diagrams accurately
- **Art Projects**: Outline complex images
- **Learning**: Practice drawing by tracing

---

## 🤝 Contributing

Pull requests are welcome!

Before submitting, please run:
```bash
dart format .
flutter analyze
```

---

## 🛡️ License

This project is licensed under the **MIT License**.

---

## 👨‍💻 Author

Made with ❤️ by Mohamed
