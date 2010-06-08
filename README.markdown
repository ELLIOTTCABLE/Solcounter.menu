`Solcounter.menu`
=================
This project is an open-source menubar clock and calendar for the [UNIX / Julian date](http://yreality.net/UJD/)
system. It is implemented as an `NSMenuExtra`, and the source code may interest those of you attempting to build
your own `MenuExtra`s for OS X.

Installation
------------
You can download a compiled copy of `Solcounter.menu` from the GitHub downloads section:
<http://github.com/elliottcable/Solcounter.menu/downloads>

Once you’ve downloaded (or compiled, see below) a copy of `Solcounter.menu`, and activated MenuCracker (see
below), you only need to double-click the `.menu` file to install `Solcounter.menu`.

### MenuCracker
To use this, you first need to apply MenuCracker to your `SystemUIServer`. This can be downloaded from their
SourceForge here: <http://sourceforge.net/projects/menucracker/files/>

To install, simply mount the DMG and double-click `MenuCracker.menu`. That will load MenuCracker into your
`SystemUIServer`, allowing `Solcounter.menu` to load itself.

Future versions of `Solcounter.menu` will do this for you; this is a temporary measure.

### Compilation
To build `Solcounter.menu` for yourself, you’ll need to procure the `NSMenuExtra` headers. I can’t distribute
these with the project, as I’m unsure of the legal status of headers derived from Apple’s proprietary binaries.
This, however, is not difficult.

First, you need `class-dump`; I suggest installing it via [Homebrew](http://mxcl.github.com/homebrew/); it’s as
simple as `brew install class-dump`. You can also get it from [Steve Nygard’s website](http://www.codethecode.com/projects/class-dump/).

Next, you’ll want to dump the headers into your home folder:

    mkdir -p ~/Code/Headers
    class-dump -ISHo ~/Code/Headers/SystemUIPlugin \
      /System/Library/PrivateFrameworks/SystemUIPlugin.framework/Versions/A/SystemUIPlugin

Finally, the headers need to be slightly modified before they’ll be useful.

    for header in ~/Code/Headers/SystemUIPlugin/*.h; do
      sed -E -i '' -e 's/^(#import)/\/\/ \1/g' $header
      sed -E -i '' -e 's/^(@class)/\/\/ \1/g' $header
      sed -E -i '' -e 's/struct (CGPoint)/\1/g' $header
    done

(P.S. I tried to get this to catch all the messed up `struct` declarations in the headers, but my `sed`-fu is too
low. If you’re trying to use this to develop other MenuExtras, you’ll need to either fix that last `sed`, or go
manually replace all the extra `struct Foo` declarations in the dumped headers.)

Once you’ve got the headers, you can simply open the Xcode project and build. :D
