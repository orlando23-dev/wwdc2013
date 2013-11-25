//
//  main.m
//  DynamicOCThread
//
//  Created by llv22 on 11/25/13.
//  Copyright (c) 2013 llv22. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

static NSMutableDictionary* fibDict = nil;

long Fib (int n){
    if (n <= 1) {
        return n;
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

void benchmark_template(){
    size_t const objectCount = 10000;
    
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

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        if (!fibDict) {
            fibDict = [[NSMutableDictionary alloc]init];
        }
        
        uint64_t n = dispatch_benchmark(300/*10, 100, 500, 1000, not cacluated*/, ^{
            [fibDict removeAllObjects];
            
            @autoreleasepool {
                Fib(37400); // 40000 seems overflow
            }
        });
        
        NSLog(@"Sequential Fib : %llu ns", n);
        // sequentianl version - 2013-11-25 14:54:08.126 DynamicOCThread[1911:303] Sequential Fib : 54251643 ns
        
    }
    return 0;
}

