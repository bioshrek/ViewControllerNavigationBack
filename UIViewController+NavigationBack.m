//
//  UIViewController+FindDescendent.m
//  NavigationBackTest
//
//  Created by Shrek Wang on 3/17/15.
//  Copyright (c) 2015 Chianyu. All rights reserved.
//

#import "UIViewController+NavigationBack.h"

@implementation UIViewController (NavigationBack)

- (BOOL)findDescendant:(UIViewController *)target
{
    if (nil == target) return NO;
    
    if ([self isEqual:target]) {
        return YES;
    }
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *naviController = (UINavigationController *)self;
        NSArray *childControllers = [naviController viewControllers];
        for (UIViewController *child in childControllers) {
            if ([child findDescendant:target]) {
                return YES;
            }
        }
    }
    
    if ([self isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabController = (UITabBarController *)self;
        NSArray *childControllers = [tabController viewControllers];
        for (UIViewController *child in childControllers) {
            if ([child findDescendant:target]) {
                return YES;
            }
        }
    }
    
    if (self.presentedViewController) {
        return [self.presentedViewController findDescendant:target];
    }
    
    return NO;
}

- (BOOL)findDescendant:(UIViewController *)target
             ancestors:(NSMutableArray *)stack
{
    if (nil == target) return NO;
    
    NSParameterAssert(stack);
    
    if ([self isEqual:target]) {
        return YES;
    }
    
    // push into stack
    [stack addObject:self];
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *naviController = (UINavigationController *)self;
        NSArray *childControllers = [naviController viewControllers];
        for (UIViewController *child in childControllers) {
            if ([child findDescendant:target ancestors:stack]) {
                return YES;
            }
        }
    }
    
    if ([self isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabController = (UITabBarController *)self;
        NSArray *childControllers = [tabController viewControllers];
        for (UIViewController *child in childControllers) {
            if ([child findDescendant:target ancestors:stack]) {
                return YES;
            }
        }
    }
    
    if (self.presentedViewController) {
        return [self.presentedViewController findDescendant:target ancestors:stack];
    }
    
    // not found, pop stack
    NSUInteger count = [stack count];
    if (count)
        [stack removeObjectAtIndex:count - 1];
    
    
    return NO;
}

- (void)navigationBackToRootViewControllerWithAncestors:(NSArray *)stack
{
    for (long i = [stack count] - 1; i >= 0; i--) {
        @autoreleasepool {
            UIViewController *viewController = [stack objectAtIndex:i];
            
            if ([viewController isKindOfClass:[UINavigationController class]]) {
                
                // pop to root view controller
                [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
                continue;
            }
            
            if ([viewController isKindOfClass:[UITabBarController class]]) {
                
                // nothing to do
                continue;
            }
            
            // presenting view controller
            // dismiss
            [viewController dismissViewControllerAnimated:NO completion:nil];
        }
    }
}

- (void)navigationBackToAncestorViewController:(UIViewController *)ancestorViewController
{
    NSMutableArray *ancestors = [[NSMutableArray alloc] init];
    BOOL found = [ancestorViewController findDescendant:self ancestors:ancestors];
    if (found) {
        [self navigationBackToRootViewControllerWithAncestors:ancestors];
    }
}


@end
