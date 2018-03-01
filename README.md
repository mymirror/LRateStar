# LRateStar

导入头文件 LRateStar.h

2中使用方法：

第一种 使用delegate 获取结果
-(instancetype)initWithFrame:(CGRect)frame  rateStyle:(StarStyle)rateStyle  rateModel:(rateStarModel *)rateModel  delegate:(id)delegate;

第二种 直接block返回结果
-(instancetype)initWithFrame:(CGRect)frame  rateStyle:(StarStyle)rateStyle rateModel:(rateStarModel *)rateModel finish:(finishBlock)finish;


