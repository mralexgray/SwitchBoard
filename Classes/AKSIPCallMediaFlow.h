
#import <Foundation/Foundation.h>
#import <pjsua-lib/pjsua.h>
//#import "AZSpeechSynthesizer.h"

@class 	   AKSIPCall;//, AZSpeechSynthesizer;

@interface AKSIPCallMediaFlow : NSObject //<AZSpeechDelegate>

@property (nonatomic, assign) AKSIPCall *call;

@property (nonatomic, strong) NSString 	*whatToPlay,		*whereToSave;
@property (nonatomic, strong) NSNumber	*playerID, 		*recorderID;
@property (nonatomic, strong) NSMutableArray *synthesizers;

- (id)initWithCall:(AKSIPCall *)aCall playing:(NSString*)audioOut recordingTo:(NSString*)audioIn;
- (void) say:(NSString*) words;

@end
