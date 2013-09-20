
#import "AZSpeechSynthesizer.h"

//pascal void OurSpeechDoneCallBackProc(SpeechChannel inSpeechChannel, long inRefCon)
//{
//	@autoreleasepool {
//
//		if ( [
//			  //	[(SpeakingTextWindow *)inRefCon performSelectorOnMainThread:@selector(speechIsDone) withObject:NULL waitUntilDone:false];
//	}
//}

@implementation AZSpeechSynthesizer

- (id)init { 	if (self != super.init ) return nil;    queue = dispatch_queue_create("AZTTS", 0);    return self;	}
- (id)initWithWords:(NSString*)words andDelegate:(id)delegate
{
	if (self != super.init ) return nil;
	_delegate 		= delegate;
	_textToSpeak 	= words;
	_finished	 	= NO;
	[self synthesizeSpeech];
	return self;
}
- (void) synthesizeSpeech
{

	OSErr		theErr 	= noErr;
	_audioOutput 		= [[NSFileManager.defaultManager pathForTemporaryFile:NSString.uuidString] stringByAppendingPathExtension:@"wav"];
	_audioOutputURL 	= [NSURL URLWithString:_audioOutput];
	NSLog(@"URL: %@", _audioOutputURL);
	
	SetSpeechProperty( _curSpeechChannel, kSpeechOutputToFileURLProperty,&_audioOutputURL);

	char * theTextToSpeak = (char *)[_textToSpeak lossyCString];
	if (theTextToSpeak)
	{

		NSLog(@"speaking text: %s", theTextToSpeak);
		theErr = SpeakText(_curSpeechChannel, theTextToSpeak, strlen(theTextToSpeak));
		if (theErr == noErr)
			NSLog(@"speaking to file: %@", _audioOutput);
		else
			NSRunAlertPanel(@"SpeakText", [NSString stringWithFormat:@"Error #%d returned.", theErr], @"Oh?", NULL, NULL);
	}

	_outAudioFile = NULL;

	_audioFormat.mFormatID 			= kAudioFormatLinearPCM;
	_audioFormat.mFormatFlags 		=kAudioFormatFlagIsSignedInteger|kAudioFormatFlagsNativeEndian |	kAudioFormatFlagIsPacked;
	_audioFormat.mBytesPerPacket 	= 4;
	_audioFormat.mFramesPerPacket 	= 1;
	_audioFormat.mBytesPerFrame 	= 4;
	_audioFormat.mChannelsPerFrame = 1;
	_audioFormat.mBitsPerChannel 	= 16;
	_audioFormat.mSampleRate 		= 44100;

	theErr = ExtAudioFileCreateWithURL((__bridge CFURLRef)_audioOutputURL, kAudioFileWAVEType,
									   &_audioFormat, NULL, NULL, // kAudioFileFlags_EraseFile,
									   &_outAudioFile);
	if (!theErr) audioFileOwned = YES;
	else NSLog(@"problem creating audo output file");

	_curSpeechChannel = [self curSpeechChannel];
	SetSpeechProperty( _curSpeechChannel, kSpeechOutputToExtAudioFileProperty,_outAudioFile);

	char * theTextToSpeak = (char *)[_textToSpeak lossyCString];
	if (theTextToSpeak)
	{

		NSLog(@"speaking text: %s", theTextToSpeak);
		theErr = SpeakText(_curSpeechChannel, theTextToSpeak, strlen(theTextToSpeak));
		if (theErr == noErr)
				NSLog(@"speaking to file: %@", _audioOutput);
		else
			NSRunAlertPanel(@"SpeakText", [NSString stringWithFormat:@"Error #%d returned.", theErr], @"Oh?", NULL, NULL);
	}
	theErr = ExtAudioFileDispose(_outAudioFile);
	if ([_delegate respondsToSelector:@selector(speechIsReadyFor:)])
		[_delegate speechIsReadyFor:self];

}
- (void)disposeSoundChannel
{
	dispatch_sync(queue, ^{
        if (audioFileRef) {
            if (audioFileOwned)
                ExtAudioFileDispose(audioFileRef);
            audioFileRef 	= 0;
            audioFileOwned 	= NO;
        }
	});
}
- (SpeechChannel)curSpeechChannel {

	OSErr	theErr = noErr;
	VoiceSpec *voiceSpec = nil;

	// Dispose of the current one, if present.
	if (_curSpeechChannel) {
		NSLog(@"disposing of speech channel");
		theErr = DisposeSpeechChannel(_curSpeechChannel);
		if (theErr != noErr)
			NSRunAlertPanel(@"DisposeSpeechChannel", [NSString stringWithFormat:@"Error #%d returned.", theErr], @"Oh?", NULL, NULL);
		_curSpeechChannel = NULL;
	}

	// Create a speech channel
	if (theErr == noErr) {
		NSLog(@"creating speech channel");
		theErr = NewSpeechChannel(voiceSpec, &_curSpeechChannel);
		if (theErr != noErr)
			NSRunAlertPanel(@"NewSpeechChannel", [NSString stringWithFormat:@"Error #%d returned.", theErr], @"Oh?", NULL, NULL);
	}
	return _curSpeechChannel;
}

