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

#import "notify.h"
#import <Foundation/Foundation.h>
#import "bundle_id_hack.h"

void notify(char *title, char *subtitle, char *informativeText) {
    NSString *titleString = nil;
    if (title) {
        titleString = [[NSString alloc] initWithCString:title
                                               encoding:NSUTF8StringEncoding];
    }

    NSString *subtitleString = nil;
    if (subtitle) {
        subtitleString = [[NSString alloc] initWithCString:subtitle
                                                  encoding:NSUTF8StringEncoding];
    }

    NSString *informativeTextString = nil;
    if (informativeText) {
        informativeTextString = [[NSString alloc] initWithCString:informativeText
                                                         encoding:NSUTF8StringEncoding];
    }

    hackBundleIdIfNeeded(nil); // I hate computers.

#ifdef OSXNDEBUG
    NSLog(@"bundleIdentifier = %@", [[NSBundle mainBundle] bundleIdentifier]);
    NSLog(@"titleString = %@", titleString);
    NSLog(@"subtitleString = %@", subtitleString);
    NSLog(@"informativeTextString = %@", informativeTextString);
#endif

    if (titleString == nil) {
        return; // Can't send a notification without a title.
    }

    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.hasActionButton = NO;
    notification.title = titleString;

    if (subtitleString != nil) {
        notification.subtitle = subtitleString;
    }

    if (informativeTextString != nil) {
        notification.informativeText = informativeTextString;
    }

    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];

    [notification release]; notification = nil;
    [informativeTextString release]; informativeText = nil;
    [subtitleString release]; subtitleString = nil;
    [titleString release]; titleString = nil;
}
