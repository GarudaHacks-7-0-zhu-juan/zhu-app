---
name: flutter-best-practices
description: Guides Flutter and Dart changes in this Android/iOS application, including widgets, state, architecture, dependencies, performance, accessibility, and tests. Use when adding, editing, refactoring, or reviewing Dart or Flutter code, or when changing pubspec dependencies or Flutter UI behavior.
---

# Flutter Best Practices

## Project Workflow

1. Inspect relevant code, tests, `pubspec.yaml`, and `analysis_options.yaml`
   before choosing a pattern.
2. Use `make setup` when dependencies or the pinned FVM SDK need initialization.
3. Use `make format`, `make analyze`, and `make test` after changing Dart code.
4. Use `make devices` and `make run DEVICE=<device-id>` for local device runs.
5. Use `fvm flutter` or `fvm dart` only when no Make target exists.

## Implementation

- Keep widgets immutable. Prefer `StatelessWidget`; use state only when UI must
  change.
- Prefer `ValueNotifier` with `ValueListenableBuilder` for simple local state.
  Introduce a broader state solution only after identifying shared or complex
  app state.
- Pass dependencies through constructors. Keep presentation, domain behavior,
  and data access separated when a feature becomes complex enough to need it.
- Keep `build` pure and cheap. Start asynchronous work outside `build`, render
  explicit loading, error, and empty states, and preserve useful errors.
- Use small private widget classes to split complex layouts. Prefer composition
  over inheritance and over widget-returning helper methods.
- Use `const` constructors and widget instances where valid.
- Use `ListView.builder`, `GridView.builder`, or slivers for unbounded
  collections. Move CPU-heavy work off the UI isolate with `compute` when it
  would block interaction.
- Use `async`/`await` for one-shot work and streams for event sequences. Avoid
  force-unwrapping nullable values without a local invariant.
- Use `dart:developer` for diagnostics, never `print`.

## UI And Accessibility

- Use Material 3 and centralize visual tokens in `ThemeData` or a
  `ThemeExtension` when custom tokens are needed.
- Build responsive layouts with constraints. Test narrow widths and large text
  scaling; avoid fixed dimensions that create overflow.
- Give non-text controls useful semantic labels. Maintain at least 4.5:1 text
  contrast and do not rely on color alone to convey state.
- For network images, provide loading and error UI.

## Dependencies And Data

- Prefer Flutter and Dart SDK APIs. Before adding a `pub.dev` package, explain
  why SDK features or existing dependencies do not meet the requirement.
- Add dependencies with `fvm flutter pub add <package>` and development
  dependencies with `fvm flutter pub add dev:<package>`.
- Use `json_serializable` only when model volume or stability warrants code
  generation. When used, run `fvm dart run build_runner build
  --delete-conflicting-outputs`.

## Tests And Review

- Add focused unit tests for domain/data behavior and widget tests for visible
  interactions. Structure tests as Arrange-Act-Assert.
- Prefer fakes and stubs over mocks. Test meaningful behavior, not framework
  implementation details.
- During review, check for lifecycle safety, stale async updates, unnecessary
  rebuild work, missing error states, inaccessible controls, and absent tests.
