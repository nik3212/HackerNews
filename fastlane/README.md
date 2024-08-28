fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios generate_new_certificates

```sh
[bundle exec] fastlane ios generate_new_certificates
```

Generate new certificates

### ios register

```sh
[bundle exec] fastlane ios register
```

Regester devices on apple portal

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Create a HackerNews Beta build for TestFlight

### ios production

```sh
[bundle exec] fastlane ios production
```

Create a HackerNews Production build for TestFlight

### ios test

```sh
[bundle exec] fastlane ios test
```

Run Unit Tests

### ios gym_params

```sh
[bundle exec] fastlane ios gym_params
```

Returns the parameters that should be used in any fastlane build

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
