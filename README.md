EMCLoginItem
============

`EMCLoginItem` is an Objective-C library to query, add and remove login items
in Apple OS X.

Usage
-----

An instance of `EMCLoginItem` can be created using either one of the provided
`init` methods or one of the provided factory methods (`loginItem*`).  These
methods have the following method signatures:

  * `- (instancetype)init;`
  * `- (instancetype)initWithBundle:(NSBundle *)bundle;`
  * `- (instancetype)initWithPath:(NSString *)path;`

When the initialiser with no argument is used, the bundle path of the main
bundle is used as login item URL:

    [[NSBundle mainBundle] bundlePath];

Alternatively, the other two initialisers can be used to manually provide
either a bundle or a path to use as login item URL.

The methods implemented by the `EMCLoginItem` class are the following:

  * `- (BOOL)isLoginItem;`
  * `- (void)addLoginItem;`
  * `- (void)removeLoginItem;`
  * `- (void)addAfterLast;`
  * `- (void)addAfterFirst;`
  * `- (void)addAfterItemWithPath:(NSString *)path;`
  * `- (void)addAfterBundle:(NSBundle *)bundle;`
  * `- (void)setIconRef:(IconRef)iconRef;`

The first three methods are used to respectively query, add and remove a login
item for the current user with the specified URL, as show in the following
example:

    if (![loginItem isLoginItem])
    {
      [loginItem addLoginItem];
    }

The `addAfter*` methods let callers specify the position where the login item
will be added:

  * `addAfterLast` will add the login item at the end of the item list.
  * `addAfterFirst` will add the login item at the beginning of the item list.
  * `addAfterItemWithPath` will add the login item after the item with the
    specified path, if it exists, otherwise at the end of the item list.
  * `addAfterBundle` will add the login item after the item with the
    specified bundle, if it exists, otherwise at the end of the item list.

The `setIconRef` path is used to pass an `IconRef` instance to be used as a
custom icon for the login item to be added.  This method increases the IconRef
reference count by 1 invoking the `AcquireIconRef` method if and only if the
value to be set differs from the currently stored value (initially nil, and
released if not nil).  The `dealloc` method takes care of releasing non-null
IconRef references invoking the `ReleaseIconRef` method.

Installation
------------

`EMCLoginItem` is packaged and distributed as a _framework_.  Developers who
want to compile it from source may either use XCode (a project called
`EMCLoginItem.xcodeproj` is included in the sources) or `xcodebuild`.  Once the
framework is installed it can be referenced and linked from any other XCode
project.

The best place to install public frameworks is in `/Library/Frameworks` since
frameworks in that location are discovered automatically by the compiler and
the dynamic linker (see Apple's [_Framework Programming Guide_][fmk]).

[fmk]: https://developer.apple.com/library/mac/documentation/macosx/conceptual/BPFrameworks/Tasks/InstallingFrameworks.html

The easiest way to install or upgrade an installation of `EMCLoginItem` in
`/Library/Framework` is using `xcodebuild` specifying `/` as `DSTROOT`:

    $ sudo xcodebuild install DSTROOT=/

Alternatively, you can install the framework using a binary package you can
download for every release.

Please beware that since the package is _not_
signed, you will have to temporarily allow installation for applications
downloaded from _Anywhere_ in the _Security & Privay_ section in
_System Preferences_.

License
-------

`EMCLoginItem` is licensed under the [_BSD 3-Clause License_][bsd3].

[bsd3]: http://opensource.org/licenses/BSD-3-Clause

-----

Copyright (C) 2014, Enrico M. Crisostomo
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice, 
     this list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation
     and/or other materials provided with the distribution.

  3. Neither the name of the copyright holder nor the names of its contributors
     may be used to endorse or promote products derived from this software
     without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
