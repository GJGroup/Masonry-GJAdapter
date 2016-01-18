//
//  ViewController.m
//  Masonry-GJAdapter
//
//  Created by wangyutao on 16/1/18.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView *view1;
@property (nonatomic, weak) IBOutlet UIView *view2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [UIView animateWithDuration:1 animations:^{
        //update view1
        [self.view1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view.mas_leadingMargin).offset(40);
            make.top.equalTo(self.mas_topLayoutGuideBottom).offset(30);
            make.size.mas_equalTo(CGSizeMake(50, 100));
        }];
        
        //remake view2
        [self.view2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view1.mas_bottom).offset(100);
            make.leading.equalTo(self.view1.mas_leading);
            make.size.mas_equalTo(CGSizeMake(100, 300));
        }];
        [self.view layoutIfNeeded];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
