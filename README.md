# average
[![Build Status](https://travis-ci.org/AnAverageHuman/average.svg?branch=master)](https://travis-ci.org/AnAverageHuman/average)

Personal overlay for Gentoo packages.

## Installation/Usage

As this is more or less a personal repository, I force push often. In the event
that `emerge` or `layman` refuses to sync, either remove and re-add the
repository, or manually enter the directory and run as the appropriate user:

```sh
git fetch --all && git reset --hard origin/master
```

### eselect-repository

See [the wiki](https://wiki.gentoo.org/wiki/Eselect/Repository) for more information.

```sh
emerge --ask app-eselect/eselect-repository
eselect repository add average git https://github.com/AnAverageHuman/average.git
emerge --sync
```

### layman

```sh
emerge --ask app-portage/layman
layman -of https://raw.githubusercontent.com/AnAverageHuman/average/master/repositories.xml -a average
layman -s average
```

## Packages

### dev-embedded

**arduino-libs**: Forked from [alexxy's overlay](https://cgit.gentoo.org/dev/alexxy.git).
Adds libraries and hardware as specified in the [ADK documentation](https://developer.android.com/adk/adk.html).

### dev-libs

**beignet**: Same as ebuild in main repository.
Includes [patch for compiling with GCC 6](https://bugzilla.freedesktop.org/show_bug.cgi?id=101662#c3).

### dev-python

**gmusicapi**: Forked from [seadep](https://github.com/Cogitri/gentoo-overlay-seadep).
Updated to reflect changes in upstream's requirements.txt.

### media-gfx

**processing-bin**: Forked from [betagarden](https://cgit.gentoo.org/proj/betagarden.git/).
Version bumped more often.

### media-plugins

**ashuffle**: An ebuild for [joshkunz's ashuffle](https://github.com/joshkunz/ashuffle).

**mopidy-gmusic**: Forked from the [spike overlay](https://github.com/Spike-Pentesting/spike-overlay).
Version bumped more often.

### www-misc

**profile-sync-daemon**: Forked from [jorgicio's overlay](https://github.com/jorgicio/jorgicio-gentoo).
Includes a fix for the ["bad substitution" error](https://github.com/graysky2/profile-sync-daemon/issues/182).
