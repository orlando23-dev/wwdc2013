//
//  NSMutableDictionary+NSMutableDictionary_ThreadSafe.m
//  DynamicOCThread
//
//  Created by Ding Orlando on 11/30/13.
//  Copyright (c) 2013 llv22. All rights reserved.
//

#import "NSMutableDictionary+NSMutableDictionary_ThreadSafe.h"
#import "NSDictionary+NSDictionary_NTExtensions.h"

@implementation NSMutableDictionary (NSMutableDictionary_ThreadSafe)

- (id)safeObjectForKey:(id)aKey;
{
    id result=nil;
	
	if (aKey)
	{
		@synchronized(self) {
			result = [self objectForKey:aKey];
			
			// for thread safety
//			result = [[result retain] autorelease];
		}
	}
	
    return result;
}

- (void)safeRemoveObjectForKey:(id)aKey;
{
	if (aKey)
	{
		@synchronized(self) {
			[self removeObjectForKey:aKey];
		}
	}
}

- (void)safeRemoveObjectsForKeys:(NSArray*)keys;
{
	NSString* key;
	
	@synchronized(self) {
		NSEnumerator *enumerator = [keys objectEnumerator];
        
		while (key = [enumerator nextObject])
			[self removeObjectForKey:key];
	}
}

- (void)safeRemoveAllObjects;
{
    @synchronized(self) {
		[self removeAllObjects];
    }
}

- (void)safeRemoveObject:(id)anObject;
{
	if (anObject)
	{
		@synchronized(self) {
			NSString *key = [self keyForObjectIdenticalTo:anObject];
			
			if (key){
				[self removeObjectForKey:key];
            }
		}
	}
}

- (void)safeRemoveObjects:(NSArray*)objects;
{
	@synchronized(self) {
		NSEnumerator *enumerator = [objects objectEnumerator];
		id obj;
		
		while (obj = [enumerator nextObject])
		{
			NSString *key = [self keyForObjectIdenticalTo:obj];
			
			if (key){
				[self removeObjectForKey:key];
            }
		}
	}
}

- (NSString*)safeKeyForObjectIdenticalTo:(id)anObject;
{
	NSString *result=nil;
	
	if (anObject)
	{
		@synchronized(self) {
			result = [self keyForObjectIdenticalTo:anObject];
		}
	}
	
	return result;
}

- (void)safeSetObject:(id)anObject forKey:(id)aKey;
{
	if (anObject && aKey)
	{
		@synchronized(self) {
			[self setObject:anObject forKey:aKey];
		}
	}
}

- (NSArray*)safeAllValues;
{
	NSArray* result = nil;
	
    @synchronized(self) {
		result = [self allValues];
    }
	
	return result;
}

- (NSArray*)safeAllKeys;
{
	NSArray* result = nil;
	
    @synchronized(self) {
		result = [self allKeys];
    }
	
	return result;
}

- (unsigned long)safeCount;
{
	unsigned long result = 0;
	
    @synchronized(self) {
		result = [self count];
    }
	
	return result;
}

- (NSEnumerator*)safeKeyEnumerator;
{
	return [[self safeAllKeys] objectEnumerator];
}

- (NSEnumerator*)safeObjectEnumerator;
{
	return [[self safeAllValues] objectEnumerator];
}

@end
