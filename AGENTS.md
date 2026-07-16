# zhu_app Agent Guide

## Project

- Flutter application for Android and iOS only.
- Flutter SDK is pinned to `3.41.9` in `.fvmrc`.
- Android minimum SDK is 23 because refresh tokens use `flutter_secure_storage`.
- Use project-local workflows. Do not use globally installed `flutter` or `dart` directly.

## Commands

- Bootstrap dependencies: `make setup`
- Run locally: `make run DEVICE=<device-id>`
- List devices: `make devices`
- Format: `make format`
- Generate Riverpod and model source: `make generate`
- Analyze: `make analyze`
- Test: `make test`
- Clean generated outputs: `make clean`

When a Make target does not cover a Flutter command, use `fvm flutter <command>`
or `fvm dart <command>`.

For generated-code changes, run `make generate`, then `make format`, then
`make analyze`.

## Application Structure

Use feature-first organization:

```text
lib/
  app/                 # Bootstrap, config, router
  core/                # Cross-feature network and platform primitives
  design_system/       # Shared theme tokens and visual components
  features/
    <feature>/
      data/            # Data sources and repository implementations
      domain/          # Immutable models, contracts, and failures
      controller/      # Riverpod controllers/providers
      presentation/    # Pages and feature-specific widgets
```

- Keep generic utilities next to their consumer. Do not create catch-all
  `utils/`, `widgets/`, or `hooks/` folders.
- Do not add Flutter Hooks unless a concrete feature requires it.
- Use Riverpod for state management and dependency injection. Prefer generated
  providers/controllers through `riverpod_annotation`.
- Use `go_router` for application navigation and route access control.
- Use Dio for network requests. Keep generic Dio setup in `core/network/`.
  Auth-owned clients add bearer tokens, coordinate a single token refresh, and
  retry a protected request once; repositories must not duplicate this logic.
- Use Freezed and JSON serialization for immutable models, DTOs, states, and
  failure unions.
- Commit generated `.g.dart` and `.freezed.dart` files. Regenerate them after
  changing annotated providers or models.
- Store refresh tokens only in `flutter_secure_storage`; keep access tokens in
  memory. Never log credentials or token values.

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
