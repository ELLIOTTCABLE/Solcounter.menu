//
//  YRSolcounter.h
//  Solcounter
//
//  Created by elliottcable on 14 766 ſ.
//  Copyright 2010 yreality. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SystemUIPlugin/NSMenuExtra.h>
#import "Vendor/BundleUserDefaults.h"

@class YRSolcounterView;


@interface YRSolcounter: NSMenuExtra {
  IBOutlet //»
  NSTextField            *textField;
    BundleUserDefaults   *defaults;
  NSTimer                *timer;
}

-(id)     initWithBundle: (NSBundle*)bundle;
-(void)   handleTimer: (NSTimer*)_;

@end
