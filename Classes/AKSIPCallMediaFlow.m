

#import "AKSIPCall.h"
#import "AKNSString+PJSUA.h"
#import "AKSIPCallMediaFlow.h"

@interface AKSIPCallMediaFlow ()
@property (nonatomic, assign) SpeechChannel					curSpeechChannel;
@property (nonatomic, retain) NSString * voiceName, *textToSpeak, *audioOutput;
@property (nonatomic, retain) NSURL *audioOutputURL;
@end

@implementation	AKSIPCallMediaFlow

- (id)initWithCall:(AKSIPCall *)aCall playing:(NSString*)audioOut recordingTo:(NSString*)audioIn;
{
	if (self != super.init ) return nil;
						 _call 			= aCall;
	if (audioIn) 	self.whereToSave 	= audioIn;
	if (audioOut)	self.whatToPlay		= audioOut;
	_synthesizers = NSMutableArray.array;
	return self;
}
- (id)init { return [self initWithCall:nil playing:nil recordingTo:nil]; }

//- (void) speechIsReadyFor:(AZSpeechSynthesizer*)synth;
//{
//	self.whatToPlay = synth.audioOutput;
//	[_synthesizers removeObject:synth];
//	synth = nil;
//}
- (NSURL*)audioOutputURL {
	_audioOutput 		= [[NSFileManager.defaultManager pathForTemporaryFile:NSString.uuidString]stringByAppendingPathExtension:@"wav"];
	return _audioOutputURL 	= [NSURL URLWithString:_audioOutput];		NSLog(@"URL: %@", _audioOutputURL);
}
- (void) say:(NSString*) words
{

//	OSErr		theErr 	= noErr;
//
//	SetSpeechProperty( self.curSpeechChannel, kSpeechOutputToFileURLProperty, (__bridge CFTypeRef)self.audioOutputURL);
//	char * theTextToSpeak = (char *)[words lossyCString];
//	theErr = theTextToSpeak ? SpeakText(_curSpeechChannel, theTextToSpeak, strlen(theTextToSpeak)) : theErr;
//	NSLog(@"tried to save %@ to %@", _audioOutput, words);
//	self.whatToPlay = _audioOutput;

	NSTask *u = [NSTask launchedTaskWithLaunchPath:@"/usr/bin/say" arguments:@[[self.audioOutputURL path]]];
	[u waitUntilExit];
	self.whatToPlay = _audioOutput;
//	AZSpeechSynthesizer *s = [AZSpeechSynthesizer.alloc initWithWords:words andDelegate:self];
//	[_synthesizers addObject:s];
}
- (void) setWhatToPlay:(NSString *)whatToPlay
{
	if (_playerID) {
		NSLog(@"existing playerID: %@", _playerID);
		pjsua_player_id player  = [_playerID integerValue];
		pj_status_t status = pjsua_player_destroy ( player);
		if (status != PJ_SUCCESS) _playerID = nil;
	}
	_whatToPlay = whatToPlay;
	if (_whatToPlay) {
		NSLog(@"supposed to play %@", _whatToPlay);
		pjsua_player_id player_id;
		pjsua_call_id call_id = _call.identifier;
		
		const pj_str_t 	filename = [_whatToPlay pjString];

		pj_status_t status = pjsua_player_create(&filename, 0, &player_id);

		if (status == PJ_SUCCESS)  {
			_playerID = @((int)player_id);
			NSLog(@"playing!  playerID: %@", _playerID);
			status = pjsua_conf_connect(pjsua_player_get_conf_port(player_id),
										pjsua_call_get_conf_port(call_id));
			status == PJ_SUCCESS
			?	NSLog(@"port:%i on callid:%i", player_id, call_id)
			:	NSLog(@"failed to PLAY: port or call fail:  status: %i", status);
		}

	}
}
- (void) setWhereToSave:(NSString *)whereToSave
{
	_whereToSave = whereToSave ?: @"/Users/localadmin/Desktop/record.wav";
//	if (_whereToSave) {
		pjsua_recorder_id * aRecordingID = NULL;
		pj_str_t ff = _whereToSave.pjString;
		pj_status_t status = pjsua_recorder_create(&ff, 0, NULL, 0,	0, aRecordingID);

		if(status != PJ_SUCCESS)	 NSLog(@"cannot create recorder");
		else _recorderID = @((int)aRecordingID);
}
- (SpeechChannel)curSpeechChannel {

	OSErr	theErr = noErr;
	VoiceSpec *voiceSpec = nil;		// Dispose of the current one, if present.
	if (_curSpeechChannel) {			NSLog(@"disposing of speech channel");
		theErr = DisposeSpeechChannel(_curSpeechChannel);
		if (theErr != noErr)			NSRunAlertPanel(@"DisposeSpeechChannel", [NSString stringWithFormat:@"Error #%d returned.", theErr], @"Oh?", NULL, NULL);
		_curSpeechChannel = NULL;
	}	// Create a speech channel
	if (theErr == noErr) {			NSLog(@"creating speech channel");
		theErr = NewSpeechChannel(voiceSpec, &_curSpeechChannel);
		if (theErr != noErr)			NSRunAlertPanel(@"NewSpeechChannel", [NSString stringWithFormat:@"Error #%d returned.", theErr], @"Oh?", NULL, NULL);
	}
	return _curSpeechChannel;
}

@end

