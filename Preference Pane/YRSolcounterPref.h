//
//  YRSolcounterPref.h
//  Solcounter
//
//  Created by elliottcable on 14 768 ſ.
//  Copyright 2010 yreality. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>


@interface YRSolcounterPref : NSPreferencePane 
{
  IBOutlet NSButton *extraEnabled;
}

- (void) mainViewDidLoad;
- (IBAction) toggleExtra:(id)sender;

- (void)loadExtra:(NSString *)extraPath;
- (void)removeExtra:(NSString *)extraPath;
- (BOOL)isExtraLoaded:(NSString *)extraPath;

@end
