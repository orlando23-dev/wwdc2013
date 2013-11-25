//
//  main.m
//  DynamicOCThread
//
//  Created by llv22 on 11/25/13.
//  Copyright (c) 2013 llv22. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

long Fib (int n){
    if (n <= 1) {
        return n;
    }
    else{
        long x=Fib(n-1), y=Fib(n-2);
        return x+y;
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
        
        uint64_t n = dispatch_benchmark(100/*500, 1000, not cacluated*/, ^{
            @autoreleasepool {
//                Fib(1000);//not-caculated
                Fib(500);
            }
        });
        
        NSLog(@"Sequential Fib : %llu ns", n);
        
    }
    return 0;
}

