//
//  ViewController.m
//  LTVideoSelectDemo
//
//  Created by Jonny on 2018/3/1.
//  Copyright © 2018年 Jonny. All rights reserved.
//

#import "ViewController.h"
#import "LTVideoListViewController.h"
@interface ViewController ()
<
    LTVideoListViewControllerDelegate
>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"我是other 提交的分支");
    NSLog(@"再次提交分支");

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake((self.view.frame.size.width - 100)/2, 100, 100, 40);
    [selectBtn setTitle:@"选择视频" forState:0];
    selectBtn.backgroundColor = [UIColor grayColor];
    [selectBtn addTarget:self action:@selector(touchSelectImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
}

- (void)touchSelectImage:(UIButton *)btn {
    
    LTVideoListViewController *videoListVC = [LTVideoListViewController new];
    videoListVC.delegate = self;
     UINavigationController *navigationcontroller = [[UINavigationController alloc]initWithRootViewController:videoListVC];
    [self.navigationController presentViewController:navigationcontroller animated:YES completion:nil];
}

- (void)selectedVideoWithModel:(LTVideoListViewController *)videoList model:(LTVideoModel *)videoModel {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
