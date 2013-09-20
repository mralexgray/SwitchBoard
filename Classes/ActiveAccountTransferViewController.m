//
//  ActiveAccountTransferViewController.m
//  Telephone


#import "ActiveAccountTransferViewController.h"

#import "AccountController.h"

@implementation ActiveAccountTransferViewController

- (id)initWithAccountController:(AccountController *)anAccountController
               windowController:(XSWindowController *)windowController {
    
    self = [super initWithNibName:@"ActiveAccountTransferView" bundle:nil windowController:windowController];
	if (self != nil) {
        [self setAccountController:anAccountController];
    }
    return self;
}
- (IBAction)makeCallToTransferDestination:(id)sender {
    if ([[[self callDestinationField] objectValue] count] == 0) {
        return;
    }
	NSDictionary *callDestinationDict = [[self callDestinationField] objectValue][0][[self callDestinationURIIndex]];
	NSString *phoneLabel = callDestinationDict[kPhoneLabel];
	AKSIPURI *uri = [self callDestinationURI];
    if (uri != nil) {
        [[self accountController] makeCallToURI:uri
                                     phoneLabel:phoneLabel
                         callTransferController:[[sender window] windowController]];
    }
}
- (IBAction)makeCall:(id)sender {
    return;
}

@end
