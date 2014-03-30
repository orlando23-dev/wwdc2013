//
//  main.m
//  DynamicOCThread
//
//  Created by llv22 on 11/25/13.
//  Copyright (c) 2013 llv22. All rights reserved.
//
//  see http://rypress.com/tutorials/objective-c/blocks.html
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import "NSMutableDictionary+NSMutableDictionary_ThreadSafe.h"

static NSMutableDictionary* fibDict = nil;
static NSMutableDictionary* fibSafeDict = nil;

long Fib (int n){
    if (n <= 1) {
        return 1;
    }
    else{
//        long x=Fib(n-1), y=Fib(n-2);
//        return x+y;
        if (!fibDict[@(n-1)] ) {
            fibDict[@(n-1)] = @(Fib(n-1));
        }
        if (!fibDict[@(n-2)]) {
            fibDict[@(n-2)] = @(Fib(n-2));
        }
        return [fibDict[@(n-1)] longValue] + [fibDict[@(n-2)] longValue];
    }
}

long FibInParallel (int n){
    if (n <= 1) {
        return 1;
    }
    else{
        //        long x=Fib(n-1), y=Fib(n-2);
        //        return x+y;
        // see https://developer.apple.com/library/ios/documentation/cocoa/Conceptual/Blocks/Articles/bxVariables.html#//apple_ref/doc/uid/TP40007502-CH6-SW1
        // see https://developer.apple.com/library/ios/documentation/cocoa/Conceptual/Blocks/Articles/bxUsing.html#//apple_ref/doc/uid/TP40007502-CH5-SW1
        __block long _tmpx, _tmpy;
        if (!fibSafeDict[@(n-1)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _tmpx = FibInParallel(n-1);
                [fibSafeDict safeSetObject:@(_tmpx) forKey:@(n-1)];
            });
        }
        else{
            _tmpx = [[fibSafeDict safeObjectForKey:@(n-1)] longValue];
        }
        if (!fibSafeDict[@(n-2)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _tmpy = FibInParallel(n-2);
                [fibSafeDict safeSetObject:@(_tmpy) forKey:@(n-2)];
            });
        }
        else{
            _tmpy = [[fibSafeDict safeObjectForKey:@(n-2)] longValue];
        }
        return _tmpx + _tmpy;
    }
}

long FibInParallelGroup (int n){
    if (n <= 1) {
        return 1;
    }
    else{
        //        long x=Fib(n-1), y=Fib(n-2);
        //        return x+y;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group = dispatch_group_create();
        
        // TODO : add a task to the group
        __block long _tmpx, _tmpy;
        if (!fibSafeDict[@(n-1)]) {
            dispatch_group_async(group, queue, ^{
                _tmpx = FibInParallelGroup(n-1);
                [fibSafeDict safeSetObject:@(_tmpx) forKey:@(n-1)];
            });
        }
        else{
            _tmpx = [[fibSafeDict safeObjectForKey:@(n-1)] longValue];
        }
        if (!fibSafeDict[@(n-2)]) {
            dispatch_group_async(group, queue, ^{
                _tmpy = FibInParallelGroup(n-2);
                [fibSafeDict safeSetObject:@(_tmpy) forKey:@(n-2)];
            });
        }
        else{
            _tmpy = [[fibSafeDict safeObjectForKey:@(n-2)] longValue];
        }
        
        //TODO : await the group to block the current thread
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
/*  
        'release' is unavailable: not available in automatic reference counting mode
        dispatch_release(group);
 */
 
        return _tmpx + _tmpy;
    }
}

void benchmark_template(){
    size_t const objectCount = 10000;
    
    //TODO : see http://blog.sina.com.cn/s/blog_a343f32b0101dcq4.html
    uint64_t n = dispatch_benchmark(10000, ^{
        @autoreleasepool {
            id obj = @42;
            NSMutableArray *array = [NSMutableArray array];
            for (size_t i = 0; i < objectCount; ++i) {
                [array addObject:obj];
            }
        }
    });
    
    NSLog(@"-[NSMutableArray addObject:] : %llu ns", n);
}

void SequentialInSingleThread(void)
{
    if (!fibDict) {
        fibDict = [[NSMutableDictionary alloc]init];
    }
    
    uint64_t n = dispatch_benchmark(1/*10, 100, 500, 1000, not cacluated*/, ^{
        [fibDict removeAllObjects];
        
        @autoreleasepool {
            NSLog(@"%lu", Fib(11)); // 40000 seems overflow
        }
    });
    
    NSLog(@"Sequential Fib : %llu ns", n);
}

void ParallelInMultiThreads(void)
{
    if (!fibSafeDict) {
        fibSafeDict = [[NSMutableDictionary alloc]init];
    }
    
    uint64_t n = dispatch_benchmark(1/*10, 100, 500, 1000, not cacluated*/, ^{
        [fibSafeDict removeAllObjects];
        
        @autoreleasepool {
            NSLog(@"%lu", FibInParallel(11)); // 40000 seems overflow
        }
    });
    
    NSLog(@"Parallelization Fib : %llu ns", n);
}

void ParallelInMultiThreadsGroup(void)
{
    if (!fibSafeDict) {
        fibSafeDict = [[NSMutableDictionary alloc]init];
    }
    
    uint64_t n = dispatch_benchmark(1/*10, 100, 500, 1000, not cacluated*/, ^{
        [fibSafeDict removeAllObjects];
        
        @autoreleasepool {
            NSLog(@"%lu", FibInParallelGroup(11)); // 40000 seems overflow
        }
    });
    
    NSLog(@"ParallelInMultiThreadsGroup Fib : %llu ns", n);
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        /* sequentianl version
         1, 2013-11-25 14:54:08.126 DynamicOCThread[1911:303] Sequential Fib : 54251643 ns - virtual machine
         2, 2013-11-30 14:43:20.139 DynamicOCThread[1449:303] Sequential Fib : 42523143 (42091816) ns - mac pro
         */
        SequentialInSingleThread();
        
        /* parallelization version
         1,  - virtual machine
         2,  - mac pro
         */
        ParallelInMultiThreads();
        
        ParallelInMultiThreadsGroup();
        
    }
    return 0;
}

