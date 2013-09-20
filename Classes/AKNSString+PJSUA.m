//
//  AKNSString+PJSUA.m
//  Telephone

#import "AKNSString+PJSUA.h"

@implementation NSString (AKStringPJSUAAdditions)

+ (NSString *)stringWithPJString:(pj_str_t)pjString {
    return [[NSString alloc] initWithBytes:pjString.ptr
                                     length:(NSUInteger)pjString.slen
                                   encoding:NSUTF8StringEncoding];
}
- (pj_str_t)pjString {
    return pj_str((char *)[self cStringUsingEncoding:NSUTF8StringEncoding]);
}
+ (NSString *)uuidString {
	// Returns a UUID

	CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
	NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
	CFRelease(uuid);

	return uuidStr;
}

@end
