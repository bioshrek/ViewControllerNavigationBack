//
//  LastViewController.m
//  NavigationBackTest
//
//  Created by Shrek Wang on 3/17/15.
//  Copyright (c) 2015 Chianyu. All rights reserved.
//

#import "LastViewController.h"

#import "AppDelegate.h"

#import "UIViewController+NavigationBack.h"

@interface LastViewController ()

@end

@implementation LastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonPressed:(id)sender {
    UIViewController *rootViewController = [[(AppDelegate *)[UIApplication sharedApplication].delegate window] rootViewController];
    [self navigationBackToAncestorViewController:rootViewController];
}

@end
