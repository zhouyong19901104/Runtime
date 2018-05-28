//
//  ViewController.m
//  008-runtime
//
//  Created by hzg on 2018/4/6.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "ViewController.h"
#import "Persion.h"
#import <objc/runtime.h>
#import "Persion+mult.h"

@interface ViewController ()
@property (nonatomic, strong) Persion* persion;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.persion = [[Persion alloc] init];
    self.persion.name = @"Tom";
//    NSLog(@"%@", self.persion.name);
}

/// 1. 使用runtime改变实例成员的值
- (void) changeVarName {
    /// 实例变量个数
    unsigned int count = 0;
    
    /// 获取所以的实例变量
    Ivar* ivar = class_copyIvarList([self.persion class], &count);
    
    /// 遍历
    for (int i = 0; i < count; i++) {
        
        /// 实例变量
        Ivar var = ivar[i];
        
        /// 实例变量名字
        const char * varName = ivar_getName(var);
        
        /// 转化一下
        NSString* name = [NSString stringWithUTF8String:varName];
        
        if ([name isEqualToString:@"_name"]) {
            object_setIvar(self.persion, var, @"Jerrry");
            break;
        }
    }
}

///  使用runtime来交换两个方法
- (void) exchangedMethod {
    
    /// 获取方法
    Method m1 = class_getInstanceMethod([self.persion class], @selector(fristMethod));
    Method m2 = class_getInstanceMethod([self.persion class], @selector(secondMethod));
    
    /// 交换
    method_exchangeImplementations(m1, m2);
    
}

/// 3.使用runtime来动态添加方法
- (void) addMethod {
    
    /// "v@:@":  v表示void, @表示id， :表示 SEL
    class_addMethod([self.persion class], @selector(run:), (IMP)runMethod, "v@:@");
    
}


void runMethod(id self, SEL _cmd, NSString* miles) {
    NSLog(@"%@", miles);
}


- (IBAction)onChangedButtonClicked:(UIButton *)sender {
    
    //[self exchangedMethod];
    [self addMethod];
}


- (IBAction)onTestButtonClicked:(UIButton *)sender {
//   NSLog(@"%@", self.persion.name);
//
//    [self.persion fristMethod];
    
//    if ([self.persion respondsToSelector:@selector(run:)]) {
//        [self.persion performSelector:@selector(run:) withObject:@"1 miles"];
//    } else {
//        NSLog(@"方法没有实现！！");
//    }
    
    self.persion.nick = @"Cat";
    NSLog(@"%@", self.persion.nick);
}


@end
