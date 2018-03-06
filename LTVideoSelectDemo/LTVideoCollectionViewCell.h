//
//  LTVideoCollectionViewCell.h
//  LTSelectImagePicker
//
//  Created by Jonny on 2017/6/28.
//  Copyright © 2017年 上海众盟软件科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTVideoModel.h"
@interface LTVideoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLengthLabel;

- (void)loadModel:(LTVideoModel *)model ;

@end
