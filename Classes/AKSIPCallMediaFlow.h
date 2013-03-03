


#import <Foundation/Foundation.h>
#import <pjsua-lib/pjsua.h>

@class AKSIPCall;
// A class representing a SIP call recorder, broadcaster.
@interface AKSIPCallMediaFlow : NSObject

// Designated initializer.	 Initializes a AKSIPCall object with a given SIP account and identifier.
- (id)initWithCall:(AKSIPCall *)aCall shouldPlay:(id)aSound
								     andOrRecord:(BOOL)shouldRecord;
// The receiver's delegate.
@property (nonatomic, assign) AKSIPCall *call;

@property (strong, nonatomic) NSString *saveFile, *playFile;

- (void) playSound:(NSString*)sound;
- (void) record;

@end
