# -*- coding: utf-8 -*-
# Copyright (c) 2015 Tomek Wójcik <tomek@bthlabs.pl>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

from distutils.core import Extension, setup

_osxnotify = Extension(
    '_osxnotify',
    define_macros = [
        ('MAJOR_VERSION', '1'),
        ('MINOR_VERSION', '0')
    ],
    libraries=['objc'],
    extra_compile_args=['-ObjC', '-fno-objc-arc', '-I../src'],
    extra_link_args=['-framework', 'Foundation'],
    sources=[
        'ext/_osxnotify.m', '../src/notify.m', '../src/bundle_id_hack.m'
    ],
    language='objc'
)

setup(
    name='osxnotify',
    version='1.0',
    description='No nonsense OS X notifications for Python scripts',
    author=u'Tomek Wójcik',
    author_email='tomek@bthlabs.pl',
    ext_modules=[_osxnotify],
    packages=['osxnotify'],
    zip_safe=False,
    license='MIT'
)
