//
//  LRateStar.h
//  LRateStar
//
//  Created by ponted on 2018/3/1.
//  Copyright © 2018年 Shenzhen Blood Link Medical Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface rateStarModel:NSObject

@property (nonatomic, assign) NSInteger numberOfStars;//必传

@property (nonatomic, copy) NSString *norImageName;//默认有图片 不是必传

@property (nonatomic, copy) NSString *selectImageName;//默认有图片 不是必传

@property (nonatomic, assign) BOOL isAnimation;//默认无动画 不是必传


@end

@class LRateStar;

typedef void(^finishBlock)(CGFloat currentScore);

typedef enum : NSUInteger {
    WholeStar, //整个星星 0
    HalfStar,  //半个星星 1
    IncompleteStar, //允许不完整的星星 2
} StarStyle;

@protocol CCStarRateDelegate<NSObject>

-(void)starRateView:(LRateStar *)starRateView currentScore:(CGFloat)currentScore;

@end

@interface LRateStar : UIView

@property (nonatomic,assign)CGFloat currentScore;    // 当前评分：0-5  默认0
@property (nonatomic,assign)BOOL isAnimation;        //是否动画显示，默认NO
@property (nonatomic,assign)StarStyle rateStyle;     //评分样式    默认WholeStar
@property (nonatomic, assign) id<CCStarRateDelegate> delegate;


-(instancetype)initWithFrame:(CGRect)frame  rateStyle:(StarStyle)rateStyle  rateModel:(rateStarModel *)rateModel  delegate:(id)delegate;


//block当做一个参数传递
-(instancetype)initWithFrame:(CGRect)frame  rateStyle:(StarStyle)rateStyle rateModel:(rateStarModel *)rateModel finish:(finishBlock)finish;


@end
