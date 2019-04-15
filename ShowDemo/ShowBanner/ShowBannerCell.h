//
//  ShowBannerCell.h
//  ShowDemo
//
//  Created by DT on 2019/4/15.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShowBannerModel;
@protocol ShowBannerCellDelegate <NSObject>
-(void)checkIsCollection:(NSString*)isCollection selIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_BEGIN

@interface ShowBannerCell : UICollectionViewCell
/**  数据模型 */
@property (nonatomic, strong) ShowBannerModel *model;
@property(nonatomic,strong)NSString*isCollection;
@property(nonatomic,assign)NSInteger selIndex;
@property(nonatomic,weak)id<ShowBannerCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
