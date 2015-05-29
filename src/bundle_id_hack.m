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
 
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "bundle_id_hack.h"

@implementation NSBundle (FakeBundleIdentifier)

// Based on code from terminal-notifier.
// https://github.com/alloy/terminal-notifier | MIT Licensed

-(NSString *)__bundleIdentifier {
    if (self == [NSBundle mainBundle]) {
        return @"com.apple.Terminal";
    } else {
        return [self __bundleIdentifier];
    }
}

@end

void hackBundleIdIfNeeded() {
    if ([[NSBundle mainBundle] bundleIdentifier] == nil) {
        Class class = objc_getClass("NSBundle");
        if (class) {
            method_exchangeImplementations(
                class_getInstanceMethod(class, @selector(bundleIdentifier)),
                class_getInstanceMethod(class, @selector(__bundleIdentifier))
            );
        } else {
            NSLog(@"Failed to hack the main bundle identifier.");
        }
    }
}
