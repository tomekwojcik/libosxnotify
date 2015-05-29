# osxnotify

Native Python wrapper for osxnotify.

## Installing

```sh
$ python setup.py install
```

## Usage

```python
import osxnotify

osnotify.notify('Title', subtitle='Subtitle', informative_text='Informative text')
```

## Issues and limitations

Currently, only UTF-8 is supported.
