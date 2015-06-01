/**
 * Copyright (c) 2015 Tomek Wójcik <tomek@bthlabs.pl>
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include <stdio.h>
#include <unistd.h>
#include <libosxnotify.h>

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("usage: osxnotify title [subtitle] [informative_text]\n");
        return 64;
    }

    char *title = argv[1];
    char *subtitle = NULL;
    char *informative_text = NULL;

    if (argc >= 3) {
        subtitle = argv[2];
    }

    if (argc >= 4) {
        informative_text = argv[3];
    }

    notify(title, subtitle, informative_text);

    // Delivery will fail if the process is dead when OS X processes the
    // notification. This *should* ensure the delivery.
    sleep(1);

    return 0;
}
