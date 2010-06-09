`Solcounter.menu`
=================
This project is an open-source menubar clock and calendar for the [UNIX / Julian date](http://yreality.net/UJD/)
system. It is implemented as an `NSMenuExtra`, and the source code may interest those of you attempting to build
your own `MenuExtra`s for OS X.

Installation
------------
You can download a compiled copy of `Solcounter.menu` from the GitHub downloads section:
<http://github.com/elliottcable/Solcounter.menu/downloads>

Once you’ve downloaded (or compiled, see below) a copy of `Solcounter.menu`, simply double-click the
`Solcounter.prefPane` to install it, and then enable `Solcounter.menu` in the preference pane. To later uninstall
`Solcounter.menu`, all you need to do is uncheck that checkbox, and then right-click on the preference pane’s
icon and select ‘Remove “Solcounter” Preference Pane.’

Enabling `Solcounter.menu` automatically activates MenuCracker, and disabling `Solcounter.menu` via the
preference pane automatically disables MenuCracker. However, if you simply drag `Solcounter.menu` out of the
menubar, it will not disable MenuCracker; MenuCracker will continue to be active indefinitely. You can
subsequently remove MenuCracker by re-enabling and then disabling `Solcounter.menu` via the preference pane.

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

Once you’ve got the headers, you need to build `Solcounter.menu` itself before you can build the
`Solcounter.prefPane` (which is necessary to install and control `Solcounter.menu`). Open the
`Solcounter.xcodeproj` at the root of the project directory, and activate the ‘Release’ target, then select
“Build > Build and Analyze.” If there are no errors or warnings during the build process, you’re good to go; you
can now open the preference pane `.xcodeproj` (in the ‘Preference Pane’ subdirectory) and do the same thing:
activate the ‘Release’ target, and select “Build > Build and Analyze.”

Once the preference pane has compiled, simply double-click the product to install it, and open it to enable
`Solcounter.menu`!
