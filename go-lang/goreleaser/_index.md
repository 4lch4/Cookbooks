# GoReleaser

[GoReleaser][0] is my preferred solution for building & releasing Go projects as it is a release automation tool for Go projects. It simplifies the build, release and publish steps while making sure everything is in place.

## Free or Pro?

GoReleaser is free to use but also has [a Pro version][1] that I would love to use. Not just because it has a number of _extremely_ handy features, but because I want to support the project and the people behind it because of how much it's helped me.

## Installation

To install GoReleaser you can refer to either [my notes][2] or the [official installation instructions][3].

## Usage

Once you have it installed you can run the following commands in the root of a Go project to perform a simple build and release:

```bash
# Create an initial .goreleaser.yaml config file.
goreleaser init

# Run a "local-only" release to test the config.
goreleaser release --snapshot --clean
```

## Configuration & Customization

> GoReleaser can be customized by tweaking a .goreleaser.yaml file.
>
> You can generate an example config by running goreleaser init or start from scratch.
>
> You can also check if your config is valid by running goreleaser check, which will tell you if are using deprecated or invalid options.







[0]: https://goreleaser.com
[1]: https://goreleaser.com/pro
[2]: ./Install.md
[3]: https://goreleaser.com/install
