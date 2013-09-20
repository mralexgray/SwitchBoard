//
//  EndedCallTransferViewController.m
//  Telephone

#import "EndedCallTransferViewController.h"

@implementation EndedCallTransferViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[[self displayedNameField] cell] setBackgroundStyle:NSBackgroundStyleLight];
    [[[self statusField] cell] setBackgroundStyle:NSBackgroundStyleLight];
}

@end
