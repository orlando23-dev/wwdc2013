//
//  NSDictionary+NSDictionary_NTExtensions.h
//  DynamicOCThread
//
//  Created by Ding Orlando on 11/30/13.
//  Copyright (c) 2013 llv22. All rights reserved.
//
//  see http://recon-mac.googlecode.com/svn/trunk/recon-mac/Vendor/Path%20Finder%20SDK/Source/CocoatechCore/NSDictionary-NTExtensions.h
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSDictionary_NTExtensions)

- (NSString*)stringForKey:(NSString*)key;
- (NSArray*)arrayForKey:(NSString*)key;

- (id)keyForObjectIdenticalTo:(id)object;

- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (BOOL)boolForKey:(NSString *)key;

- (int)intForKey:(NSString *)key;
- (int)intForKey:(NSString *)key defaultValue:(int)defaultValue;

- (NSMutableDictionary*)deepMutableCopy;
- (id)objectForKey:(NSString *)key defaultObject:(id)defaultObject;

@end
