//
//  ViewController.m
//  FLutterHybridDemo
//
//  Created by lyy on 2019/5/13.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>
#import "AppDelegate.h"
#import "HybridViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addButton];
}

- (IBAction)BasicMessageChannel:(id)sender {
    HybridViewController *controller = [[HybridViewController alloc]initWithChannelType:HybridBasicMessageChannelType];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)EventChannel:(id)sender {
    
}

- (IBAction)MethodChannel:(id)sender {
    
}



- (void)addButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(handleButtonAction)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}

//跳转方式
- (void)handleButtonAction {
    // 方式一
    FlutterEngine *flutterEngine = [(AppDelegate *)[[UIApplication sharedApplication] delegate] flutterEngine];
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    //方式二
//    FlutterViewController *flutterViewController = [FlutterViewController new];
    [flutterViewController setInitialRoute:@"{name:devio,dataList:['aa','bb']}"];
    [self presentViewController:flutterViewController animated:YES completion:nil];

}

@end
























