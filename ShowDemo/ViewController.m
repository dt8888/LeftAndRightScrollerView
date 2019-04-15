//
//  ViewController.m
//  ShowDemo
//
//  Created by DT on 2019/4/15.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "ViewController.h"
#import "ShowBannerView.h"
#import "ShowBannerModel.h"
#import "YJNetworkData.h"
#import "MyUtility.h"
#import "Contant.h"
#import "IHUtility.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()<ShowBannerViewDelegate>

@end

@implementation ViewController
{
      ShowBannerView *_banner;
      ShowBannerModel *_model;
    NSMutableArray *_temArray;
    UIScrollView *_scrollView;
    UILabel *_dayText;
    UILabel *_dateText;
    UILabel*_weekText;
    NSString*_isCollection;
    NSInteger _currentIndex;
    UIImageView *_headerImage;
    UILabel *_nickText;
    UILabel*_timeText;
    int _authorId;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self getHomeFilmsData];
}
//获取布局
-(void)createView{
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgImage.image = [UIImage imageNamed:@"homeBg1.jpg"];
    bgImage.userInteractionEnabled = YES;
    [self.view addSubview:bgImage];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _scrollView.backgroundColor = [UIColor clearColor];
    [bgImage addSubview:_scrollView];
    _dayText = [MyUtility createLabelWithFrame:CGRectMake(45, 44, 60, 65) title:@"" textColor:RGB(129, 134, 142) font:[UIFont systemFontOfSize:44] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    _dayText.font = [UIFont fontWithName:@"PingFangSC-Thin" size: 44];
    [_scrollView addSubview:_dayText];
    
    _weekText = [MyUtility createLabelWithFrame:CGRectMake(_dayText.right, 55, 100, 20) title:@"" textColor:RGB(129, 134, 142) font:[UIFont systemFontOfSize:ToolFont] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [_scrollView addSubview:_weekText];
    
    _dateText = [MyUtility createLabelWithFrame:CGRectMake(_dayText.right, _weekText.bottom, 200, 20) title:@"" textColor:RGB(129, 134, 142) font:[UIFont systemFontOfSize:ToolFont] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [_scrollView addSubview:_dateText];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-102-23, 63, 90, 28)];
    [_scrollView addSubview:bgView];
    
    _nickText = [MyUtility createLabelWithFrame:CGRectMake(30,0, 60, titleFont) title:@"" textColor:RGB(129, 134, 142) font:[UIFont systemFontOfSize:textFont] textAlignment:NSTextAlignmentRight numberOfLines:0];
    _nickText.font = [UIFont fontWithName:@"PingFangSC-Regular" size: textFont];
    [bgView addSubview:_nickText];
    
    _timeText = [MyUtility createLabelWithFrame:CGRectMake(30, _nickText.bottom, 60, 14) title:@"15:10:15" textColor:RGB(129, 134, 142) font:[UIFont systemFontOfSize:colorFont] textAlignment:NSTextAlignmentRight numberOfLines:0];
    _timeText.font = [UIFont fontWithName:@"PingFangSC-Regular" size: colorFont];
    [bgView addSubview:_timeText];
    
    _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 28)];
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 14;
    _headerImage.userInteractionEnabled = YES;
    _headerImage.contentMode = UIViewContentModeScaleAspectFill;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:@"https://kxlj.oss-cn-hangzhou.aliyuncs.com/film-pic/0217.jpg?x-oss-process=image/resize,h_600"] placeholderImage:[UIImage imageNamed:@"User"]];
    [bgView addSubview:_headerImage];
    
    
    CGFloat width = self.view.bounds.size.width;
    _banner = [[ShowBannerView alloc] initWithFrame:CGRectMake(0, bgView.bottom+30, width, 520)];
    _banner.delegate = self;
    _banner.isRepeat = YES;
    _banner.isAutomatic = YES;
    [_scrollView addSubview:_banner];
    
    _scrollView.contentSize = CGSizeMake(0, 520+160+50);
}
//获取数据
-(void)getHomeFilmsData{
    _temArray = [[NSMutableArray alloc]init];
    [network getHomePages:8 success:^(NSDictionary *obj) {
        NSArray *arr=obj[@"data"];
        if (arr == nil) return;
        int count = (int)arr.count;
        if(count>0){
            for(NSDictionary *dic in arr){
                ShowBannerModel *model = [[ShowBannerModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [_temArray addObject:model];
            }
            _banner.models = _temArray;
            _banner.currentIndex = _temArray.count-1;
        }
    } failure:^(NSDictionary *obj2) {
        
    }];
}
//滑动到某页面
- (void)ShowBannerView:(ShowBannerView *)bannerView scrollAt:(NSInteger)index{
    if(index<_temArray.count){
        ShowBannerModel *model  = _temArray[index];
        _model = model;
        _authorId = model.authorId;
        _dayText.text = model.dayDateDesc;
        _weekText.text = [IHUtility weekConversionDay:model.weekDesc];
        _dateText.text = model.lunarDateDesc;
        _headerImage.hidden = NO;
        NSString *pictureStr = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_fill,h_100,w_100",model.authorPic];
        [_headerImage sd_setImageWithURL:[NSURL URLWithString:pictureStr] placeholderImage:[UIImage imageNamed:@"User"]];
        _nickText.text = model.authorName;
        NSArray *timeArr = [[IHUtility time_timestampToString:model.createTime ] componentsSeparatedByString:@" "];
        _timeText.text = [NSString stringWithFormat:@"%@",timeArr[1]];
    }else
    {
        _headerImage.hidden = YES;
        _dayText.text = @"";
        _weekText.text = @"";
        _dateText.text = @"";
        _nickText.text = @"";
        _timeText.text = @"";
    }
}
- (void)ShowBannerView:(ShowBannerView *)bannerView didSelectedAt:(NSInteger)index{
    if(index<_temArray.count){
       //进入详情
    }
}
@end
