//
//  PreferencesController.h
//  Telephone

#import <Cocoa/Cocoa.h>

// Preferences window toolbar items tags.
enum {
    kGeneralPreferencesTag  = 0,
    kAccountsPreferencesTag = 1,
    kSoundPreferencesTag    = 2,
    kNetworkPreferencesTag  = 3
};

// Keys for defaults
//
extern NSString * const kAccounts;
extern NSString * const kSTUNServerHost;
extern NSString * const kSTUNServerPort;
extern NSString * const kSTUNDomain;
extern NSString * const kLogFileName;
extern NSString * const kLogLevel;
extern NSString * const kConsoleLogLevel;
extern NSString * const kVoiceActivityDetection;
extern NSString * const kTransportPort;
extern NSString * const kTransportPublicHost;
extern NSString * const kSoundInput;
extern NSString * const kSoundOutput;
extern NSString * const kRingtoneOutput;
extern NSString * const kRingingSound;
extern NSString * const kFormatTelephoneNumbers;
extern NSString * const kTelephoneNumberFormatterSplitsLastFourDigits;
extern NSString * const kOutboundProxyHost;
extern NSString * const kOutboundProxyPort;
extern NSString * const kUseICE;
extern NSString * const kUseDNSSRV;
extern NSString * const kSignificantPhoneNumberLength;
extern NSString * const kPauseITunes;
extern NSString * const kAutoCloseCallWindow;
extern NSString * const kAutoCloseMissedCallWindow;
extern NSString * const kCallWaiting;
//
// Account keys
extern NSString * const kDescription;
extern NSString * const kFullName;
extern NSString * const kSIPAddress;
extern NSString * const kRegistrar;
extern NSString * const kDomain;
extern NSString * const kRealm;
extern NSString * const kUsername;
extern NSString * const kAccountIndex;
extern NSString * const kAccountEnabled;
extern NSString * const kReregistrationTime;
extern NSString * const kSubstitutePlusCharacter;
extern NSString * const kPlusCharacterSubstitutionString;
extern NSString * const kUseProxy;
extern NSString * const kProxyHost;
extern NSString * const kProxyPort;

extern NSString * const kSourceIndex;
extern NSString * const kDestinationIndex;

// Notifications.
//
// Sent when preferences controller removes an accont.
// |userInfo| dictionary key: AKAccountIndex.
extern NSString * const AKPreferencesControllerDidRemoveAccountNotification;
//
// Sent when preferences controller enables or disables an account.
// |userInfo| dictionary key: AKAccountIndex.
extern NSString * const AKPreferencesControllerDidChangeAccountEnabledNotification;
//
// Sent when preferences controller changes account order.
// |userInfo| dictionary keys: AKSourceIndex, AKDestinationIndex.
extern NSString * const AKPreferencesControllerDidSwapAccountsNotification;
//
// Sent when preferences controller changes network settings.
extern NSString * const AKPreferencesControllerDidChangeNetworkSettingsNotification;

@class GeneralPreferencesViewController, AccountPreferencesViewController;
@class SoundPreferencesViewController, NetworkPreferencesViewController;

// A preferences controller.
@interface PreferencesController : NSWindowController

// The receiver's delegate.
@property (nonatomic, unsafe_unretained) id delegate;

// General preferences view controller.
@property (nonatomic, readonly) GeneralPreferencesViewController *generalPreferencesViewController;

// Account preferences view controller.
@property (nonatomic, readonly) AccountPreferencesViewController *accountPreferencesViewController;

// Sound preferences view controller.
@property (nonatomic, readonly) SoundPreferencesViewController *soundPreferencesViewController;

// Network preferences view controller.
@property (nonatomic, readonly) NetworkPreferencesViewController *networkPreferencesViewController;

// Outlets.
//
@property (nonatomic, strong) IBOutlet NSToolbar *toolbar;
@property (nonatomic, strong) IBOutlet NSToolbarItem *generalToolbarItem;
@property (nonatomic, strong) IBOutlet NSToolbarItem *accountsToolbarItem;
@property (nonatomic, strong) IBOutlet NSToolbarItem *soundToolbarItem;
@property (nonatomic, strong) IBOutlet NSToolbarItem *networkToolbarItem;

// Changes window's content view.
- (IBAction)changeView:(id)sender;

@end
