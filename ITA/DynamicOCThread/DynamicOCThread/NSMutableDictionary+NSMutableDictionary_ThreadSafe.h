//
//  NSMutableDictionary+NSMutableDictionary_ThreadSafe.h
//  DynamicOCThread
//
//  Created by Ding Orlando on 11/30/13.
//  Copyright (c) 2013 llv22. All rights reserved.
//  see http://recon-mac.googlecode.com/svn/trunk/recon-mac/Vendor/Path%20Finder%20SDK/Source/CocoatechCore/NSMutableDictionary-ThreadSafe.h
//

#import <Foundation/Foundation.h>

@protocol NSMutableDictionaryThreadSafeProtocol <NSObject>

- (id)safeObjectForKey:(id)aKey;

- (void)safeRemoveObjectForKey:(id)aKey;
- (void)safeRemoveObjectsForKeys:(NSArray*)keys;
- (void)safeRemoveAllObjects;
- (void)safeRemoveObject:(id)anObject;
- (void)safeRemoveObjects:(NSArray*)objects;

- (void)safeSetObject:(id)anObject
               forKey:(id)aKey;

// returns a copy of the array
- (NSArray*)safeAllValues;
- (NSArray*)safeAllKeys;

- (NSEnumerator*)safeKeyEnumerator;
- (NSEnumerator*)safeObjectEnumerator;

- (unsigned long)safeCount;

- (NSString*)safeKeyForObjectIdenticalTo:(id)anObject;

@end

@interface NSMutableDictionary (NSMutableDictionary_ThreadSafe) <NSMutableDictionaryThreadSafeProtocol>

@end
