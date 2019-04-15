//
//  ShowBannerCell.m
//  ShowDemo
//
//  Created by DT on 2019/4/15.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "ShowBannerCell.h"
#import "IHUtility.h"
#import "MyUtility.h"
#import "Contant.h"
#import "UIViewExt.h"
#import "WHToast.h"
#import "ShowBannerModel.h"
#import "UIImageView+WebCache.h"
@interface ShowBannerCell ()
{
    UIImageView *_imageView;
    UILabel *_textLabel;
    UILabel *_decLabel;
    UILabel *_typeLabel;
    UILabel *_noLabel;
    UIButton *_likeBtn;
    UIButton *_commentBtn;
    UIButton *_detailBtn;
}
@end

@implementation ShowBannerCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 3.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGFloat labelHeight = self.bounds.size.height * 9/14;
    CGFloat imageViewHeight = self.bounds.size.height - labelHeight;
    
    _noLabel =[MyUtility createLabelWithFrame:CGRectMake(25, 0, self.bounds.size.width-50, self.bounds.size.height) title:@"请等待明日更新" textColor:RGB(118, 122, 128) font:[UIFont systemFontOfSize:titleFont] textAlignment:NSTextAlignmentCenter numberOfLines:0];
    _noLabel.hidden = YES;
    [self addSubview:_noLabel];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, imageViewHeight)];
    //    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    //    _imageView.layer.masksToBounds = true;
    [self addSubview:_imageView];
    _decLabel = [MyUtility createLabelWithFrame:CGRectMake(25, _imageView.bottom+20, self.bounds.size.width-50, 120) title:@"" textColor:RGB(118, 122, 128) font:[UIFont systemFontOfSize:minFont] textAlignment:NSTextAlignmentLeft numberOfLines:7];
    [self addSubview:_decLabel];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-130, self.bounds.size.width, 20)];
    _textLabel.textColor = [UIColor colorWithRed:48/255.0f green:59/255.0f blue:73/255.0f alpha:1];
    _textLabel.font = [UIFont systemFontOfSize:ToolFont];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.adjustsFontSizeToFitWidth = true;
    [self addSubview:_textLabel];
    
    _typeLabel =[MyUtility createLabelWithFrame:CGRectMake(20, self.bounds.size.height-90, self.bounds.size.width-50, 20) title:@"" textColor:RGB(153, 161, 173) font:[UIFont systemFontOfSize:colorFont] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [self addSubview:_typeLabel];
    
    _likeBtn = [MyUtility createButtonWithFrame:CGRectMake(20, self.bounds.size.height-27-20, 60, 20) title:@"" textColor:RGB(153, 161, 173) imageName:@"like" target:self action:@selector(isLike) isCorner:NO isDriction:3];
    _likeBtn .titleLabel.font = [UIFont systemFontOfSize:textFont];
    [self addSubview:_likeBtn];
    
    _commentBtn = [MyUtility createButtonWithFrame:CGRectMake(_likeBtn.right+50, self.bounds.size.height-27-20, 60, 20) title:@"" textColor:RGB(153, 161, 173) imageName:@"comment" target:self action:@selector(isComment) isCorner:NO isDriction:3];
    _commentBtn .titleLabel.font = [UIFont systemFontOfSize:textFont];
    [self addSubview:_commentBtn];
    
    _detailBtn = [MyUtility createButtonWithFrame:CGRectMake(self.bounds.size.width-80, self.bounds.size.height-27-30, 60, 30) title:@"详情" textColor:[UIColor whiteColor] imageName:@"" target:self action:@selector(gotoDetail) isCorner:YES isDriction:4];
    _detailBtn.layer.cornerRadius = 15;
    _detailBtn.layer.masksToBounds = YES;
    _detailBtn.backgroundColor = visualReinforcementColor;
    _detailBtn .titleLabel.font = [UIFont systemFontOfSize:textFont];
    [self addSubview:_detailBtn];
    
}

- (void)setModel:(ShowBannerModel *)model{
    
    _model = model;
    _noLabel.hidden = YES;
    _imageView.hidden =  NO;
    _textLabel.hidden = NO;
    _decLabel.hidden = NO;
    _typeLabel.hidden = NO;
    _likeBtn.hidden = NO;
    _commentBtn.hidden = NO;
    _detailBtn.hidden = NO;
    //    NSLog(@"这个数据%@",_model.filmTitle);
    
    if(![IHUtility isBlankString:_model.filmTitle]){
        NSString *pictureStr = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,h_%d",model.filmPic,600];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:pictureStr] placeholderImage:[UIImage imageNamed:@"User"]];
        NSString *showTitle = [NSString stringWithFormat:@"   %@",_model.filmAbstractList[0]];
        //设置段间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:showTitle];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [showTitle length])];
        _decLabel.attributedText = attributedString;
        [_decLabel sizeToFit];
        [_decLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        UIFont *font = [UIFont systemFontOfSize:minFont];
        CGRect sizeToFit = [showTitle boundingRectWithSize:CGSizeMake(kScreenWidth-50, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil];
        
        _decLabel.frame = CGRectMake(25, _imageView.bottom+20, self.bounds.size.width-50, sizeToFit.size.height+5);
        
        _textLabel.text = [NSString stringWithFormat:@"-《%@》-",_model.filmTitle];
        NSString*filmTitle = @"";
        for(int i=0;i<model.filmLabelList.count;i++){
            filmTitle = [NSString stringWithFormat:@"%@  #%@",filmTitle,model.filmLabelList[i]];
        }
        _typeLabel.text =filmTitle;
        if([model.isCollection isEqualToString:@"YES"]){
            [_likeBtn setImage:[UIImage imageNamed:@"selLike"] forState:UIControlStateNormal];
        }else
        {
            [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        }
        [_likeBtn setTitle:[NSString stringWithFormat:@"%d",model.filmLikeNumbers] forState:UIControlStateNormal];
        [_commentBtn setTitle:[NSString stringWithFormat:@"%d",model.filmCommentNumbers] forState:UIControlStateNormal];
    }else
    {
        _imageView.hidden =  YES;
        _textLabel.hidden = YES;
        _decLabel.hidden = YES;
        _typeLabel.hidden = YES;
        _likeBtn.hidden = YES;
        _commentBtn.hidden = YES;
        _detailBtn.hidden = YES;
        _noLabel.hidden = NO;
    }
    
}
-(void)setSelIndex:(NSInteger)selIndex
{
    _selIndex = selIndex;
}
-(void)isLike{
    
    if([_model.isCollection isEqualToString:@"YES"]){
        [self gotoCollection:_model.isCollection];
        [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        _model.filmLikeNumbers = _model.filmLikeNumbers-1;
        _model.isCollection = @"NO";
    }else
    {
        [self gotoCollection:_model.isCollection];
        [_likeBtn setImage:[UIImage imageNamed:@"selLike"] forState:UIControlStateNormal];
        _model.filmLikeNumbers = _model.filmLikeNumbers+1;
        _model.isCollection = @"YES";
    }
    [_likeBtn setTitle:[NSString stringWithFormat:@"%d",_model.filmLikeNumbers] forState:UIControlStateNormal];
    
}
//评论
-(void)isComment{
   
}
-(void)gotoCollection:(NSString*)collection{

    if([collection isEqualToString:@"NO"]){
            [WHToast showMessage:@"收藏成功" duration:1 finishHandler:^{
            }];
    }else{
            [WHToast showMessage:@"取消收藏" duration:1 finishHandler:^{
            }];
    }
}

@end
