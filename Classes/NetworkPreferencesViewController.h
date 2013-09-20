//
//  NetworkPreferencesViewController.h
//  Telephone

#import <Cocoa/Cocoa.h>

@class PreferencesController;

// A view controller to manage network preferences.
@interface NetworkPreferencesViewController : NSViewController

// Preferences controller the receiver belongs to.
@property (nonatomic, assign) PreferencesController *preferencesController;

// Outlets.
@property (nonatomic, retain) IBOutlet NSTextField *transportPortField;
@property (nonatomic, retain) IBOutlet NSTextField *STUNServerHostField;
@property (nonatomic, retain) IBOutlet NSTextField *STUNServerPortField;
@property (nonatomic, retain) IBOutlet NSButton *useICECheckBox;
@property (nonatomic, retain) IBOutlet NSButton *useDNSSRVCheckBox;
@property (nonatomic, retain) IBOutlet NSTextField *outboundProxyHostField;
@property (nonatomic, retain) IBOutlet NSTextField *outboundProxyPortField;

// Returns YES if network settings have been changed.
- (BOOL)checkForNetworkSettingsChanges:(id)sender;

@end
