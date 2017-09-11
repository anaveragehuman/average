# gen2

Personal overlay for Gentoo packages.

## Packages

### app-admin

**sysklogd**: Forked from main repository.
Added `app-admin/logrotate` as a runtime dependency if *logrotate* is enabled.

### dev-embedded

**arduino-libs**: Forked from [alexxy's overlay](https://cgit.gentoo.org/dev/alexxy.git).
Adds libraries and hardware as specified in the [ADK documentation](https://developer.android.com/adk/adk.html).

### dev-libs

**beignet**: Same as ebuild in main repository.
Includes [patch for compiling with GCC 6](https://bugzilla.freedesktop.org/show_bug.cgi?id=101662#c3).

### media-gfx

**processing-bin**: Forked from [betagarden](https://cgit.gentoo.org/proj/betagarden.git/).
Version bumped more often.

### media-plugins

**mopidy-gmusic**: Forked from the [spike overlay](https://github.com/Spike-Pentesting/spike-overlay).
Version bumped more often.

### media-sound

**google-play-music-desktop-player-bin**: Forked from [zyrenth's overlay](https://github.com/kabili207/zyrenth-overlay).
Version bumped more often.

### www-misc

**profile-sync-daemon**: Forked from [jorgicio's overlay](https://github.com/jorgicio/jorgicio-gentoo).
Includes a fix for the ["bad substitution" error](https://github.com/graysky2/profile-sync-daemon/issues/182).
