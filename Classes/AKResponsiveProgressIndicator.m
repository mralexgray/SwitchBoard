//
//  AKResponsiveProgressIndicator.m
//  Telephone

#import "AKResponsiveProgressIndicator.h"

@implementation AKResponsiveProgressIndicator

- (void)mouseUp:(NSEvent *)theEvent {
    [NSApp sendAction:[self action] to:[self target] from:self];
}

@end
