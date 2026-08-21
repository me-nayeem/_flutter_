# Text, Image, and Icon

`Text`, `Image`, and `Icon` are core display widgets. They present the content users read, recognize, and scan throughout an application.

## Learning Goals

- Display and style text.
- Use Material icons accessibly.
- Load local and network images with appropriate states.

## Text

Use `Text` for a string of text. Prefer the app theme for consistent typography instead of applying a custom style everywhere.

```dart
Text(
  'Welcome back',
  style: Theme.of(context).textTheme.headlineSmall,
)
```

For a local one-line label that never changes, use `const`:

```dart
const Text('Save')
```

Useful properties include `maxLines`, `overflow`, `textAlign`, and `semanticsLabel`.

```dart
const Text(
  'A long title that may not fit on one line',
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
)
```

## Icon

Material icons are supplied through the `Icons` class.

```dart
const Icon(
  Icons.favorite_border,
  size: 28,
  semanticLabel: 'Add to favorites',
)
```

Use an icon-only control only when the symbol is familiar. Put it inside `IconButton` for interaction, and give it a tooltip.

```dart
IconButton(
  tooltip: 'Open settings',
  onPressed: () {},
  icon: const Icon(Icons.settings),
)
```

`uses-material-design: true` in `pubspec.yaml` enables the built-in Material icon font.

## Local Asset Images

Declare assets in `pubspec.yaml` first:

```yaml
flutter:
  assets:
    - assets/images/
```

Then load an image by its project-relative path.

```dart
Image.asset(
  'assets/images/profile.png',
  width: 120,
  height: 120,
  fit: BoxFit.cover,
)
```

`BoxFit.cover` fills the available box while preserving the image's aspect ratio; parts of the image may be cropped.

## Network Images

Use `Image.network` for remote images. Always provide a loading and error state because the request can be slow or fail.

```dart
Image.network(
  'https://images.example.com/profile.jpg',
  width: 120,
  height: 120,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return const SizedBox(
      width: 120,
      height: 120,
      child: Center(child: CircularProgressIndicator()),
    );
  },
  errorBuilder: (context, error, stackTrace) {
    return const SizedBox(
      width: 120,
      height: 120,
      child: Icon(Icons.broken_image),
    );
  },
)
```

## A Small Profile Header

```dart
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 44,
          child: Icon(Icons.person, size: 44),
        ),
        SizedBox(height: 12),
        Text('Nayeem'),
        Text('Flutter learner'),
      ],
    );
  }
}
```

This combines familiar widgets into a reusable UI section.

## Common Mistakes

- **Forgetting to declare local assets:** `Image.asset` cannot load an undeclared path.
- **Ignoring image dimensions:** unbounded images can cause layout problems; provide constraints when appropriate.
- **Using text characters as icons:** use `Icon` for consistent sizing, color, accessibility, and platform rendering.
- **Ignoring network errors:** remote images can fail, so provide a fallback UI.

## Key Takeaways

- `Text` displays styled strings; use the theme for consistency.
- `Icon` displays a symbol; use `IconButton` for tappable icons.
- `Image.asset` loads bundled files, while `Image.network` loads remote files.
- Give images sensible constraints and error states.

## Practice

1. Create a profile header with an icon, name, and subtitle.
2. Add a local image asset and display it with `BoxFit.cover`.
3. Add a network image with loading and error builders.

## Further Reading

- [Flutter user interface guide](https://docs.flutter.dev/ui)
- [Text API reference](https://api.flutter.dev/flutter/widgets/Text-class.html)
- [Image API reference](https://api.flutter.dev/flutter/widgets/Image-class.html)
