//
//  ViewController.m
//  LRateStar
//
//  Created by ponted on 2018/3/1.
//  Copyright © 2018年 Shenzhen Blood Link Medical Technology Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "LRateStar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    rateStarModel *model = [[rateStarModel alloc]init];
    model.numberOfStars = 5;
    model.norImageName = @"hello";
    
    LRateStar *ss = [[LRateStar alloc]initWithFrame:CGRectMake(0, 100, 300, 40) rateStyle:0 rateModel:model finish:^(CGFloat currentScore) {
        
    }];
    [self.view addSubview:ss];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
