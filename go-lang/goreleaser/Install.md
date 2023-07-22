# Installing

> NOTE: If you encounter any issues with the following installation instructions then please see [the official documentation][0] for the latest installation instructions as the following instructions may be out of date.

## MacOS

There are technically two ways to install GoReleaser using Homebrew. One uses a tap and the other does not. I prefer to use the tap method as it also supports installing the Pro version of GoReleaser and I'd like to have that option for when I inevitably upgrade to the Pro version. That said, I'll list both methods for posterity sake.

### Homebrew Tap

```bash
# OSS
brew install goreleaser/tap/goreleaser

# Pro
brew install goreleaser/tap/goreleaser-pro
```

### Homebrew Core

```bash
brew install goreleaser
```

## Linux

### Snapcraft

```bash
# OSS
sudo snap install --classic goreleaser
```

### apt

```bash
# OSS
echo 'deb [trusted=yes] https://repo.goreleaser.com/apt/ /' | sudo tee /etc/apt/sources.list.d/goreleaser.list
sudo apt update
sudo apt install goreleaser

# Pro
echo 'deb [trusted=yes] https://repo.goreleaser.com/apt/ /' | sudo tee /etc/apt/sources.list.d/goreleaser.list
sudo apt update
sudo apt install goreleaser-pro
```

### yum

```bash
# OSS
echo '[goreleaser]
name=GoReleaser
baseurl=https://repo.goreleaser.com/yum/
enabled=1
gpgcheck=0' | sudo tee /etc/yum.repos.d/goreleaser.repo
sudo yum install goreleaser

# Pro
echo '[goreleaser]
name=GoReleaser
baseurl=https://repo.goreleaser.com/yum/
enabled=1
gpgcheck=0' | sudo tee /etc/yum.repos.d/goreleaser.repo
sudo yum install goreleaser-pro
```

### deb/rpm

Download the `.deb`, `.rpm` or `.apk` packages from the [OSS releases page][1] (or [Pro releases page][2]) and install them with the appropriate tools.

## Windows

To install GoReleaser on Windows, you can use the scoop package manager or the [`go install` command](#go-install) (only supports OSS).

### Scoop

```powershell
# OSS
scoop bucket add goreleaser https://github.com/goreleaser/scoop-bucket.git
scoop install goreleaser

# Pro
scoop bucket add goreleaser https://github.com/goreleaser/scoop-bucket.git
scoop install goreleaser-pro
```

## `go install`

You can also install GoReleaser using the `go install` command but this only supports the OSS version of GoReleaser:

```bash
go install github.com/goreleaser/goreleaser@latest
```

[0]: https://goreleaser.com/install
[1]: https://github.com/goreleaser/goreleaser/releases
[2]: https://github.com/goreleaser/goreleaser-pro/releases
