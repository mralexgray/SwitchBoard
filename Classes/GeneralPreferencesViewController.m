//
//  GeneralPreferencesViewController.m
//  Telephone

#import "GeneralPreferencesViewController.h"

@implementation GeneralPreferencesViewController

- (id)init {
    self = [super initWithNibName:@"GeneralPreferencesView" bundle:nil];
    if (self != nil) {
        [self setTitle:NSLocalizedString(@"General", @"General preferences window title.")];
    }
	return self;
}

@end
