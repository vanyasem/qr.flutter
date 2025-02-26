QR.Widget is a Flutter library for simple and fast QR code rendering via a Widget or custom painter.

This is a renamed fork of [QR.Flutter](https://github.com/theyakka/qr.flutter) made mainly by [lukef](https://github.com/lukef) working for [The Yakka](https://theyakka.com/) company. You can take a look at the AUTHORS file to find a full list of contributors.

The original repo is maintained poorly, and lacks proper support. You can report issues or ask for new features directly on my fork's GitHub page (the one you're on right now). I will do my best to resolve them in a timely manner.

#### Migraton from `qr.flutter: 4.0.0`:

1) Update your `pubspec.yaml`: replace `qr_flutter: ^4.0.0` with `qr_widget: ^4.1.0`

2) Change `import 'package:qr_flutter/qr_flutter.dart';` to `import 'package:qr_widget/qr_widget.dart';` everywhere in the project.

You can do so by pressing **Ctrl (Cmd) + Shift + R**, which will open the "**Replace in Files**" window in Android Studio and/or VS Code.

<img width="409" alt="Screenshot 2023-05-08 at 14 09 33" src="https://user-images.githubusercontent.com/13350458/236808964-4caf311d-0ec8-4ce3-83a1-52f8cde0d328.png">

Then press "**Replace All**".

3) `QrImage` was renamed to `QrImageView` to prevent collisions with the `qr` library. You can use "**Replace in Files**" to update your code accordingly.

# Features
- Null safety
- Built on [QR - Dart](https://github.com/kevmoo/qr.dart)
- Automatic QR code version/type detection or manual entry
- Supports QR code versions 1 - 40
- Error correction / redundancy
- Configurable output size, padding, background and foreground colors
- Supports image overlays
- Export to image data to save to file or use in memory
- No internet connection required

# Installing

You should add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  qr_widget: ^4.1.0
```

**Note**: If you're using the Flutter `master` channel, if you encounter build issues, or want to try the latest and greatest then you should use the `master` branch and not a specific release version. To do so, use the following configuration in your `pubspec.yaml`:
 
```yaml
dependencies:
  qr_widget:
    git:
      url: https://github.com/vanyasem/qr.widget.git
```

Keep in mind the `master` branch could be unstable.

After adding the dependency to your `pubspec.yaml` you can run: `flutter packages get` or update your packages using
your IDE.

# Getting started
To start, import the dependency in your code:

```dart
import 'package:qr_widget/qr_widget.dart';
```

Next, to render a basic QR code you can use the following code (or something like it):

```dart
QrImageView(
  data: '1234567890',
  version: QrVersions.auto,
  size: 200.0,
),
```

Depending on your data requirements you may want to tweak the QR code output. The following options are available:

| Property                  | Type                 | Description                                                                                                                                                                                         |
|---------------------------|----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `version`                 | int                  | `QrVersions.auto` or a value between 1 and 40. See http://www.qrcode.com/en/about/version.html for limitations and details.                                                                         |
| `errorCorrectionLevel`    | int                  | A value defined on `QrErrorCorrectLevel`. e.g.: `QrErrorCorrectLevel.L`.                                                                                                                            |
| `size`                    | double               | The (square) size of the image. If not given, will auto size using shortest size constraint.                                                                                                        |
| `padding`                 | EdgeInsets           | Padding surrounding the QR code data.                                                                                                                                                               |
| `backgroundColor`         | Color                | The background color (default is none).                                                                                                                                                             |
| `eyeStyle`                | QrEyeStyle           | Configures the QR code eyes' (corners') shape and color.                                                                                                                                            |
| `dataModuleStyle`         | QrDataModuleStyle    | Configures the shape and the color of the dots.                                                                                                                                                     |
| `gapless`                 | bool                 | Adds an extra pixel in size to prevent gaps (default is true).                                                                                                                                      |
| `errorStateBuilder`       | QrErrorBuilder       | Allows you to show an error state `Widget` in the event there is an error rendering the QR code (e.g.: version is too low, input is too long, etc).                                                 |
| `constrainErrorBounds`    | bool                 | If true, the error `Widget` will be constrained to the square that the QR code was going to be drawn in. If false, the error state `Widget` will grow/shrink to whatever size it needs.             |
| `embeddedImage`           | ImageProvider        | An `ImageProvider` that defines an image to be overlaid in the center of the QR code.                                                                                                               |
| `embeddedImageStyle`      | QrEmbeddedImageStyle | Properties to style the embedded image.                                                                                                                                                             |
| `embeddedImageEmitsError` | bool                 | If true, any failure to load the embedded image will trigger the `errorStateBuilder` or render an empty `Container`. If false, the QR code will be rendered and the embedded image will be ignored. |
| `semanticsLabel`          | String               | `semanticsLabel` will be used by screen readers to describe the content of the QR code.                                                                                                             |

# Examples

There is a simple, working, example Flutter app in the `/example` directory. You can use it to play with all
the options. 

Also, the following examples give you a quick overview on how to use the library.

A basic QR code will look something like:

```dart
QrImageView(
  data: 'This is a simple QR code',
  version: QrVersions.auto,
  size: 320,
  gapless: false,
)
```

A QR code with an image (from your application's assets) will look like:

```dart
QrImageView(
  data: 'This QR code has an embedded image as well',
  version: QrVersions.auto,
  size: 320,
  gapless: false,
  embeddedImage: AssetImage('assets/images/my_embedded_image.png'),
  embeddedImageStyle: QrEmbeddedImageStyle(
    size: Size(80, 80),
  ),
)
```

To show an error state in the event that the QR code can't be validated:

```dart
QrImageView(
  data: 'This QR code will show the error state instead',
  version: 1,
  size: 320,
  gapless: false,
  errorStateBuilder: (cxt, err) {
    return Container(
      child: Center(
        child: Text(
          'Uh oh! Something went wrong...',
          textAlign: TextAlign.center,
        ),
      ),
    );
  },
)
```

# Outro
## Credits
Thanks to Kevin Moore for his awesome [QR - Dart](https://github.com/kevmoo/qr.dart) library. It's the core of this library.

For author/contributor information, see the `AUTHORS` file.

## License

QR.Widget is released under a BSD-3 license. See `LICENSE` for details.
