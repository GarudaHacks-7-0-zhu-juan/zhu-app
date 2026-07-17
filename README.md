# ProtectMe

ProtectMe is an Android and iOS safety companion app. It lets people manage
guardian and guardee relationships, share location-driven safety status, enable
protection responses for risks such as high-risk areas and disasters, and
respond to liveness checks.

## Features

- Email-based registration and sign-in with securely stored refresh tokens.
- Guardian and guardee relationship management.
- Location reporting while authenticated, with high-risk-area status updates.
- Configurable Protect Me responses for supported risk types.
- Guardian risk alerts and liveness-check responses.
- Android Firebase Cloud Messaging support, including foreground local alerts,
  notification actions, and safe route handling.
- Runtime permission flow for required device access.

## Tech stack

- Flutter 3.41.9, pinned with FVM.
- Riverpod for state management and dependency injection.
- GoRouter for authentication- and permission-aware navigation.
- Dio for backend requests and authenticated request retry.
- Firebase Cloud Messaging and `flutter_local_notifications` for Android push.
- `flutter_secure_storage` for refresh-token storage.
- Freezed, JSON serialization, and Riverpod generator for immutable models and
  generated providers.
- `shadcn_ui` design system with bundled IBM Plex Sans and IBM Plex Mono fonts.

## Requirements

- [FVM](https://fvm.app/) installed and available on `PATH`.
- Android Studio and an Android device or emulator for Android development.
- Xcode and an iOS simulator or device for iOS development on macOS.
- Firebase configuration for Android push notifications. The project includes
  generated Firebase options; use a Firebase project you are authorized to use.

## Setup

Install the pinned Flutter SDK and package dependencies:

```sh
make setup
```

Configure backend access in `assets/config/app_config.yaml`:

```yaml
api:
  base_url: https://your-api-host/api
```

`base_url` must be an absolute HTTPS URL ending in `/api`. Do not commit
environment-specific credentials or secret values.

List connected devices, then run the app:

```sh
make devices
make run DEVICE=<device-id>
```

Omit `DEVICE` to let Flutter choose an available target:

```sh
make run
```

## Development commands

| Command | Purpose |
| --- | --- |
| `make setup` | Install pinned Flutter SDK and dependencies. |
| `make run DEVICE=<id>` | Run on a selected device. |
| `make devices` | List available devices. |
| `make doctor` | Show Flutter environment diagnostics. |
| `make format` | Format Dart source files. |
| `make analyze` | Run static analysis. |
| `make test` | Run test suite. |
| `make generate` | Regenerate Riverpod and model sources. |
| `make release-apk` | Build signed Android release APK. |
| `make clean` | Remove build outputs and restore dependencies. |

After modifying Freezed models, JSON-serializable types, or annotated Riverpod
providers, run:

```sh
make generate
make format
make analyze
make test
```

## Architecture

The codebase follows a feature-first structure:

```text
lib/
  app/             App startup, configuration, and routing
  core/            Cross-feature networking and diagnostics
  design_system/   Theme and visual tokens
  features/
    auth/          Session, credentials, and authenticated HTTP client
    guardian_notifications/ Guardian alert history
    locations/     Location collection and reporting lifecycle
    notifications/ Android FCM and local notification coordination
    permissions/   Runtime permission requirements
    profile/       Current-user profile
    relationships/ Guardian and guardee management
    safety/        Protect Me risk status and controls
```

`AppConfig` loads the API base URL from the bundled YAML file at launch. Routing
requires device permissions before access to app routes and redirects users
between loading, authentication, and authenticated workspace screens according
to session state.

Location tracking and notification registration begin only for authenticated
sessions. Location reports are throttled to one attempt every 20 seconds.
Android notification data is treated as untrusted: routes, risk types, and
guardee identifiers are validated before being acted on.

## Push notifications

Push notification support is Android-only. During an authenticated session, the
app requests notification permission, registers its FCM token with the backend,
listens for token refreshes, and displays foreground notifications locally.

Liveness-check alerts expose `Yes, I'm safe` and `No, I'm not safe` actions.
Guardian risk alerts can open the relevant guardee detail screen. Logout stops
location tracking and push listeners before clearing session state.

## Android release APK

Release APKs use a private signing key. Generate it once on the build machine:

```sh
keytool -genkeypair -v \
  -keystore android/upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
cp android/key.properties.example android/key.properties
```

Update `android/key.properties` with keystore passwords. Keep both
`android/key.properties` and `android/upload-keystore.jks` private and backed
up; the keystore is required to publish updates over an existing installation.

Build the signed universal APK:

```sh
make release-apk
```

Output is written to `dist/ProtectMe-<version>-release.apk`. Installing it on
another Android device may require enabling installation from unknown sources.

## Design system

The UI follows the Architectural Schematic Mobile design language. It uses a
light, technical visual style with structural lines, IBM Plex typography,
four-pixel spacing increments, high-contrast status states, and accessible
48x48 logical-pixel touch targets. See [DESIGN.md](DESIGN.md) for design tokens
and component rules.

## Testing

Tests cover app networking, authentication, permission checks, navigation,
location and notification coordination, relationships, profile, safety status,
and key feature screens. Run all tests with:

```sh
make test
```
