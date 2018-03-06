//
//  LTVideoModel.h
//  LTSelectImagePicker
//
//  Created by Jonny on 2017/6/28.
//  Copyright © 2017年 上海众盟的软件科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface LTVideoModel : NSObject

@property (nonatomic,copy)NSString *timeLength;
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,strong)PHAsset *asset;
@property (nonatomic,assign)BOOL  isGreater;

@end
