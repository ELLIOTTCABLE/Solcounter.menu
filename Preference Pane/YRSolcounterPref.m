//
//  YRSolcounterPref.m
//  Solcounter
//
//  Created by elliottcable on 14 768 ſ.
//  Copyright 2010 yreality. All rights reserved.
//

#import "YRSolcounterPref.h"

// Some declarations for private CoreMenuExtra functions:
typedef struct _OpaqueMenuExtra OpaqueMenuExtra;
OSStatus CoreMenuExtraGetMenuExtra(CFStringRef identifier, OpaqueMenuExtra **menuExtraOut);
OSStatus CoreMenuExtraAddMenuExtra(CFURLRef path, SInt32 position, void *_0, void *_1, void *_2, void *_3);
OSStatus CoreMenuExtraRemoveMenuExtra(OpaqueMenuExtra *menuExtraIn, void *_0);
#define CMEGetExtra(identifier, menuExtraOut) \
  CoreMenuExtraGetMenuExtra(identifier, menuExtraOut)//;
#define CMEAddExtra(path, position) \
  CoreMenuExtraAddMenuExtra(path, position, NULL, NULL, NULL, NULL)//;
#define CMERemoveExtra(menuExtraIn) \
  CoreMenuExtraRemoveMenuExtra(menuExtraIn, NULL)//;
// (From http://www.cocoadev.com/index.pl?CoreMenuExtra)


@implementation YRSolcounterPref

- (void) mainViewDidLoad
{
  NSString *extraPath = [[self bundle] pathForResource: @"Solcounter"
                                                ofType: @"menu"
                                           inDirectory: @""];
  
  if ([self isExtraLoaded:extraPath])
    [extraEnabled setState:NSOnState];
}

- (IBAction)toggleExtra:(id)sender
{
  NSString *extraPath = [[self bundle] pathForResource: @"Solcounter"
                                                ofType: @"menu"
                                           inDirectory: @""];
  
  if (([sender state] == NSOnState) && ![self isExtraLoaded:extraPath]) {
    [self loadExtra:extraPath];
    if (![self isExtraLoaded:extraPath])
      [sender setState:NSOffState];
  } else //»
  if (([sender state] == NSOffState) && [self isExtraLoaded:extraPath]) {
    [self removeExtra:extraPath];
    if ([self isExtraLoaded:extraPath])
      [sender setState:NSOnState];
  }
}

- (void)loadExtra:(NSString *)extraPath
{ int sleepCount;
  NSURL *extraURL = [NSURL fileURLWithPath: extraPath];
  CMEAddExtra((CFURLRef)extraURL, 0);
  
  sleepCount = 0;
  while (sleepCount < 1000000) {
    if ([self isExtraLoaded: extraPath]) return;
    usleep(sleepCount += 250000); }
  
  NSString *crackerPath = [[self bundle] pathForResource: @"MenuCracker"
                                                  ofType: @"menu"
                                             inDirectory: @""];
  
  if (extraPath != crackerPath && ![self isExtraLoaded: extraPath])
    [self loadExtra:crackerPath];
  
  CMEAddExtra((CFURLRef)extraURL, 0);
  
  sleepCount = 0;
  while (sleepCount < 1000000) {
    if ([self isExtraLoaded: extraPath]) return;
    usleep(sleepCount += 250000); }
}

- (void)removeExtra:(NSString *)extraPath
{ OpaqueMenuExtra *extra;
  NSString *extraID = [[NSBundle bundleWithPath: extraPath]
                        objectForInfoDictionaryKey: @"CFBundleIdentifier"];
  
  if ((CMEGetExtra((CFStringRef)extraID, &extra) == 0) && extra)
    CMERemoveExtra(extra);
}

- (BOOL)isExtraLoaded:(NSString *)extraPath
{ OpaqueMenuExtra *extra;
  NSString *extraID = [[NSBundle bundleWithPath: extraPath]
                        objectForInfoDictionaryKey: @"CFBundleIdentifier"];
  
  return CMEGetExtra((CFStringRef) extraID, &extra) == 0 && extra;
}

@end
