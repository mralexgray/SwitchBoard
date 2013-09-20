//
//  ActiveCallTransferViewController.h
//  Telephone

#import <Foundation/Foundation.h>

#import "ActiveCallViewController.h"

// An active call controller of a call transfer.
@interface ActiveCallTransferViewController : ActiveCallViewController

// Call transfer button.
@property (nonatomic, strong) IBOutlet NSButton *transferButton;

// Transfers a call.
- (IBAction)transferCall:(id)sender;

@end
