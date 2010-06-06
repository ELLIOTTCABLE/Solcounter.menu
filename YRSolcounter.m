//
//  YRSolcounter.m
//  Solcounter
//
//  Created by elliottcable on 14 766 ſ.
//  Copyright 2010 yreality. All rights reserved.
//

#import "YRSolcounter.h"
#import "YRSolcounterView.h"


@implementation YRSolcounter

- (id)initWithBundle:(NSBundle *)bundle
{
  if ( (self = [super initWithBundle: bundle]) == nil ) return nil;
  
  defaults = [[BundleUserDefaults alloc]
    initWithPersistentDomainName: [bundle objectForInfoDictionaryKey: @"CFBundleIdentifier"]];
  [defaults registerDefaults: [NSDictionary dictionaryWithContentsOfFile:
    [bundle pathForResource: @"UserDefaults" ofType: @"plist"]]];
  
  [self setView:
    (menuExtraView = [[YRSolcounterView alloc] initWithFrame: [[self view] frame] menuExtra: self]) ];
  
  return self;
}

- (void)dealloc
{
  [menuExtraView release];
  [super dealloc];
}

@end
