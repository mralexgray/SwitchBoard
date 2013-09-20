//
//  AKNSString+Creating.h
//  Telephone


#import <Foundation/Foundation.h>

// A category for creating strings.
@interface NSString (AKStringCreatingAdditions)

// Returns a newly created UUID string.
+ (NSString *)ak_uuidString;

@end
