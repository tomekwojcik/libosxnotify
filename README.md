# osxnotify

No nonsense OS X notifications for scripts.

## What?

This repostory contains some Objective-C code that can be used by external
scripts to display native OS X notifications.

## Why?

It all started as an idea to practice writing Python extensions in C. Then
@lukaszkorecki suggested to support FFI so this code can be used in languages
other than Python.

The idea is to allow scripts to display notifications without relying on
third party binaries.

## Requirements

* OS X >= 10.9.4 - should work on Mountain Lion but it's not tested.
* Xcode and command line utilities.

## Issues and limitations

Due to the nature of OS X notification system, it's currently impossible to
change the icon. OS X assumes that notifications are sent from a running app.
Since this isn't the case in, say, Python scripts, osxnotify has to hack
Objective-C runtime to make it think there's an app running. By doing so,
osxnotify sets the ID of the current up to the system-provided Terminal.app.

osxnotify only supports text content (title, subtitle and informative text) in
notifications. Buttons, inputs and images aren't supported.

UTF-8 is the only supported text encoding. And yes, emojis are supported ;).

## Disclaimer

Keep in mind that this whole thing is a hack. It may not work as expected or it
may surprise you by blowing up your program. You've been warned.

## Wrappers

* Native Python wrapper - located under `python_native`,
* CFFI-based Python wrapper - located under `python_cffi`.

## License

osxnotify is licensed under MIT License.

## Credits

Core code and Python wrappers were written by [Tomek Wójcik](http://www.tomekwojcik.com/).
