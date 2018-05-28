//
//  Persion+mult.m
//  008-runtime
//
//  Created by hzg on 2018/4/6.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "Persion+mult.h"
#import <objc/runtime.h>

@implementation Persion (mult)

const char* name = "nick";

- (void) setNick:(NSString *)nick {
    objc_setAssociatedObject(self, &name, nick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString*) nick {
    return objc_getAssociatedObject(self, &name);
}

@end