@end
		

//
// Callback routines
//

//
//			AN	IMPORTANT NOTE ABOUT CALLBACKS AND THREADS
//
// All speech synthesis callbacks, except for the Text Done callback, call their specified routine on a
// thread other than the main thread.  Performing certain actions directly from a speech synthesis callback
// routine may cause your program to crash without certain safe gaurds.	 In this example, we use the NSThread
// method performSelectorOnMainThread:withObject:waitUntilDone: to safely update the user interface and
// interact with our objects using only the main thread.
//
// Depending on your needs you may be able to specify your Cocoa application is multiple threaded
// then preform actions directly from the speech synthesis callback routines.  To indicate your Cocoa
// application is mulitthreaded, call the following line before calling speech synthesis routines for
// the first time:
//
//	  [NSThread detachNewThreadSelector:@selector(self) toTarget:self withObject:nil];
//
//Called by speech channel when all text has been processed.	Additional text can be passed back to continue processing.
/**
pascal void OurTextDoneCallBackProc(SpeechChannel inSpeechChannel, long inRefCon, const void ** nextBuf, unsigned long * byteLen, long * controlFlags)
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	*nextBuf = NULL;

	if ([(SpeakingTextWindow *)inRefCon shouldDisplayTextDoneCallbacks])
		[(SpeakingTextWindow *)inRefCon performSelectorOnMainThread:@selector(displayTextDoneAlert) withObject:NULL waitUntilDone:false];

	[pool release];
}

//Called by speech channel when all speech has been generated.
pascal void OurSpeechDoneCallBackProc(SpeechChannel inSpeechChannel, long inRefCon)
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	[(SpeakingTextWindow *)inRefCon performSelectorOnMainThread:@selector(speechIsDone) withObject:NULL waitUntilDone:false];

	[pool release];
}

*/

