//
//  AKSIPURIFormatter.m
//  Telephone

#import "AKSIPURIFormatter.h"

#import "AKNSString+Scanning.h"
#import "AKSIPURI.h"
#import "AKTelephoneNumberFormatter.h"

@implementation AKSIPURIFormatter

- (NSString *)stringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[AKSIPURI class]]) {
        return nil;
    }
	NSString *returnValue = nil;
	if ([[anObject displayName] length] > 0) {
        returnValue = [anObject displayName];
        
    } else if ([[anObject user] length] > 0) {
        if ([[anObject user] ak_isTelephoneNumber]) {
            if ([self formatsTelephoneNumbers]) {
                AKTelephoneNumberFormatter *telephoneNumberFormatter
                    = [[AKTelephoneNumberFormatter alloc] init];
                
                [telephoneNumberFormatter setSplitsLastFourDigits:[self telephoneNumberFormatterSplitsLastFourDigits]];
                
                returnValue = [telephoneNumberFormatter stringForObjectValue:[anObject user]];
            } else {
                returnValue = [anObject user];
            }
        } else {
            returnValue = [anObject SIPAddress];
        }
    } else {
        returnValue = [anObject host];
    }
	return returnValue;
}
- (BOOL)getObjectValue:(id *)anObject forString:(NSString *)string errorDescription:(NSString **)error {
    BOOL returnValue = NO;
    AKSIPURI *theURI;
    NSString *name, *destination, *user, *host;
    NSRange delimiterRange, atSignRange;
	theURI = [AKSIPURI SIPURIWithString:string];
	if (theURI == nil) {
        if ([[NSPredicate predicateWithFormat:@"SELF MATCHES '.+\\\\s\\\\(.+\\\\)'"] evaluateWithObject:string]) {
            // The string is in format |Destination (Display Name)|.
            
            delimiterRange = [string rangeOfString:@" (" options:NSBackwardsSearch];
            
            destination = [string substringToIndex:delimiterRange.location];
            atSignRange = [destination rangeOfString:@"@" options:NSBackwardsSearch];
            if (atSignRange.location == NSNotFound) {
                user = destination;
                host = nil;
            } else {
                user = [destination substringToIndex:atSignRange.location];
                host = [destination substringFromIndex:(atSignRange.location + 1)];
            }
            
            NSRange nameRange = NSMakeRange(delimiterRange.location + 2,
                                            [string length] - (delimiterRange.location + 2) - 1);
            name = [string substringWithRange:nameRange];
            
            theURI = [AKSIPURI SIPURIWithUser:user host:host displayName:name];
            
        } else if ([[NSPredicate predicateWithFormat:@"SELF MATCHES '.+\\\\s<.+>'"] evaluateWithObject:string]) {
            // The string is in format |Display Name <Destination>|.
            
            delimiterRange = [string rangeOfString:@" <" options:NSBackwardsSearch];
            
            NSMutableCharacterSet *trimmingCharacterSet = [[NSCharacterSet whitespaceCharacterSet] mutableCopy];
            [trimmingCharacterSet addCharactersInString:@"\""];
            name = [[string substringToIndex:delimiterRange.location]
                    stringByTrimmingCharactersInSet:trimmingCharacterSet];
            
            NSRange destinationRange = NSMakeRange(delimiterRange.location + 2,
                                                   [string length] - (delimiterRange.location + 2) - 1);
            destination = [string substringWithRange:destinationRange];
            
            atSignRange = [destination rangeOfString:@"@" options:NSBackwardsSearch];
            if (atSignRange.location == NSNotFound) {
                user = destination;
                host = nil;
            } else {
                user = [destination substringToIndex:atSignRange.location];
                host = [destination substringFromIndex:(atSignRange.location + 1)];
            }
            
            theURI = [AKSIPURI SIPURIWithUser:user host:host displayName:name];
            
        } else {
            destination = string;
            atSignRange = [destination rangeOfString:@"@" options:NSBackwardsSearch];
            if (atSignRange.location == NSNotFound) {
                user = destination;
                host = nil;
            } else {
                user = [destination substringToIndex:atSignRange.location];
                host = [destination substringFromIndex:(atSignRange.location + 1)];
            }
            
            theURI = [AKSIPURI SIPURIWithUser:user host:host displayName:nil];
        }
    }
	if (theURI != nil) {
        returnValue = YES;
        if (anObject != NULL) {
            *anObject = theURI;
        }
    } else {
        if (error != NULL) {
            *error = [NSString stringWithFormat:@"Couldn't convert \"%@\" to SIP URI", string];
        }
    }
	return returnValue;
}
- (AKSIPURI *)SIPURIFromString:(NSString *)SIPURIString {
    AKSIPURI *uri;
    NSString *error;
	BOOL converted = [self getObjectValue:&uri forString:SIPURIString errorDescription:&error];
	if (converted) {
        return uri;
    } else {
        NSLog(@"%@", error);
        return nil;
    }
}

@end
