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

import os
import shlex
import shutil
import subprocess

from distutils.command.build import build
from distutils.command.install import install
from setuptools import setup


def _build_notify_so():
    print 'building CFFI library...'
    result = subprocess.Popen(
        shlex.split('make notify.so'),
        cwd=os.path.abspath('../src')
    )
    result.wait()
    assert result.returncode == 0

    shutil.copy(
        os.path.abspath('../src/notify.so'),
        os.path.abspath('osxnotify_cffi/notify.so')
    )


# I hate computers...
class OSXNotifyCFFIBuild(build):
    def run(self):
        _build_notify_so()
        build.run(self)


class OSXNotifyCFFIInstall(install):
    def run(self):
        _build_notify_so()
        install.run(self)

setup(
    name='osxnotify_cffi',
    version='1.0',
    description='No nonsense OS X notifications for Python scripts',
    author=u'Tomek Wójcik',
    author_email='tomek@bthlabs.pl',
    packages=['osxnotify_cffi'],
    package_data={
        'osxnotify_cffi': ['notify.so']
    },
    install_requires=['cffi>=1.0.0'],
    cmdclass={
        'build': OSXNotifyCFFIBuild,
        'install': OSXNotifyCFFIInstall
    },
    zip_safe=False,
    license='MIT'
)
