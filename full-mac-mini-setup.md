# Full Mac Mini Server Setup Process

There are some things in life that just can't be automated or are not 100% worth the time.:frowning:

This document covers that, at least in terms of setting up a Mac Mini as a server.

## First Boot

Walk through initial first boot questions, **do not sign into iCloud!**

## Performance and Power Settings

- Disable wifi and bluetooth
- System Settings > Apple Intelligence > OFF
- System Settings > Control Center
  - Set Wifi > Don’t show in Menu Bar
  - Set Focus > Don’t show in Menu Bar
- System Settings > Energy
  - Prevent automatic sleeping with display > ON
  - Wake for Network Access > ON
  - Start up automatically after power failure > ON
- System Settings > Accessibility
  - Display > Reduce Motion > ON
  - Display > Differentiate without Color > ON
  - Display > Show Toolbar button shapes > ON
- System Settings > Wallpaper > Pick a solid color or wallpaper without motion
- System Settings > Notifications
  - Show Previews > Never
  - Turn off “Allow notifications while…” entries
- System Settings > Sound
  - Play user interface sound effects > OFF
  - Set alert volume dial to lowest level (effectively off)
- System Settings > Lock Screen
  - Start Screen save when inactive > Never
  - Turn display off when inactive > 5 minutes
  - Show Large Clock > Never
- System Settings > Users and Groups > Automatically Login

> [!NOTE]
> If you turn on FileVault you cannot do automatic login.

## Sharing Settings

- Systems Settings > General > Sharing
  - File Sharing > ON
    - Select Advanced > Toggle Windows File Sharing for your user account
  - Remote Management > ON (Edovia Screens)
    - Options > Enable Observe, Control
  - Remote Login > ON (SSH Access)
  - Local Hostname > Set to your hostname
- System Settings > General > About
  - Set Name to hostname
- System Settings > General > Software Update
  - Turn on Download new Updates
  - Leave Install MacOS Updates off
  - Turn on application updates from the App Store
  - Turn Install security response and system files

> [!TIP]
> You can turn on Screen Sharing only if you don't intend to use Edovia Screens

> [!TODO]
> Look into Content Caching setup and moving Music Library to server

## Updates

Ensure machine is updated to the latest patch release of MacOS

> [!NOTE]
> I am not upgrading my server to MacOS 26 (Tahoe) at this time, plan to wait at least 3-4 months.

## Application Installation and Configuration

### Pre-Work

- Install Xcode Command Line Tools `sudo xcode-select --install`
- Install Rosetta 2 `softwareupdate --install-rosetta`
- Sign into Mac App Store 

> [!NOTE]
> Signing into the Mac App Store will not do a full iCloud sign-in.

### Ansible Setup

> [!NOTE]
> Should be run from an Ansible control host but could be run locally on the server itself

- Run playbook with bootstrap tag `just build odin --tags bootstrap`
- Run playbook with skip-tags for certs, web and compose `just build odin --skip-tags certs,web,compose`
- Login into machine and do the following
  - Run AutomounterHelper
  - Run Kekaexternalhelper
  - Configure Automounter to mount synology shares
  - Setup Keka as default uncompressor
  - Setup Plex Media Server
  - Setup SABnzbd
  - Setup qBittorrent
  - Setup colima and set brew service to started
  
```console
colima start --cpus 4 -d 100 -m 8 -z --mount-type virtiofs --vm-type vz --vz-rosetta --save-config
colima stop
brew services start colima
```

- Run playbook with tags for certs, web and compose `just build odin --tags certs,web,compose`