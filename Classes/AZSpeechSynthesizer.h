//
//  AZSpeechSynthesizer.h
//  Telephone
//
//  Created by Alex Gray on 04/03/2013.
//
//

#import <Foundation/Foundation.h>
#include <CoreAudio/CoreAudio.h>
#include <AudioToolbox/AudioToolbox.h>
#include <dispatch/dispatch.h>

@class AZSpeechSynthesizer;
@protocol AZSpeechDelegate <NSObject>
- (void) speechIsReadyFor:(AZSpeechSynthesizer*)synth;
@end

@interface AZSpeechSynthesizer : NSObject

@property (nonatomic, assign) ExtAudioFileRef 				outAudioFile;
@property (nonatomic, assign) AudioStreamBasicDescription 	audioFormat;
@property (nonatomic, assign) SpeechChannel					curSpeechChannel;
@property (readonly) 		  SpeechTextDoneProcPtr *speechDone;
@property (nonatomic, retain) NSString * voiceName, *textToSpeak, *audioOutput;
@property (nonatomic, retain) NSURL *audioOutputURL;

@property (nonatomic, weak) id <AZSpeechDelegate> delegate;

@property (nonatomic, assign) BOOL finished;

- (id)initWithWords:(NSString*)words andDelegate:(id)delegate;
//- (long)useVoice:(VoiceSpec *)voice withBundle:(CFBundleRef)inVoiceSpecBundle;
@end

// Private: state
enum SynthState {
	kSynthStopped,	// Ready for next speech call
	kSynthRunning,	// Generating audio
	kSynthPaused,	// More tokens available, but paused
	kSynthStopping,	// Stop after generating next batch of samples
	kSynthPausing	// Pause after generating next batch of samples
};

@interface AZSpeechSynthesizer ()
{
	// Synthesizer state (applicable to most synthesizers)
	int					synthState;
	float				speechRate;
	float				pitchBase;
	float				volume;
	CFStringRef			openDelim;
	CFStringRef			closeDelim;
	SRefCon				clientRefCon;
	CFStringRef			textBeingSpoken;
	// Audio output state (applicable to most synthesizers)
	ExtAudioFileRef		audioFileRef;	    // Audio file to save to
	bool				audioFileOwned;		// Did we open it?
	// Callbacks
	SpeechTextDoneProcPtr	textDoneCallback;	// Callback to call when we no longer need the input text
	SpeechDoneProcPtr		speechDoneCallback;	// Callback to call when we're done
	SpeechSyncProcPtr		syncCallback;		// Callback to call for sync embedded command
	SpeechWordCFProcPtr		wordCallback;		// Callback to call for each word
	// We work through a dispatch queue. It's the modern thing to do
	dispatch_queue_t	queue;
	dispatch_source_t	generateSamples;
}
- (void)createSoundChannel:(BOOL)forAudioUnit;
- (void)disposeSoundChannel;

@end
