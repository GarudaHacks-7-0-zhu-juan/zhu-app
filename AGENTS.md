# zhu_app Agent Guide

## Project

- Flutter application for Android and iOS only.
- Flutter SDK is pinned to `3.41.9` in `.fvmrc`.
- Use project-local workflows. Do not use globally installed `flutter` or `dart` directly.

## Commands

- Bootstrap dependencies: `make setup`
- Run locally: `make run DEVICE=<device-id>`
- List devices: `make devices`
- Format: `make format`
- Analyze: `make analyze`
- Test: `make test`
- Clean generated outputs: `make clean`

When a Make target does not cover a Flutter command, use `fvm flutter <command>`
or `fvm dart <command>`.

## Engineering Rules

- Follow `flutter_lints` and Effective Dart.
- Keep Dart soundly null-safe. Avoid `!` unless non-null is guaranteed by an
  adjacent invariant.
- Prefer immutable, declarative widgets; use `const` where valid.
- Keep `build` methods pure and inexpensive. Do not run I/O, network requests,
  or expensive computations from `build`.
- Compose small widgets rather than relying on large widget-returning helpers or
  inheritance hierarchies.
- Separate UI, domain logic, and data access as complexity warrants. Do not add
  layers or state-management packages before a concrete need exists.
- Use Flutter and Dart SDK features first. Explain and justify every new
  `pub.dev` dependency before adding it.
- Use meaningful names: `PascalCase` types, `camelCase` members, and
  `snake_case` file names.
- Handle expected asynchronous failures deliberately. Use `dart:developer` for
  diagnostic logging; do not use `print`.
- Design accessible interfaces: semantic labels for non-text controls, adequate
  contrast, and layouts that work with large text and narrow screens.
- Add or update focused tests for changed behavior. Prefer fakes over mocks.
- Before completing code changes, run format, analysis, and relevant tests.

## Flutter Skill

Load `.agents/skills/flutter-best-practices/SKILL.md` for Flutter or Dart
implementation, UI, architecture, dependency, performance, accessibility, or
test work.
