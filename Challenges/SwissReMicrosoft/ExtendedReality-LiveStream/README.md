# MixedReality-WebRTC

[![Licensed under the MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/microsoft/MixedReality-WebRTC/blob/master/LICENSE)
[![Holodevelopers channel on Slack](https://img.shields.io/badge/slack-@holodevelopers-%23972299.svg?logo=slack)](https://holodevelopers.slack.com/messages/CN1A7JB3R)
[![NuGet](https://img.shields.io/nuget/vpre/Microsoft.MixedReality.WebRTC)](https://github.com/microsoft/MixedReality-WebRTC/releases)

MixedReality-WebRTC is a collection of libraries to help mixed reality app developers to integrate peer-to-peer real-time audio and video communication into their application and improve their collaborative experience.

- Enables **multi-track real-time audio / video / data communication** with a remote peer
- Provides an abstracted **signaling interface** to easily switch implementation
- Exposes an **API for C++ and C#** to integrate into existing apps
- Provides a set of **Unity3D components** for rapid prototyping and integration
- Includes support for Microsoft **HoloLens** (x86) and Microsoft **HoloLens 2** (ARM)
- Allows easy use of **[Mixed Reality Capture (MRC)](https://docs.microsoft.com/en-us/windows/mixed-reality/mixed-reality-capture)** to stream the view point of the user for multi-device experiences

MixedReality-WebRTC is part of the collection of repositories developed and maintained by the [Mixed Reality Sharing team](https://github.com/orgs/microsoft/teams/mixed-reality-sharing).

<h2><b><span style="color:red">Caution</span></b></h2>

<span style="color:red">**MR-WebRTC has been deprecated. We're no longer committing development resources to it, taking pull requests for it, or planning a replacement for it.**</span>

- If you want to continue updating it, you must fork and maintain your own branch.

## Download

NuGet (C++, C#) and UPM (Unity) packages are available for stable releases (`release/*` branches). See the [Release page on GitHub](https://github.com/microsoft/MixedReality-WebRTC/releases) or the [Download documentation page](https://microsoft.github.io/MixedReality-WebRTC/manual/download.html) for details.

_Note_: The `master` branch may contain breaking API changes from the latest stable release. It's  therefore not guaranteed to work with NuGet packages, which are only available for stable releases. In particular, the Unity library scripts are only guaranteed to be compatible with NuGet packages if copied from a `release/*` branch, though it is strongly recommended to use the UPM packages instead.

## Branches

The [`release/2.0` branch](https://github.com/microsoft/MixedReality-WebRTC/tree/release/2.0) contains the latest stable version of the API, from which the NuGet and UPM packages are published.

The [`master` branch](https://github.com/microsoft/MixedReality-WebRTC/tree/master) contains the latest developments. Care has been taken to keep this branch in a fairly clean state (branch can build, tests pass). However the `master` branch contains API breaking changes compared to the latest release, and therefore is not compatible with NuGet/UPM packages and should be built from sources instead (see [Building from sources](https://microsoft.github.io/MixedReality-WebRTC/manual/building.html) documentation).

## Documentation

The official documentation is hosted at [https://microsoft.github.io/MixedReality-WebRTC/](https://microsoft.github.io/MixedReality-WebRTC/).

### User Manual

The [User Manual](https://microsoft.github.io/MixedReality-WebRTC/manual/introduction) contains a general overview of the various libraries of the project and some tutorials on how to use them.

- The [_Hello, Unity world!_](https://microsoft.github.io/MixedReality-WebRTC/manual/helloworld-unity) tutorial introduces the Unity integration by building a simple audio and video chat client.
- The C# tutorials introduce the .NET Standard 2.0 C# API, which can be used outside Unity.
  - [_Hello, C# world! (Desktop)_](https://microsoft.github.io/MixedReality-WebRTC/manual/cs/helloworld-cs-core3.html) shows how to build a simple console app in .NET Core 3.0, which runs as a Windows Desktop (Win32) app.
  - [_Hello, C# world! (UWP)_](https://microsoft.github.io/MixedReality-WebRTC/manual/cs/helloworld-cs-uwp.html) shows how to build a GUI app with a UI based on WPF (XAML), including how to render the local and remote video.

### API reference

An [API reference](https://microsoft.github.io/MixedReality-WebRTC/api/Microsoft.MixedReality.WebRTC.html) is available for the C# library and the Unity integration.

- [C# library API reference](https://microsoft.github.io/MixedReality-WebRTC/api/Microsoft.MixedReality.WebRTC.html)
- [Unity integration reference](https://microsoft.github.io/MixedReality-WebRTC/api/Microsoft.MixedReality.WebRTC.Unity.html)

### Overview

The overall architecture is as follow:

![MixedReality-WebRTC architecture](docs/manual/architecture.png)

| Library | Lang | Description |
|---|---|---|
| `mrwebrtc` | C/C++ | Native C/C++ library providing a low-level interface to the [underlying WebRTC implementation from Google](https://opensource.google.com/projects/webrtc). Compared to the API exposed by the Google implementation (`PeerConnection`), the current interface is simplified to remove the burden of setup and configuring. It also tries to prevent common threading errors with the UWP wrappers. This library exposes are pure C API easily integrated into any C/C++ application. |
| `Microsoft.MixedReality.WebRTC` | C# 7.3 | C# .Net Standard 2.0 library providing access to the same API as the native C library, exposed with familiar C# concepts such as `async` / `await` and `Task`. |
| `Microsoft.MixedReality.WebRTC.Unity` | C# 7.3 | Unity3D integration - a set of Unity [`MonoBehaviour` components](https://docs.unity3d.com/ScriptReference/MonoBehaviour.html) with almost no required setup, to enable rapid prototyping and simplify integration into an existing app. |
| `Microsoft.MixedReality.WebRTC.Unity.Examples` | C# 7.3 | Unity3D samples showcasing typical use scenarios like a peer-to-peer video chat app. |

MixedReality-WebRTC is currently available for Windows 10 Desktop and UWP, with or without Unity, and Android (Unity only).

_Note_ - In the following and elsewhere in this repository the term "Win32" is used as a synonym for "Windows Desktop", the historical Windows API for Desktop application development, and in opposition to the "Windows UWP" API. However Microsoft Windows versions older than Windows 10 with Windows SDK 17134 (April 2018 Update, 1803) are not officially supported for this project. In particular, older versions of Windows (Windows 7, Windows 8, etc.) are explicitly not supported.

### Sources

This repository follows the [Pitchfork Layout](https://api.csswg.org/bikeshed/?force=1&url=https://raw.githubusercontent.com/vector-of-bool/pitchfork/develop/data/spec.bs) in an attempt to standardize its hierarchy:

```sh
bin/               # Binary outputs (generated)
build/             # Intermediate build artifacts (generated)
docs/              # Documentation sources
+ manual/          # User manual sources
examples/          # Examples of use and sample apps
external/          # Third-party external dependencies (git submodules)
libs/              # Source code for the individual libraries
tests/             # Source code for feature tests
tools/             # Utility scripts
+ build/           # Build scripts for the various platforms
  + android/       # Android Studio project to build libmrwebrtc.so
  + libwebrtc/     # Android build scripts for Google's WebRTC library
  + mrwebrtc/      # Windows build tools to build mrwebrtc.dll
+ ci/              # CI Azure pipelines
```

The `Microsoft.MixedReality.WebRTC.sln` Visual Studio 2019 solution located at the root of the repository contains several projects:

- The native C/C++ library `mrwebrtc`, which can be compiled:
  - for Windows Desktop with the `mrwebrtc-win32` project
  - for UWP with the `mrwebrtc-uwp` project
- A C/C++ library unit tests project `mrwebrtc-win32-tests`
- The C# library project `Microsoft.MixedReality.WebRTC`
- A C# unit tests project `Microsoft.MixedReality.WebRTC.Tests`
- A UWP C# sample app project `Microsoft.MixedReality.WebRTC.TestAppUWP` based on WPF and XAML which demonstrates audio / video / data communication by mean of a simple video chat app.

_Note_ - Currently due to CI limitations some projects are downgraded to VS 2017, as the Google M71 milestone the `master` and `release/1.0` branches are building upon does not support VS 2019, and Azure DevOps CI agents do not support multiple Visual Studio versions on the same agent. This will be reverted to VS 2019 eventually (see [#14](https://github.com/microsoft/MixedReality-WebRTC/issues/14)).

## Building MixedReality-WebRTC

See the user manual section on [Building from sources](https://microsoft.github.io/MixedReality-WebRTC/manual/building.html).

## Special considerations for HoloLens 2

- Mixed Reality Capture (MRC) has some inherent limitations:
  - **MRC only works up to 1080p** (see the [Mixed reality capture for developers](https://docs.microsoft.com/en-us/windows/mixed-reality/mixed-reality-capture-for-developers) documentation), but the default resolution of the webcam on HoloLens 2 is 2272 x 1278 (see the [Locatable Camera](https://docs.microsoft.com/en-us/windows/mixed-reality/locatable-camera) documentation). In order to access different resolutions, one need to use a different video profile, like the `VideoRecording` or `VideoConferencing` ones. This is handled automatically in the Unity integration layer (see [here](https://github.com/microsoft/MixedReality-WebRTC/blob/48b9429d2667bda235c38abeafbbb0280122d2c0/libs/Microsoft.MixedReality.WebRTC.Unity/Assets/Microsoft.MixedReality.WebRTC.Unity/Scripts/Media/WebcamSource.cs#L143-L173)) if `WebcamSrouce.FormatMode = Automatic` (default), but must be handled manually if using the C# library directly.
  - **MRC requires special permission** to record the content of the screen:
    - For shared apps (2D slates), this corresponds to the `screenDuplication` [restricted capability](https://docs.microsoft.com/en-us/windows/uwp/packaging/app-capability-declarations#restricted-capabilities), which **cannot be obtained by third-party applications**. In short, MRC is not available for shared apps. This is an OS limitation.
    - For exclusive-mode apps (fullscreen), there is no particular UWP capability, but the recorded content is limited to the application's own content.
- Be sure to use `PreferredVideoCodec = "H264"` to make use of the hardware encoder present on the device; software encoding with _e.g._ VP8 or VP9 codecs is very CPU intensive and strongly discouraged.

## Known Issues

The current version is a public preview which contains known issues:

- By default, the WebRTC UWP implementation accesses video capture devices on the system in exclusive mode. This will cause an error when enabling video capture if another application is using the device.
- ARM64 build: Not supported by WebRTC m71/WebRTC UWP SDK.
- H.265: Not supported by WebRTC m71/WebRTC UWP SDK.
- HoloLens 2 exhibits some small performance penalty due to the [missing support (#157)](https://github.com/webrtc-uwp/webrtc-uwp-sdk/issues/157) for SIMD-accelerated YUV conversion in WebRTC UWP SDK on ARM.
- H.264 hardware video encoding (UWP only) exhibits some quality degrading (blockiness). See [#74]((https://github.com/webrtc-uwp/webrtc-uwp-sdk/issues/74)) and [#153]((https://github.com/webrtc-uwp/webrtc-uwp-sdk/issues/153)) for details.
- H.264 is not currently available on Desktop at all (even in software). Only VP8 and VP9 are available instead (software encoding/decoding).
- The NuGet packages (v1.x) for the former C++ library `Microsoft.MixedReality.WebRTC.Native` include some WebRTC headers from the Google repository, which are not shipped with any of the NuGet packages themselves, but instead require cloning this repository and its dependencies (see #123).

In addition, the Debug config of WebRTC core implementation is known to exhibit some performance issues on most devices, including some higher-end PCs. Using the Release config of the core WebRTC implementation usually prevents this, and is strongly recommended when not debugging.

## Microsoft Open Source Code of Conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Reporting security issues and bugs

MixedReality-WebRTC builds upon the WebRTC implementation provided by Google. Security issues and bugs related to this implementation should be reported to Google.

Security issues and bugs related to MixedReality-WebRTC itself or to WebRTC UWP SDK should be reported privately, via email, to the Microsoft Security Response Center (MSRC) secure@microsoft.com. You should receive a response within 24 hours. If for some reason you do not, please follow up via email to ensure we received your original message. Further information, including the MSRC PGP key, can be found in the [Security TechCenter](https://technet.microsoft.com/en-us/security/ff852094.aspx).
