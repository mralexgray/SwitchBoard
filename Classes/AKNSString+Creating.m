//
//  AKNSString+Creating.m
//  Telephone


#import "AKNSString+Creating.h"

@implementation NSString (AKStringCreatingAdditions)

+ (NSString *)ak_uuidString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
	return (__bridge NSString*)string;
}

@end
