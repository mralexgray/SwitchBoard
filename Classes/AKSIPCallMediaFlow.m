

#import "AKSIPCall.h"
#import "AKNSString+PJSUA.h"
#import "AKSIPCallMediaFlow.h"

@implementation	AKSIPCallMediaFlow

- (id)initWithCall:(AKSIPCall *)aCall shouldPlay:(id)aSound
	   andOrRecord:(BOOL)shouldRecord;
{
	if (self != super.init ) return nil;
	self.ca = aCall;
	return self;
}
- (id)init { [self initWithCall:nil shouldPlay:nil andOrRecord:NO]; }


- (void) playSound:(id)sound
{
	if (self.playFile) {

		pjsua_player_id player_id;      // a new player?
	
		int status = pjsua_player_create("mysong.wav", 0, &player_id);

						if ([aCall identifier] == callIdentifier) {
					theCall = [[aCall retain] autorelease];
					break;
				}
			}

//	pj_status_t stream_to_call( pjsua_call_id call_id )
//	{
//		status = pjsua_player_create("mysong.wav", 0, &player_id);
		if (status != PJ_SUCCESS)
			return status;
		status = pjsua_conf_connect( pjsua_player_get_conf_port(),
									pjsua_call_get_conf_port() );
	}



- (void) record;


/**
    pjsua_call_info callInfo;
    pj_status_t status = pjsua_call_get_info(anIdentifier, &callInfo);
    if (status == PJ_SUCCESS) {
        [self setState:callInfo.state];
        [self setStateText:[NSString stringWithPJString:callInfo.state_text]];
        [self setLastStatus:callInfo.last_status];
        [self setLastStatusText:[NSString stringWithPJString:callInfo.last_status_text]];
        [self setRemoteURI:[AKSIPURI SIPURIWithString:[NSString stringWithPJString:callInfo.remote_info]]];
        [self setLocalURI:[AKSIPURI SIPURIWithString:[NSString stringWithPJString:callInfo.local_info]]];

        if (callInfo.state == kAKSIPCallIncomingState) {
            [self setIncoming:YES];
        } else {
            [self setIncoming:NO];
        }

    } else {
        [self setState:kAKSIPCallNullState];
        [self setIncoming:NO];
    }

    return self;
}

**/
@end
