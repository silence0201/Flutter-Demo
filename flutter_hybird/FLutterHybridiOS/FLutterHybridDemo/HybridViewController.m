//
//  HybridViewController.m
//  FLutterHybridDemo
//
//  Created by lyy on 2019/5/14.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "HybridViewController.h"
#import <Flutter/Flutter.h>

static NSString *const kMessageChannelName = @"messageChannelName";
static NSString *const kEventChannelName = @"eventChannelName";
static NSString *const kMethodChannelName = @"methodChannelName";

@interface HybridViewController ()<UITextFieldDelegate>
@property(strong,nonatomic)FlutterViewController *flutterController;
@property(assign,nonatomic)HybridChannelType channelType;
@property (nonatomic) FlutterBasicMessageChannel* messageChannel;
@property (nonatomic) FlutterEventChannel* eventChannel;
@property (nonatomic) FlutterMethodChannel* methodChannel;
@property (nonatomic) FlutterEventSink eventSink;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *showLabel;


@end

@implementation HybridViewController

- (instancetype)initWithChannelType:(HybridChannelType)channelType {
    if (self = [super init]) {
        self.channelType = channelType;
        [self initChannel];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setUpSubController];
}

- (void)initChannel {
    self.messageChannel = [FlutterBasicMessageChannel messageChannelWithName:kMessageChannelName binaryMessenger:self.flutterController codec:[FlutterStringCodec sharedInstance]];
    __weak typeof(self) weakSelf = self;
    [self.messageChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
        callback([NSString stringWithFormat:@"BasicMessageChannel收到:%@",message]);
        [weakSelf showMessage:message];
    }];
}

- (void)showMessage:(NSString *)message {
    self.showLabel.text = [NSString stringWithFormat:@"收到flutter回复：%@",message];
}

- (IBAction)editingChanged:(id)sender {
    [self.messageChannel sendMessage:self.textField.text reply:^(id  _Nullable reply) {
        
    }];
}


- (void)setUpSubController {
    [self addChildViewController:self.flutterController];
    UIView *subView = self.flutterController.view;
    subView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    subView.frame = CGRectMake(0, 300, self.view.bounds.size.width, self.view.bounds.size.height-300);
    [self.view addSubview:subView];
}

- (FlutterViewController *)flutterController {
    if (!_flutterController) {
        _flutterController = [[FlutterViewController alloc]init];
        [_flutterController setInitialRoute:@"default"];
    }
    return _flutterController;
}

@end
