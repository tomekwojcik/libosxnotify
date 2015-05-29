# libosxnotify

No nonsense OS X notifications for scripts.

## What?

This repostory contains some Objective-C code that can be used by external
programs to display native OS X notifications.

## Why?

It all started as an idea to practice writing Python extensions in C. Then
@lukaszkorecki suggested to support FFI so this code can be used in languages
other than Python.

The idea is to allow scripts to display notifications without relying on
third party binaries.

## Requirements

* OS X >= 10.9.4 - should work on Mountain Lion but it's not tested.
* Xcode and command line utilities.

## Installation

To install the `libosxnotify` library, issue the following command:

```sh
$ make install
```

By default, the library will install to `/usr/local`. You can change this
by setting `PREFIX` environment variable, e.g.

```sh
$ PREFIX=/Users/bilbo/opt/libosxnotify make install
```

## Usage

See the code of `osxnotify` program for usage example.

## Issues and limitations

Due to the nature of OS X notification system, it's currently impossible to
change the icon. OS X assumes that notifications are sent from a running app.
Since this isn't the case in, say, Python scripts, libosxnotify has to hack
Objective-C runtime to make it think there's an app running. By doing so,
libosxnotify sets the ID of the current up to the system-provided Terminal.app.

libosxnotify only supports text content (title, subtitle and informative text)
in notifications. Buttons, inputs and images aren't supported.

UTF-8 is the only supported text encoding. And yes, emojis are supported ;).

## Disclaimer

Keep in mind that this whole thing is a hack. It may not work as expected or it
may surprise you by blowing up your program. You've been warned.

## Wrappers

* [osxnotify-python](https://github.com/tomekwojcik/osxnotify-python) - native Python wrapper,
* [osxnotify-python-cffi](https://github.com/tomekwojcik/osxnotify-python-cffi) - CFFI-based Python wrapper.

## License

libosxnotify is licensed under MIT License.

## Author

libosxnotify was written by [Tomek Wójcik](http://www.tomekwojcik.com/).
