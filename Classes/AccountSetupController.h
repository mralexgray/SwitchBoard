//
//  AccountSetupController.h
//  Telephone

#import <Cocoa/Cocoa.h>

// Sent when account setup controller adds an account.
// |userInfo| object contains dictionary with the account data (see the account keys defined in
// PreferencesController.h).
extern NSString * const AKAccountSetupControllerDidAddAccountNotification;

// A class to manage account setup.
@interface AccountSetupController : NSWindowController

// Outlets.
@property (nonatomic, strong) IBOutlet NSTextField *fullNameField;
@property (nonatomic, strong) IBOutlet NSTextField *domainField;
@property (nonatomic, strong) IBOutlet NSTextField *usernameField;
@property (nonatomic, strong) IBOutlet NSTextField *passwordField;
@property (nonatomic, strong) IBOutlet NSImageView *fullNameInvalidDataView;
@property (nonatomic, strong) IBOutlet NSImageView *domainInvalidDataView;
@property (nonatomic, strong) IBOutlet NSImageView *usernameInvalidDataView;
@property (nonatomic, strong) IBOutlet NSImageView *passwordInvalidDataView;
@property (nonatomic, strong) IBOutlet NSButton *defaultButton;
@property (nonatomic, strong) IBOutlet NSButton *otherButton;

// Closes a sheet.
- (IBAction)closeSheet:(id)sender;

// Adds new account.
- (IBAction)addAccount:(id)sender;

@end
