# Frosted UI

A collection of beautiful frosted glass UI components for Flutter applications. This package provides widgets with a modern blurred glass effect, perfect for creating sleek and contemporary user interfaces.

## Demo Example

Un exemple complet est disponible dans le dossier `example`. Pour l'exécuter :

```bash
cd example
flutter run
```

## Features

- **FrostedAppBar**: A customizable app bar with a frosted glass effect
- **FrostedBottomNavigationBar**: A stylish bottom navigation bar with a blurred background
- **FrostedBottomSheet**: An elegant bottom sheet with glass-like transparency
- **FrostedScaffold**: A scaffold with built-in background blur capabilities
- **FrostedSliverAppBar**: A sliver app bar with parallax and frosted glass effects for scrollable interfaces

## Getting Started

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  frosted_ui:
    path: ../frosted_ui  # For local development
```

Import the package in your Dart code:

```dart
import 'package:frosted_ui/frosted_ui.dart';
```

## Usage

### FrostedAppBar

```dart
Scaffold(
  extendBodyBehindAppBar: true,  // Important for the blur effect
  appBar: FrostedAppBar(
    title: 'My App',
    showBackButton: true,
    blurStrength: 7,
  ),
  // ...
)
```

### FrostedBottomNavigationBar

```dart
Scaffold(
  // ...
  bottomNavigationBar: FrostedBottomNavigationBar(
    currentIndex: _selectedIndex,
    onTap: (index) => setState(() => _selectedIndex = index),
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      // Add more items
    ],
  ),
)
```

### FrostedBottomSheet

```dart
FrostedBottomSheet.show(
  context: context,
  title: 'Add Item',
  child: Column(
    children: [
      // Your bottom sheet content
    ],
  ),
);
```

### FrostedScaffold

```dart
FrostedScaffold(
  appBar: FrostedAppBar(
    title: 'My App',
  ),
  backgroundImage: DecorationImage(
    image: NetworkImage('https://example.com/background.jpg'),
    fit: BoxFit.cover,
  ),
  backgroundBlurStrength: 5.0, // Adjust blur strength as needed
  child: Center(
    child: Text('Content with blurred background'),
  ),
  bottomNavigationBar: FrostedBottomNavigationBar(
    currentIndex: 0,
    onTap: (index) {
      // Handle navigation
    },
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    ],
  ),
)
```

### FrostedSliverAppBar

```dart
CustomScrollView(
  slivers: [
    FrostedSliverAppBar(
      pinned: true,
      expandedHeight: 200,
      blurStrength: 7,
      title: 'Scrollable Content',
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          'https://example.com/background.jpg',
          fit: BoxFit.cover,
        ),
        collapseMode: CollapseMode.parallax,
      ),
    ),
    // Other slivers
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(
          title: Text('Item $index'),
        ),
        childCount: 50,
      ),
    ),
  ],
)
```
