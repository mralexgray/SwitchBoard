//
//  ActiveAccountTransferViewController.h
//  Telephone


#import <Cocoa/Cocoa.h>

#import "ActiveAccountViewController.h"

// A controller that acts as an account controller inside call transfer sheet.
@interface ActiveAccountTransferViewController : ActiveAccountViewController

// Initiates a call to the transfer destination.
- (IBAction)makeCallToTransferDestination:(id)sender;

@end
