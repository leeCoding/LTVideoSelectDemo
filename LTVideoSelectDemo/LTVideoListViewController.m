//
//  LTVideoListViewController.m
//  LTSelectImagePicker
//
//  Created by Jonny on 2017/6/28.
//  Copyright © 2017年 上海众盟软件科技股份有限公司. All rights reserved.
//

#import "LTVideoListViewController.h"
#import "LTVideoCollectionViewCell.h"
#import "LTVideoManager.h"
//#import "UIViewController+Units.h"

@interface LTVideoListViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *resultAry;
//@property (nonatomic,strong)UILabel *loadView;
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@end

@implementation LTVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self initData];

}

- (void)initData {
    
    if ([[LTVideoManager shareImageManager] authorizationStatus] == 0) {

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == 3) {
                        [[LTVideoManager shareImageManager] getVideo:^(NSMutableArray<LTVideoModel *> *ary) {
                            self.resultAry = ary;
                            [self.collectionView reloadData];
                        }];
                    }
                });
            }];
        });
        
    }else if ([[LTVideoManager shareImageManager] authorizationStatus]== 1 || [[LTVideoManager shareImageManager] authorizationStatus] == 2){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        alert.tag = 1;
        [alert show];
#pragma clang diagnostic pop
        
    } else {
        
        [[LTVideoManager shareImageManager] getVideo:^(NSMutableArray<LTVideoModel *> *ary) {
            self.resultAry = ary;
            [self.collectionView reloadData];
        }];
    }
    
}

- (void)initUI {
 
    self.title = @"视频列表";
    
    UIButton *rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 44);
    [rigthBtn setTitle:@"取消" forState:0];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:[UIColor blackColor] forState:0];
    [rigthBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rigthBtn];
    
    /*
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setTitle:@"返回" forState:0];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [leftBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    */
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    float width = (self.view.frame.size.width - (5 * 5 )) / 4;
    [layout setItemSize:CGSizeMake(width, width)];
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height) collectionViewLayout:layout];
    self.collectionView.dataSource  = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"LTVideoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
    float lt_width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
  
    self.activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicatorView.frame = CGRectMake((lt_width - 60) / 2, (height - 30) / 2, 60, 30);
    self.activityIndicatorView.color = [UIColor blueColor];
    [self.view addSubview:self.activityIndicatorView];

}

#pragma mark -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.resultAry.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LTVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell loadModel:self.resultAry[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LTVideoModel *model = self.resultAry[indexPath.row];
    NSLog(@" 选择的图片%@ 视频长度 %@",model.image,model.timeLength);
    model.image = [UIImage imageNamed:@"wb_pic"];
    [self.activityIndicatorView startAnimating];

//    if (model.isGreater) {
//
////        [self showStatus:@"请选择10分钟之内的视频！"];
//        NSLog(@"请选择十分钟之内的视频");
//        return;
//    } else {
//        NSLog(@" 小于十分钟内的 ");
//    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[LTVideoManager shareImageManager] getVideoCover:model returnImage:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                model.image = image;
                if ([self.delegate respondsToSelector:@selector(selectedVideoWithModel:model:)]) {
                    [self.delegate selectedVideoWithModel:self model:model];
                    [self hide];
                    [self.activityIndicatorView stopAnimating];
                    [self.activityIndicatorView setHidesWhenStopped:YES];
                }
            });
        }];

    });
}

#pragma mark - UIAlertViewDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
            NSURL *privacyUrl;
            if (alertView.tag == 1) {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            } else {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"无法跳转到隐私设置页面，请手动前往设置页面，谢谢" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
    }
}
#pragma clang diagnostic pop

- (void)hide {

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
