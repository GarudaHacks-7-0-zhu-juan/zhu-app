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

Flutter SDK version is pinned in `.fvmrc`.
