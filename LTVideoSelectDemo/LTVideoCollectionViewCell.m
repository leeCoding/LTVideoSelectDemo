//
//  LTVideoCollectionViewCell.m
//  LTSelectImagePicker
//
//  Created by Jonny on 2017/6/28.
//  Copyright © 2017年 上海众盟软件科技股份有限公司. All rights reserved.
//

#import "LTVideoCollectionViewCell.h"
#import "LTVideoManager.h"

static CGFloat LTScreenScale;
static CGFloat LTScreenWidth;

@implementation LTVideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    LTScreenWidth = [UIScreen mainScreen].bounds.size.width;
    LTScreenScale = 2.0;
    self.videoImageView.contentMode = UIViewContentModeScaleAspectFit;
    if (LTScreenWidth>700) {
        LTScreenScale = 3.0;
    }
    // Initialization code
}

- (void)loadModel:(LTVideoModel *)model {
    
    self.timeLengthLabel.text = model.timeLength;
    
    [[LTVideoManager shareImageManager] getImage:model.asset width:self.frame.size.width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        self.videoImageView.image = photo;
    }];
}
@end
