//
//  LTImageManager.h
//  LTSelectImagePicker
//
//  Created by Jonny on 2017/6/28.
//  Copyright © 2017年 上海众盟的软件科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LTVideoModel , PHAsset;

@interface LTVideoManager : NSObject

// 检查是否有权限
- (NSInteger)authorizationStatus;

+ (LTVideoManager *)shareImageManager;

// 获取视屏合集
- (void)getVideo:(void (^)(NSMutableArray <LTVideoModel *> *ary))completion;

// 获取封面
- (void)getImage:(PHAsset *)obj width:(float)width completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;

// 导出视屏
- (void)getVideoOutputPathWithAsset:(id)asset completion:(void (^)(NSString *outputPath))completion;

// 获取视屏第一帧图
- (void)getVideoCover:(LTVideoModel *)model returnImage:(void(^)(UIImage *image))coverImage;
@end
