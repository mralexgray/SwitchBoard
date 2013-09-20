//
//  AuthenticationFailureController.h
//  Telephone

#import <Cocoa/Cocoa.h>

// Posted whenever an AuthenticationFailureController object changes account's
// username and password.
extern NSString * const AKAuthenticationFailureControllerDidChangeUsernameAndPasswordNotification;

@class AccountController;

// Instances of AuthenticationFailureController class allow user to update
// account credentials when authentication fails.
@interface AuthenticationFailureController : NSWindowController

// The receiver's account controller.
@property (nonatomic, weak) AccountController *accountController;

// Informative text outlet.
@property (nonatomic, strong) IBOutlet NSTextField *informativeText;

// |User Name| field outlet.
@property (nonatomic, strong) IBOutlet NSTextField *usernameField;

// |Password| field outlet.
@property (nonatomic, strong) IBOutlet NSTextField *passwordField;

// |Save in the Keychain| checkbox outlet.
@property (nonatomic, strong) IBOutlet NSButton *mustSaveCheckBox;

// Cancel button outlet.
@property (nonatomic, strong) IBOutlet NSButton *cancelButton;

// Initializes an AuthenticationFailureController object with a given account controller.
- (id)initWithAccountController:(AccountController *)anAccountController;

// Closes a sheet.
- (IBAction)closeSheet:(id)sender;

// Sets new user name and password.
- (IBAction)changeUsernameAndPassword:(id)sender;

@end
