//
//  ShowBannerView.h
//  ShowDemo
//
//  Created by DT on 2019/4/15.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowBannerModel.h"
NS_ASSUME_NONNULL_BEGIN
@class ShowBannerView;

@protocol ShowBannerViewDelegate <NSObject>

@optional
/**
 该方法用来处理item的点击，会返回item在moxing数组中的索引
 
 @param bannerView  控件本身
 @param index       索引
 */
- (void)ShowBannerView:(ShowBannerView *)bannerView didSelectedAt:(NSInteger)index;

/**
该方法手动滑倒第几个页面
 
 @param bannerView  控件本身
 @param index       索引
 */
- (void)ShowBannerView:(ShowBannerView *)bannerView scrollAt:(NSInteger)index;

@end
@interface ShowBannerView : UIView
@property(nonatomic,assign)NSInteger currentIndex;
/**
 *  模型数组
 */
@property (nonatomic, strong) NSArray<ShowBannerModel *> *models;
/**
 *  代理，用来处理图片的点击
 */
@property (nonatomic, weak) id <ShowBannerViewDelegate> delegate;
/**
 *  每一页停留时间，默认为3s，最少1s
 *  当设置的值小于1s时，则为默认值
 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

@property (nonatomic, assign) BOOL isRepeat;//是否重复显示

@property (nonatomic, assign) BOOL isAutomatic;//是否隔几秒自动变换
@end

NS_ASSUME_NONNULL_END
