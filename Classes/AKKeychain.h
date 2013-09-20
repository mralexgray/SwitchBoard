//
//  AKKeychain.h
//  Telephone

#import <Foundation/Foundation.h>

// A Keychain Services wrapper.
@interface AKKeychain : NSObject

// Returns password for the first Keychain item with a specified service name and account name.
+ (NSString *)passwordForServiceName:(NSString *)serviceName accountName:(NSString *)accountName;

// Adds an item to the Keychain with a specified service name, account name, and password. If the same item already
// exists, its password will be replaced with the new one.
+ (BOOL)addItemWithServiceName:(NSString *)serviceName
                   accountName:(NSString *)accountName
                      password:(NSString *)password;

@end
