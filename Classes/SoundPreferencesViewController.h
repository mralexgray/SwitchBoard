//
//  SoundPreferencesViewController.h
//  Telephone

#import <Cocoa/Cocoa.h>

// A view controller to manage sound preferences.
@interface SoundPreferencesViewController : NSViewController

// Outlets.
@property (nonatomic, strong) IBOutlet NSPopUpButton *soundInputPopUp;
@property (nonatomic, strong) IBOutlet NSPopUpButton *soundOutputPopUp;
@property (nonatomic, strong) IBOutlet NSPopUpButton *ringtoneOutputPopUp;
@property (nonatomic, strong) IBOutlet NSPopUpButton *ringtonePopUp;

// Changes sound input and output devices.
- (IBAction)changeSoundIO:(id)sender;

// Refreshes list of available audio devices.
- (void)updateAudioDevices;

// Updates the list of available sounds for a ringtone. Sounds are being searched in the following locations.
// ~/Library/Sounds
// /Library/Sounds
// /Network/Library/Sounds
// /System/Library/Sounds
//
- (void)updateAvailableSounds;

// Changes a ringtone sound.
- (IBAction)changeRingtone:(id)sender;

@end
