# zhu_app

Flutter app targeting Android and iOS, managed with FVM.

## Local setup

Install FVM, then run:

```sh
make setup
make devices
make run DEVICE=<device-id>
```

Use `make run` without `DEVICE` to let Flutter select an available device.

Other useful commands:

```sh
make analyze
make test
make format
make clean
```

## Build a shareable Android APK

The release APK is signed with a private release key. Set it up once on the
machine that builds APKs:

```sh
keytool -genkeypair -v \
  -keystore android/upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
cp android/key.properties.example android/key.properties
```

Edit `android/key.properties` with the passwords from `keytool`. Keep both
`android/key.properties` and `android/upload-keystore.jks` private and backed
up. The keystore is required to publish updates over an existing installation.

Build the APK:

```sh
make release-apk
```

The script validates signing configuration, builds an optimized universal APK,
and writes it to `dist/ProtectMe-<version>-release.apk`. Share that APK file
with your friend. Android may require enabling installation from unknown
sources on the receiving device.

Flutter SDK version is pinned in `.fvmrc`.
