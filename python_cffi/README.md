# osxnotify-cffi

CFFI-based Python wrapper for osxnotify.

## Installing

```sh
$ python setup.py install
```

## Usage

```python
import osxnotify_cffi

osnotify_cffi.notify('Title', subtitle='Subtitle', informative_text='Informative text')
```

## Issues and limitations

Currently, only UTF-8 is supported.
