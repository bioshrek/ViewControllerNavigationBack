//
//  UIViewController+FindDescendent.h
//  NavigationBackTest
//
//  Created by Shrek Wang on 3/17/15.
//  Copyright (c) 2015 Chianyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationBack)

- (void)navigationBackToAncestorViewController:(UIViewController *)ancestorViewController;

@end