void writeNoiseToAudioFile(char *fName,int mChannels,bool compress_with_m4a)
{
	OSStatus err; // to record errors from ExtAudioFile API functions

	// create file path as CStringRef
	CFStringRef fPath;
	fPath = CFStringCreateWithCString(kCFAllocatorDefault,
									  fName,
									  kCFStringEncodingMacRoman);

	// specify total number of samples per channel
	UInt32 totalFramesInFile = 100000;

	/////////////////////////////////////////////////////////////////////////////
	////////////// Set up Audio Buffer List For Interleaved Audio ///////////////
	/////////////////////////////////////////////////////////////////////////////

	AudioBufferList outputData;
	outputData.mNumberBuffers = 1;
	outputData.mBuffers[0].mNumberChannels = mChannels;
	outputData.mBuffers[0].mDataByteSize = sizeof(AudioUnitSampleType)*totalFramesInFile*mChannels;
	outputData.mBuffers[0].mData = malloc(mChannels*totalFramesInFile * sizeof(AudioUnitSampleType));

	/////////////////////////////////////////////////////////////////////////////
	//////// Synthesise Noise and Put It In The AudioBufferList /////////////////
	/////////////////////////////////////////////////////////////////////////////

	// create an array to hold our audio
	AudioUnitSampleType audioFile[totalFramesInFile*mChannels];

	// fill the array with random numbers (white noise)
	for (int i = 0;i < totalFramesInFile*mChannels;i++)
	{
		audioFile[i] = ((AudioUnitSampleType)(rand() % 100))/100.0;
		audioFile[i] = audioFile[i]*0.2;
		// (yes, I know this noise has a DC offset, bad)
	}

	// set the AudioBuffer to point to the array containing the noise
	outputData.mBuffers[0].mData = &audioFile;

	/////////////////////////////////////////////////////////////////////////////
	////////////////// Specify The Output Audio File Format /////////////////////
	/////////////////////////////////////////////////////////////////////////////

	// the client format will describe the output audio file
	AudioStreamBasicDescription clientFormat;

	// the file type identifier tells the ExtAudioFile API what kind of file we want created
	AudioFileTypeID fileType;

	// if compress_with_m4a is tru then set up for m4a file format
	if (compress_with_m4a)
	{
		// the file type identifier tells the ExtAudioFile API what kind of file we want created
		// this creates a m4a file type
		fileType = kAudioFileM4AType;

		// Here we specify the M4A format
		clientFormat.mSampleRate         = 44100.0;
		clientFormat.mFormatID           = kAudioFormatMPEG4AAC;
		clientFormat.mFormatFlags        = kMPEG4Object_AAC_Main;
		clientFormat.mChannelsPerFrame   = mChannels;
		clientFormat.mBytesPerPacket     = 0;
		clientFormat.mBytesPerFrame      = 0;
		clientFormat.mFramesPerPacket    = 1024;
		clientFormat.mBitsPerChannel     = 0;
		clientFormat.mReserved           = 0;
	}
	else // else encode as PCM
	{
		// this creates a wav file type
		fileType = kAudioFileWAVEType;

		// This function audiomatically generates the audio format according to certain arguments
		//		FillOutASBDForLPCM(clientFormat,44100.0,mChannels,32,32,true,false,false);
		//		FillOutASBDForLPCM(AudioStreamBasicDescription& outASBD, Float64 inSampleRate, UInt32 inChannelsPerFrame, UInt32 inValidBitsPerChannel, UInt32 inTotalBitsPerChannel, bool inIsFloat, bool inIsBigEndian, bool inIsNonInterleaved = false)    { outASBD.mSampleRate = inSampleRate; outASBD.mFormatID = kAudioFormatLinearPCM; outASBD.mFormatFlags = CalculateLPCMFlags(inValidBitsPerChannel, inTotalBitsPerChannel, inIsFloat, inIsBigEndian, inIsNonInterleaved); outASBD.mBytesPerPacket = (inIsNonInterleaved ? 1 : inChannelsPerFrame) * (inTotalBitsPerChannel / 8); outASBD.mFramesPerPacket = 1; outASBD.mBytesPerFrame = (inIsNonInterleaved ? 1 : inChannelsPerFrame) * (inTotalBitsPerChannel / 8); outASBD.mChannelsPerFrame = inChannelsPerFrame; outASBD.mBitsPerChannel = inValidBitsPerChannel; }
	}

	/////////////////////////////////////////////////////////////////////////////
	///////////////// Specify The Format of Our Audio Samples ///////////////////
	/////////////////////////////////////////////////////////////////////////////

	// the local format describes the format the samples we will give to the ExtAudioFile API
	AudioStreamBasicDescription localFormat;
	//	FillOutASBDForLPCM (localFormat,44100.0,mChannels,32,32,true,false,false);

	/////////////////////////////////////////////////////////////////////////////
	///////////////// Create the Audio File and Open It /////////////////////////
	/////////////////////////////////////////////////////////////////////////////

	// create the audio file reference
	ExtAudioFileRef audiofileRef;

	// create a fileURL from our path
	CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault,fPath,kCFURLPOSIXPathStyle,false);

	// open the file for writing
	err = ExtAudioFileCreateWithURL((CFURLRef)fileURL, fileType, &clientFormat, NULL, kAudioFileFlags_EraseFile, &audiofileRef);

	//	if (err != noErr)	{		cout << "Problem when creating audio file: " << err << "\n";	}

	/////////////////////////////////////////////////////////////////////////////
	///// Tell the ExtAudioFile API what format we'll be sending samples in /////
	/////////////////////////////////////////////////////////////////////////////

	// Tell the ExtAudioFile API what format we'll be sending samples in
	err = ExtAudioFileSetProperty(audiofileRef, kExtAudioFileProperty_ClientDataFormat, sizeof(localFormat), &localFormat);

	//	if (err != noErr)	{		cout << "Problem setting audio format: " << err << "\n";	}

	/////////////////////////////////////////////////////////////////////////////
	///////// Write the Contents of the AudioBufferList to the AudioFile ////////
	/////////////////////////////////////////////////////////////////////////////

	UInt32 rFrames = (UInt32)totalFramesInFile;
	// write the data
	err = ExtAudioFileWrite(audiofileRef, rFrames, &outputData);

	//	if (err != noErr)	{		cout << "Problem writing audio file: " << err << "\n";	}

	/////////////////////////////////////////////////////////////////////////////
	////////////// Close the Audio File and Get Rid Of The Reference ////////////
	/////////////////////////////////////////////////////////////////////////////

	// close the file
	ExtAudioFileDispose(audiofileRef);
	
	
	NSLog(@"Done!");
}
