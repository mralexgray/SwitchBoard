//
//  AccountPreferencesViewController.h
//  Telephone

#import <Cocoa/Cocoa.h>

@class PreferencesController, AccountSetupController;

// A view controller to manage account preferences.
@interface AccountPreferencesViewController : NSViewController

// Preferences controller the receiver belongs to.
@property (nonatomic, weak) PreferencesController *preferencesController;

// Account setup controller.
@property (nonatomic, readonly) AccountSetupController *accountSetupController;

// Outlets.
@property (nonatomic, strong) IBOutlet NSTableView *accountsTable;
@property (nonatomic, strong) IBOutlet NSButton *addAccountButton;
@property (nonatomic, strong) IBOutlet NSButton *accountEnabledCheckBox;
@property (nonatomic, strong) IBOutlet NSTextField *accountDescriptionField;
@property (nonatomic, strong) IBOutlet NSTextField *fullNameField;
@property (nonatomic, strong) IBOutlet NSTextField *domainField;
@property (nonatomic, strong) IBOutlet NSTextField *usernameField;
@property (nonatomic, strong) IBOutlet NSTextField *passwordField;
@property (nonatomic, strong) IBOutlet NSTextField *reregistrationTimeField;
@property (nonatomic, strong) IBOutlet NSButton *substitutePlusCharacterCheckBox;
@property (nonatomic, strong) IBOutlet NSTextField *plusCharacterSubstitutionField;
@property (nonatomic, strong) IBOutlet NSButton *useProxyCheckBox;
@property (nonatomic, strong) IBOutlet NSTextField *proxyHostField;
@property (nonatomic, strong) IBOutlet NSTextField *proxyPortField;
@property (nonatomic, strong) IBOutlet NSTextField *SIPAddressField;
@property (nonatomic, strong) IBOutlet NSTextField *registrarField;
@property (nonatomic, strong) IBOutlet NSTextField *cantEditAccountLabel;

// Raises |Add Account| sheet.
- (IBAction)showAddAccountSheet:(id)sender;

// Raises |Remove Account| sheet.
- (IBAction)showRemoveAccountSheet:(id)sender;

// Removes account with specified index.
- (void)removeAccountAtIndex:(NSInteger)index;

// Populates fields and checkboxes for the account with a specified index.
- (void)populateFieldsForAccountAtIndex:(NSInteger)index;

// Enables or disables an account.
- (IBAction)changeAccountEnabled:(id)sender;

// Enables or disables plus character replacement for an account.
- (IBAction)changeSubstitutePlusCharacter:(id)sender;

// Enables or disables proxy usage for an account.
- (IBAction)changeUseProxy:(id)sender;

@end
