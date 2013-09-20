//
//  AKActiveCallView.h
//  Telephone

#import <Cocoa/Cocoa.h>

@protocol AKActiveCallViewDelegate;

// The AKActiveCallView class receives DTMF digits |0123456789*#| and control characters |mh| from the keyboard. It
// gives its delegate a chance to get those DTMF digits and it sends control characters further.
@interface AKActiveCallView : NSView

// The receiver's delegate.
@property (nonatomic, unsafe_unretained) IBOutlet id <AKActiveCallViewDelegate> delegate;

@end

// Declares the interface that AKActiveCallView delegates must implement.
@protocol AKActiveCallViewDelegate <NSObject>
@optional
// Sent when a view receives text input from the keyboard.
// Now it handles only DTMF digits |0123456789*#|.
- (void)activeCallView:(AKActiveCallView *)sender didReceiveText:(NSString *)aString;
@end