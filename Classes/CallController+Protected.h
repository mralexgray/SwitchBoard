//
//  CallController+Protected.h
//  Telephone

#import <Cocoa/Cocoa.h>

// Protected CallController interface.
@interface CallController (CallControllerProtectedAdditions)

// Implements AKSIPCallCallingNotification.
- (void)SIPCallCalling:(NSNotification *)notification;

// Implements AKSIPCallEarlyNotification.
- (void)SIPCallEarly:(NSNotification *)notification;

// Implements AKSIPCallDidConfirmNotification.
- (void)SIPCallDidConfirm:(NSNotification *)notification;

// Implements AKSIPCallDidDisconnectNotification.
- (void)SIPCallDidDisconnect:(NSNotification *)notification;

// Implements AKSIPCallMediaDidBecomeActiveNotification.
- (void)SIPCallMediaDidBecomeActive:(NSNotification *)notification;

// Implements AKSIPCallDidLocalHoldNotification.
- (void)SIPCallDidLocalHold:(NSNotification *)notification;

// Implements AKSIPCallDidRemoteHoldNotification.
- (void)SIPCallDidRemoteHold:(NSNotification *)notification;

@end
