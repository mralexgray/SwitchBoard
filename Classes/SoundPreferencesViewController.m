//
//  SoundPreferencesViewController.m
//  Telephone

#import "SoundPreferencesViewController.h"

#import "AppController.h"
#import "PreferencesController.h"

@implementation SoundPreferencesViewController

- (id)init {
    self = [super initWithNibName:@"SoundPreferencesView" bundle:nil];
    if (self != nil) {
        [self setTitle:NSLocalizedString(@"Sound", @"Sound preferences window title.")];
    }
	return self;
}
- (void)awakeFromNib {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    // Subscribe on mouse-down event of the ringing sound selection.
    [notificationCenter addObserver:self
                           selector:@selector(popUpButtonWillPopUp:)
                               name:NSPopUpButtonWillPopUpNotification
                             object:[self ringtonePopUp]];
    
    [self updateAvailableSounds];
    [self updateAudioDevices];
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (IBAction)changeSoundIO:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[[self soundInputPopUp] titleOfSelectedItem] forKey:kSoundInput];
    [defaults setObject:[[self soundOutputPopUp] titleOfSelectedItem] forKey:kSoundOutput];
    [defaults setObject:[[self ringtoneOutputPopUp] titleOfSelectedItem] forKey:kRingtoneOutput];
    
    [[NSApp delegate] selectSoundIO];
}
- (void)updateAudioDevices {
    // Populate sound IO pop-up buttons.
    NSArray *audioDevices = [[NSApp delegate] audioDevices];
    NSMenu *soundInputMenu = [[NSMenu alloc] init];
    NSMenu *soundOutputMenu = [[NSMenu alloc] init];
    NSMenu *ringtoneOutputMenu = [[NSMenu alloc] init];
    
    for (NSUInteger i = 0; i < [audioDevices count]; ++i) {
        NSDictionary *deviceDict = audioDevices[i];
        
        NSMenuItem *aMenuItem = [[NSMenuItem alloc] init];
        [aMenuItem setTitle:deviceDict[kAudioDeviceName]];
        [aMenuItem setTag:i];
        
        if ([deviceDict[kAudioDeviceInputsCount] integerValue] > 0) {
            [soundInputMenu addItem:[aMenuItem copy]];
        }
        
        if ([deviceDict[kAudioDeviceOutputsCount] integerValue] > 0) {
            [soundOutputMenu addItem:[aMenuItem copy]];
            [ringtoneOutputMenu addItem:[aMenuItem copy]];
        }
        
    }
    
    [[self soundInputPopUp] setMenu:soundInputMenu];
    [[self soundOutputPopUp] setMenu:soundOutputMenu];
    [[self ringtoneOutputPopUp] setMenu:ringtoneOutputMenu];
    
    // Select saved sound devices.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lastSoundInput = [defaults stringForKey:kSoundInput];
    if (lastSoundInput != nil && [[self soundInputPopUp] itemWithTitle:lastSoundInput] != nil) {
        [[self soundInputPopUp] selectItemWithTitle:lastSoundInput];
    }
    
    NSString *lastSoundOutput = [defaults stringForKey:kSoundOutput];
    if (lastSoundOutput != nil && [[self soundOutputPopUp] itemWithTitle:lastSoundOutput] != nil) {
        [[self soundOutputPopUp] selectItemWithTitle:lastSoundOutput];
    }
    
    NSString *lastRingtoneOutput = [defaults stringForKey:kRingtoneOutput];
    if (lastRingtoneOutput != nil && [[self ringtoneOutputPopUp] itemWithTitle:lastRingtoneOutput] != nil) {
        [[self ringtoneOutputPopUp] selectItemWithTitle:lastRingtoneOutput];
    }
}
- (void)updateAvailableSounds {
    NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSAllDomainsMask, YES);
    if ([libraryPaths count] <= 0) {
        return;
    }
    
    NSMenu *soundsMenu = [[NSMenu alloc] init];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSSet *allowedSoundFileExtensions = [NSSet setWithObjects:@"aiff", @"aif", @"aifc",
                                         @"mp3", @"wav", @"sd2", @"au", @"snd", @"m4a", @"m4p", nil];
    
    for (NSUInteger i = 0; i < [libraryPaths count]; ++i) {
        NSString *aPath = libraryPaths[i];
        NSString *soundPath = [aPath stringByAppendingPathComponent:@"Sounds"];
        NSArray *soundFiles = [fileManager contentsOfDirectoryAtPath:soundPath error:NULL];
        
        BOOL shouldAddSeparator = ([soundsMenu numberOfItems] > 0) ? YES : NO;
        
        for (NSUInteger j = 0; j < [soundFiles count]; ++j) {
            NSString *aFile = soundFiles[j];
            if (![allowedSoundFileExtensions containsObject:[aFile pathExtension]]) {
                continue;
            }
            
            NSString *aSound = [aFile stringByDeletingPathExtension];
            if ([soundsMenu itemWithTitle:aSound] == nil) {
                if (shouldAddSeparator) {
                    [soundsMenu addItem:[NSMenuItem separatorItem]];
                    shouldAddSeparator = NO;
                }
                
                NSMenuItem *aMenuItem = [[NSMenuItem alloc] init];
                [aMenuItem setTitle:aSound];
                [soundsMenu addItem:aMenuItem];
            }
        }
    }
    
    [[self ringtonePopUp] setMenu:soundsMenu];
    
    NSString *savedSound = [[NSUserDefaults standardUserDefaults] stringForKey:kRingingSound];
    
    if ([soundsMenu itemWithTitle:savedSound] != nil) {
        [[self ringtonePopUp] selectItemWithTitle:savedSound];
    }
}
- (IBAction)changeRingtone:(id)sender {
    [[[NSApp delegate] ringtone] stop];
    
    NSString *soundName = [sender title];
    [[NSUserDefaults standardUserDefaults] setObject:soundName forKey:kRingingSound];
    [[NSApp delegate] setRingtone:[NSSound soundNamed:soundName]];
    
    // Play selected ringtone once.
    [[[NSApp delegate] ringtone] play];
}

#pragma mark -
#pragma mark NSPopUpButton notification

- (void)popUpButtonWillPopUp:(NSNotification *)notification {
    [self updateAvailableSounds];
}

@end
