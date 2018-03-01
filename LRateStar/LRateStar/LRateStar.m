//
//  LRateStar.m
//  LRateStar
//
//  Created by ponted on 2018/3/1.
//  Copyright © 2018年 Shenzhen Blood Link Medical Technology Co., Ltd. All rights reserved.
//

#import "LRateStar.h"

#define placerBackImage [UIImage imageNamed:@"LRateStar.bundle/ic_star_nor"]

#define placerForegroundImage  [UIImage imageNamed:@"LRateStar.bundle/ic_star_pressed"]


@implementation rateStarModel

@end


typedef void(^completeBlock)(CGFloat currentScore);

@interface LRateStar()
{
    rateStarModel *starModel;
}

@property (nonatomic, strong) UIView *foregroundStarView;

@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;

@property (nonatomic, strong)completeBlock complete;

@end

@implementation LRateStar

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _numberOfStars = 5;
        
        _rateStyle = WholeStar;
        
        [self createStarView];
        
    }
    
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame  rateStyle:(StarStyle)rateStyle  rateModel:(rateStarModel *)rateModel  delegate:(id)delegate
{
    if (self = [super initWithFrame:frame]) {
        starModel = rateModel;
        
        _numberOfStars = rateModel.numberOfStars;
        
        _rateStyle = rateStyle;
        
        _isAnimation = rateModel.isAnimation;
        
        _delegate = delegate;
        
        [self createStarView];
        
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish{
    
    if (self = [super initWithFrame:frame]) {
        
        _numberOfStars = 5;
        
        _rateStyle = WholeStar;
        
        _complete = ^(CGFloat currentScore){
            
            finish(currentScore);
            
        };
        
        [self createStarView];
        
    }
    
    return self;
    
}



-(instancetype)initWithFrame:(CGRect)frame  rateStyle:(StarStyle)rateStyle rateModel:(rateStarModel *)rateModel finish:(finishBlock)finish
{
    if (self = [super initWithFrame:frame]) {
        starModel = rateModel;

        _numberOfStars = rateModel.numberOfStars;
        
        _rateStyle = rateStyle;
        
        _isAnimation = rateModel.isAnimation;
        
        _complete = ^(CGFloat currentScore){
            
            finish(currentScore);
            
        };
        
        [self createStarView];
        
    }
    
    return self;
}

#pragma mark - private Method

//调用这个方法来布局
-(void)createStarView{
    if (starModel.norImageName.length)
    {
        self.backgroundStarView = [self createStarViewWithImage:[UIImage imageNamed:starModel.norImageName]];
    }else
    {
        self.backgroundStarView = [self createStarViewWithImage:placerBackImage];
    }
    
    if (starModel.selectImageName.length)
    {
        self.foregroundStarView = [self createStarViewWithImage:[UIImage imageNamed:starModel.selectImageName]];
    }else
    {
        self.foregroundStarView = [self createStarViewWithImage:placerForegroundImage];
    }
    
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width*_currentScore/self.numberOfStars, self.bounds.size.height);
    
    [self addSubview:self.backgroundStarView];
    
    [self addSubview:self.foregroundStarView];
    
    //添加手势来取得所点击的位置
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    
    tapGesture.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:tapGesture];
    
}

//使用这个方法来初始化子View
- (UIView *)createStarViewWithImage:(UIImage *)image {
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    
    view.clipsToBounds = YES;
    
    view.backgroundColor = [UIColor clearColor];
    
    //根据传过来的星星的数量来布局有几个星星
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
        
    {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        
        //  保持图片内容的纵横比例，来适应视图的大小。
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [view addSubview:imageView];
        
    }
    
    return view;
    
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    
    //函数返回一个CGPoint类型的值，表示触摸在view这个视图上的位置，这里返回的位置是针对view的坐标系的。调用时传入的view参数为空的话，返回的时触摸点在整个窗口的位置。
    
    CGPoint tapPoint = [gesture locationInView:self];
    
    CGFloat offset = tapPoint.x;
    
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    
    switch (_rateStyle) {
            
        case WholeStar:
            
        {
            
            self.currentScore = ceilf(realStarScore);
            
            break;
            
        }
            
        case HalfStar:
            
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            
            break;
            
        case IncompleteStar:
            
            self.currentScore = realStarScore;
            
            break;
            
        default:
            
            break;
            
    }
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    
    __unsafe_unretained LRateStar *weakSelf = self;
    
    CGFloat animationTimeInterval = self.isAnimation ? 0.2 : 0;
    
    [UIView animateWithDuration:animationTimeInterval animations:^{
        
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.currentScore/self.numberOfStars, weakSelf.bounds.size.height);
        
    }];
    
}

-(void)setCurrentScore:(CGFloat)currentScore {
    
    if (_currentScore == currentScore) {
        
        return;
        
    }
    
    if (currentScore < 0) {
        
        _currentScore = 0;
        
    } else if (currentScore > _numberOfStars) {
        
        _currentScore = _numberOfStars;
        
    } else {
        
        _currentScore = currentScore;
        
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:currentScore:)]) {
        
        [self.delegate starRateView:self currentScore:_currentScore];
        
    }
    
    if (self.complete) {
        
        _complete(_currentScore);
        
    }
    //重新布局
    [self setNeedsLayout];
}




@end
