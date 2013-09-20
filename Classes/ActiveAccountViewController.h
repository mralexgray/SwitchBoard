//
//  ActiveAccountViewController.h
//  Telephone

#import <Cocoa/Cocoa.h>

#import "XSViewController.h"

// Call destination keys.
extern NSString * const kURI;
extern NSString * const kPhoneLabel;

@class AccountController, AKSIPURI;

// An active account view controller.
@interface ActiveAccountViewController : XSViewController

// Account controller the receiver belongs to.
@property (nonatomic, weak) AccountController *accountController;

// Call destination token field outlet.
@property (nonatomic, strong) IBOutlet NSTokenField *callDestinationField;

// Index of a URI in a call destination token.
@property (nonatomic, assign) NSUInteger callDestinationURIIndex;

// Call destination URI.
@property (weak, nonatomic, readonly) AKSIPURI *callDestinationURI;

// Designated initializer.
// Initializes an ActiveAccountViewController object with a given account controller and window controller.
- (id)initWithAccountController:(AccountController *)anAccountController
               windowController:(XSWindowController *)windowController;

// Makes a call.
- (IBAction)makeCall:(id)sender;

// Changes the active SIP URI index in the call destination token.
- (IBAction)changeCallDestinationURIIndex:(id)sender;

@end
