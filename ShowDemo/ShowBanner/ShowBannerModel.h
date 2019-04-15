//
//  ShowBannerModel.h
//  ShowDemo
//
//  Created by DT on 2019/4/15.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowBannerModel : NSObject
@property (nonatomic, copy) NSString *filmTitle;
@property(nonatomic,strong)NSArray *filmLabelList;
@property (nonatomic, strong) NSArray *filmAbstractList;
@property (nonatomic, strong) NSString *lunarDateDesc;
@property (nonatomic, strong) NSString *dayDateDesc;
@property (nonatomic, strong) NSString *filmPic;
@property (nonatomic, strong) NSString *weekDesc;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *authorPic;
@property(nonatomic,assign)int authorId;
@property(nonatomic,assign)int filmLikeNumbers;
@property(nonatomic,assign)int id;
@property(nonatomic,assign)int createTime;
@property(nonatomic,assign)int filmCommentNumbers;
@property (nonatomic, strong) NSString *isCollection;
@end

NS_ASSUME_NONNULL_END
