//
//  NSDictionary+NSDictionary_NTExtensions.m
//  DynamicOCThread
//
//  Created by Ding Orlando on 11/30/13.
//  Copyright (c) 2013 llv22. All rights reserved.
//

#import "NSDictionary+NSDictionary_NTExtensions.h"

@implementation NSDictionary (NSDictionary_NTExtensions)

- (NSString*)stringForKey:(NSString*)key;
{
	id obj = [self objectForKey:key];
	
	if ([obj isKindOfClass:[NSString class]])
		return obj;
	
	return nil;
}

- (id)objectForKey:(NSString *)key defaultObject:(id)defaultObject;
{
    id value;
	
    value = [self objectForKey:key];
    if (value)
        return value;
    return defaultObject;
}

- (NSArray*)arrayForKey:(NSString*)key;
{
	id obj = [self objectForKey:key];
	
	if ([obj isKindOfClass:[NSArray class]])
		return obj;
	
	return nil;
}

- (id)keyForObjectIdenticalTo:(id)object;
{
	NSEnumerator *enumerator = [self keyEnumerator];
	id key;
	
	while (key = [enumerator nextObject])
	{
		if ([self objectForKey:key] == object)
			return key;
	}
	
	return nil;
}

- (NSMutableDictionary*)deepMutableCopy;
{
    NSMutableDictionary *newDictionary;
    NSEnumerator *keyEnumerator;
    id anObject;
    id aKey;
	
    newDictionary = [self mutableCopy];
    // Run through the new dictionary and replace any objects that respond to -deepMutableCopy or -mutableCopy with copies.
    keyEnumerator = [self keyEnumerator];
    while ((aKey = [keyEnumerator nextObject])) {
        anObject = [newDictionary objectForKey:aKey];
        if ([anObject respondsToSelector:@selector(deepMutableCopy)]) {
            anObject = [anObject deepMutableCopy];
            [newDictionary setObject:anObject forKey:aKey];
//            [anObject release];
        } else if ([anObject conformsToProtocol:@protocol(NSMutableCopying)]) {
            anObject = [anObject mutableCopy];
            [newDictionary setObject:anObject forKey:aKey];
//            [anObject release];
        }
    }
	
    return newDictionary;
}

- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
{
    id value = [self objectForKey:key];
	
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
        return [value boolValue];
	
    return defaultValue;
}

- (BOOL)boolForKey:(NSString *)key;
{
    return [self boolForKey:key defaultValue:NO];
}

- (int)intForKey:(NSString *)key defaultValue:(int)defaultValue;
{
    id value;
	
    value = [self objectForKey:key];
    if (!value)
        return defaultValue;
    return [value intValue];
}

- (int)intForKey:(NSString *)key;
{
    return [self intForKey:key defaultValue:0];
}

@end
