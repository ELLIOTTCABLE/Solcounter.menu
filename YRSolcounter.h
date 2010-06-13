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


@interface YRSolcounter: NSMenuExtra {
IBOutlet //»
NSTextField            *textField;
NSFont                 *radixFont;

NSTimer                *timer;

  BundleUserDefaults   *defaults;
NSNumber               *integralPrecision;
NSNumber               *fractionalPrecision;
}

-(id)     initWithBundle: (NSBundle*)bundle;
-(void)   initTextField;
-(void)   handleTimer: (NSTimer*)_;

@end
