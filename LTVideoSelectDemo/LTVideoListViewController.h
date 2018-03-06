//
//  LTVideoListViewController.h
//  LTSelectImagePicker
//
//  Created by Jonny on 2017/6/28.
//  Copyright © 2017年 上海众盟软件科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTVideoModel.h"

@protocol LTVideoListViewControllerDelegate;

@interface LTVideoListViewController : UIViewController

@property (nonatomic,assign)id<LTVideoListViewControllerDelegate>delegate;

@end

@protocol LTVideoListViewControllerDelegate <NSObject>

/// 选择视频
- (void)selectedVideoWithModel:(LTVideoListViewController *)videoList model:(LTVideoModel *)videoModel;

@end