/*
	theErr = ExtAudioFileOpenURL((__bridge CFURLRef)filenameurl, &outAudioFile);
	// Handle the error here

		AudioStreamBasicDescription clientASBD = {
			.mSampleRate = 44100,
			.mFormatID = kAudioFormatLinearPCM,
			.mFormatFlags = kAudioFormatFlagsNativeFloatPacked,
			.mBitsPerChannel = sizeof(float) * CHAR_BIT,
			.mChannelsPerFrame = 1,
			.mFramesPerPacket = 1,
			.mBytesPerFrame = sizeof(float),
			.mBytesPerPacket = sizeof(float)
		};

	const char *s = [filename UTF8String];
	CFStringRef url;
	CFURLRef urlformed;
	AudioFileTypeID AudioFileType = 'WAVE';

	AudioStreamBasicDescription myAudioDataFormat = {0};
		myAudioDataFormat.mFormatID = kAudioFormatLinearPCM;
		myAudioDataFormat.mFormatFlags =	kAudioFormatFlagIsSignedInteger|kAudioFormatFlagsNativeEndian |
		kAudioFormatFlagIsPacked;
		myAudioDataFormat.mBytesPerPacket = 4;
		myAudioDataFormat.mFramesPerPacket = 1;
		myAudioDataFormat.mBytesPerFrame = 4;
		myAudioDataFormat.mChannelsPerFrame = 1;
		myAudioDataFormat.mBitsPerChannel = 16;
		myAudioDataFormat.mSampleRate = 44100;

	url = CFStringCreateWithCString(kCFAllocatorSystemDefault, s, kCFStringEncodingUTF8);
	urlformed = CFURLCreateWithFileSystemPath(kCFAllocatorSystemDefault, url, kCFURLPOSIXPathStyle, 0);
	theErr = ExtAudioFileCreateWithURL( urlformed, AudioFileType,&myAudioDataFormat, NULL, kAudioFileFlags_EraseFile, &outAudioFile);

	ExtAudioFileSetProperty(outAudioFile, kExtAudioFileProperty_ClientDataFormat, sizeof(myAudioDataFormat),
							&myAudioDataFormat);

	SetSpeechProperty( self.curSpeechChannel, kSpeechOutputToExtAudioFileProperty,outAudioFile);
//	theErr = SetSpeechInfo(self), 'opax', outAudioFile);
//	theErr = SpeakBuffer(x->speechChannel, x->text, x->textlen, 0);

	char * theTextToSpeak = (char *)[words lossyCString];
	if (theTextToSpeak) {
		theErr = SpeakText(_curSpeechChannel, theTextToSpeak, strlen(theTextToSpeak));
		if (theErr == noErr)  NSLog(@"speaking to file: %@", filename);
		else 			NSRunAlertPanel(@"SpeakText", [NSString stringWithFormat:@"Error #%d returned.", theErr], @"Oh?", NULL, NULL);
	}
	theErr = ExtAudioFileDispose(outAudioFile);
	return filename;

@end

- (void) stopRecording {
	 {
	 pj_status_t status = pjsua_recorder_destroy( 0 );
	 if(status != PJ_SUCCESS)
	 {
	 printf("cannot destroy recorder");
	 }
		int                     CallId, RecorderId;
		char                    FileName[256];
		pj_str_t                wav_files[32];
		pjmedia_port            *media_port;

		//	CallId = atoi(App->GetItemList()->GetItemValue("CallId"));
		//	strcpy(FileName, App->GetItemList()->GetItemValue("FileName"));
		//	wav_files[0]=pj_str(FileName);

		//	pj_status_t pjsua_recorder_create	(	const pj_str_t * 	filename,
		//										 unsigned 	enc_type,
		//										 void * 	enc_param,
		//										 pj_ssize_t 	max_size,
		//										 unsigned 	options,
		//										 pjsua_recorder_id * 	p_id
		//										 )
		//	filename	Output file name. The function will determine the default format to be used based on the file extension. Currently ".wav" is supported on all platforms.
		//	enc_type	Optionally specify the type of encoder to be used to compress the media, if the file can support different encodings. This value must be zero for now.
		//		enc_param	Optionally specify codec specific parameter to be passed to the file writer. For .WAV recorder, this value must be NULL.
		//		max_size	Maximum file size. Specify zero or -1 to remove size limitation. This value must be zero or -1 for now.
		//			options	Optional options.
		//			p_id	Pointer to receive the recorder instance.

		pjsua_recorder_create   (wav_files, 0, NULL, 0, 0,  &RecorderId);
		pjsua_recorder_get_port(RecorderId, &media_port);
		pjsua_conf_connect( pjsua_recorder_get_conf_port(RecorderId),
						   pjsua_call_get_conf_port(CallId) );

		NSLog(@"START_RECORD %s on channel %d
			  recorderid=%d\n", FileName, CallId, RecorderId);

			  Call = this->CallList->GetById(CallId);
			  if (!Call)      {
				  _Logger->Log(LOG_ERROR, "HandleStartRecordMsg : unable
							   to get call [%d]\n", CallId);
							   return;
							   }
							   Call->SetState(CALL_STA_RECORDING);
							   Call->SetRecorderId(RecorderId);
							   Call->SetMaxTime(atoi(App->GetItemList()->GetItemValue("MaxTime")));
							   Call->SetRecordingStartTime(time(NULL));

							   Call->SetTerminationDigits(App->GetItemList()->GetItemValue("TerminationDigits"));
							   Call->ClearDtmfs();
							   
							   }

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

