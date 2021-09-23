//
//  LBLeadPageController.m
//  LearnBorrowH5
//
//  Created by 理享学 on 2021/3/12.
//  Copyright © 2021 LearnBorrow. All rights reserved.
//

//字体类型
#define Font_Bold @"PingFangSC-Semibold"
#define Font_Medium @"PingFangSC-Medium"
#define Font_Regular @"PingFangSC-Regular"
/********************屏幕宽和高*******************/
#define LBScreenW [UIScreen mainScreen].bounds.size.width
#define LBScreenH [UIScreen mainScreen].bounds.size.height
#define LBkWindowFrame [[UIScreen mainScreen] bounds]
//16进制颜色设置
#define LBUIColorWithRGB(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]
#define LBFontNameSize(name,s) [UIFont fontWithName:name size:(LBScreenW > 374 ? (LBScreenW > 375 ?s * 1.1 : s) :s / 1.1)]
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//根据屏幕宽度计算对应View的高
#define LBFit(value) ((value * LBScreenW) / 375.0f)

#import "LBLeadPageController.h"
#import "UIView+Extension.h"
#import "UIImage+Extension.h"

#define XXNewfeatureImageCount 3

@interface LBLeadPageController () <UIScrollViewDelegate>

/**点击**/
typedef void(^Callback)(void);
@property(nonatomic,copy)Callback callback;

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, assign)CGFloat beginContentOffsetX;

@property(strong, nonatomic)UIImageView *pageOneView;
@property(strong, nonatomic)UIImageView *pageTwoView;
@property(strong, nonatomic)UIImageView *pageThreeView;

// 1
@property(strong, nonatomic)UILabel *OneTopTitleLabel;
@property(strong, nonatomic)UILabel *OneBottomTitleLabel;
@property(strong, nonatomic)UIImageView *OnePageImageView;
@property(strong, nonatomic)UIImageView *OnePageControll;

// 2
@property(strong, nonatomic)UILabel *TwoTopTitleLabel;
@property(strong, nonatomic)UILabel *TwoBottomTitleLabel;
@property(strong, nonatomic)UIImageView *TwoPageImageView;
@property(strong, nonatomic)UIImageView *TwoPageControll;

// 3
@property(strong, nonatomic)UILabel *ThreeTopTitleLabel;
@property(strong, nonatomic)UILabel *ThreeBottomTitleLabel;
@property(strong, nonatomic)UIImageView *ThreePageImageView;
@property(strong, nonatomic)UIImageView *ThreePageControll;
@property(strong, nonatomic)UIButton *insertAppBtn;

@property(assign, nonatomic)CGFloat top;
@property(assign, nonatomic)CGFloat controllTop;
@property(strong, nonatomic)NSMutableArray* colors;

@end

@implementation LBLeadPageController

-(instancetype)initWithClickInsertApp:(void(^)(void))block {
    if (self=[super init]) {
        self.callback = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createScrollView];
}

- (void)createScrollView {
    self.beginContentOffsetX = 0.0;
    self.top = kStatusBarHeight > 20.0 ?LBFit(88):LBFit(64);
    self.controllTop = kStatusBarHeight > 20.0 ?LBFit(87):LBFit(53);
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = self.view.bounds;
    CGFloat contentW = self.scrollView.bounds.size.width * XXNewfeatureImageCount;
    self.scrollView.contentSize = CGSizeMake(contentW, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    // 添加图片
    CGFloat imageW = self.scrollView.bounds.size.width;
    CGFloat imageH = self.scrollView.bounds.size.height;

    UIImage* img = [UIImage lb_createImageWithSize:CGSizeMake(self.scrollView.width, self.scrollView.height) gradientColors:self.colors percentage:@[@0.1,@0.7,@1.0] gradientType:LBImageGradientFromLeftTopToRightBottom];
    
    [self OnePageW:imageW H:imageH bgImg:img];
    [self TwoPageW:imageW H:imageH bgImg:img];
    [self ThreePageW:imageW H:imageH bgImg:img];
}

// 1
- (void)OnePageW:(CGFloat)W H:(CGFloat)H bgImg:(UIImage *)bgImg {
    // 第1张
    self.pageOneView = [[UIImageView alloc] init];
    self.pageOneView.frame = CGRectMake(0 * W, 0, W, H);
    self.pageOneView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.pageOneView];
    self.pageOneView.image = bgImg;

    self.OnePageImageView.frame = CGRectMake((self.pageOneView.width-LBFit(324))/2,self.top+LBFit(50), LBFit(324), LBFit(241));
    [self.pageOneView addSubview:self.OnePageImageView];
    self.OneTopTitleLabel.frame = CGRectMake((self.pageOneView.width-LBFit(300))/2, CGRectGetMaxY(self.OnePageImageView.frame)+LBFit(70), LBFit(300), LBFit(30));
    [self.pageOneView addSubview:self.OneTopTitleLabel];
    self.OneBottomTitleLabel.frame = CGRectMake((self.pageOneView.width-LBFit(300))/2, CGRectGetMaxY(self.OneTopTitleLabel.frame)+LBFit(20), CGRectGetWidth(self.OneTopTitleLabel.frame), CGRectGetHeight(self.OneTopTitleLabel.frame));
    [self.pageOneView addSubview:self.OneBottomTitleLabel];
    self.OnePageControll.frame = CGRectMake((self.pageOneView.width-LBFit(75))/2, self.pageOneView.height-LBFit(self.controllTop), LBFit(75), LBFit(15));
    [self.pageOneView addSubview:self.OnePageControll];
}
// 2
- (void)TwoPageW:(CGFloat)W H:(CGFloat)H bgImg:(UIImage *)bgImg {
    // 第2张
    self.pageTwoView = [[UIImageView alloc] init];
    self.pageTwoView.frame = CGRectMake(1 * W, 0, W, H);
    self.pageTwoView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.pageTwoView];
    self.pageTwoView.image = bgImg;
    
    self.TwoPageImageView.frame = CGRectMake((self.pageTwoView.width-LBFit(324))/2, self.top+LBFit(50), LBFit(324), LBFit(241));
    [self.pageTwoView addSubview:self.TwoPageImageView];
    
    self.TwoTopTitleLabel.frame = CGRectMake((self.pageTwoView.width-LBFit(300))/2, CGRectGetMaxY(self.TwoPageImageView.frame)+LBFit(70), CGRectGetWidth(self.OneTopTitleLabel.frame), CGRectGetHeight(self.OneTopTitleLabel.frame));
    [self.pageTwoView addSubview:self.TwoTopTitleLabel];
    self.TwoBottomTitleLabel.frame = CGRectMake((self.pageTwoView.width-LBFit(300))/2, CGRectGetMaxY(self.TwoTopTitleLabel.frame)+(LBFit(20)), CGRectGetWidth(self.OneTopTitleLabel.frame), CGRectGetHeight(self.OneTopTitleLabel.frame));
    [self.pageTwoView addSubview:self.TwoBottomTitleLabel];

    self.TwoPageControll.frame = CGRectMake((self.pageTwoView.width-LBFit(75))/2, self.pageTwoView.height-LBFit(self.controllTop), LBFit(75), LBFit(15));
    [self.pageTwoView addSubview:self.TwoPageControll];
}
// 3
- (void)ThreePageW:(CGFloat)W H:(CGFloat)H bgImg:(UIImage *)bgImg{
    // 第3张
    self.pageThreeView = [[UIImageView alloc] init];
    self.pageThreeView.frame = CGRectMake(2 * W, 0, W, H);
    self.pageThreeView.backgroundColor = [UIColor whiteColor];
    self.pageThreeView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.pageThreeView];
    self.pageThreeView.image = bgImg;
    
    self.ThreePageImageView.frame = CGRectMake((self.pageTwoView.width-LBFit(324))/2, self.top+LBFit(50), LBFit(324), LBFit(241));
    [self.pageThreeView addSubview:self.ThreePageImageView];
    
    self.ThreeTopTitleLabel.frame = CGRectMake((self.pageThreeView.width-LBFit(300))/2,CGRectGetMaxY(self.ThreePageImageView.frame)+LBFit(70), CGRectGetWidth(self.OneTopTitleLabel.frame), CGRectGetHeight(self.OneTopTitleLabel.frame));
    [self.pageThreeView addSubview:self.ThreeTopTitleLabel];
    self.ThreeBottomTitleLabel.frame = CGRectMake((self.pageThreeView.width-LBFit(300))/2, CGRectGetMaxY(self.ThreeTopTitleLabel.frame)+LBFit(20), CGRectGetWidth(self.OneTopTitleLabel.frame), CGRectGetHeight(self.OneTopTitleLabel.frame));
    [self.pageThreeView addSubview:self.ThreeBottomTitleLabel];
    
    self.ThreePageControll.frame = CGRectMake((self.pageThreeView.width-LBFit(75))/2, self.pageThreeView.height-LBFit(self.controllTop), LBFit(75), LBFit(15));
    [self.pageThreeView addSubview:self.ThreePageControll];
    
    self.insertAppBtn.frame = CGRectMake((self.pageThreeView.width-LBFit(130))/2, CGRectGetHeight(self.pageThreeView.frame)-LBFit(self.controllTop)-LBFit(65), LBFit(130), LBFit(35));
    [self.pageThreeView addSubview:self.insertAppBtn];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger a=scrollView.contentOffset.x;
    NSInteger c=LBScreenW;
    CGFloat b=a%c;
    CGFloat rate = (b/LBScreenW);
    if  (rate != 0 && (scrollView.contentOffset.x) > 0) {
        if (scrollView.contentOffset.x - self.beginContentOffsetX > 0) {
            //
            // 从左到右滑动
            //
            if (self.scrollView.contentOffset.x > LBScreenW ){
                //从第二到第三张
                 [self scrollPageTwoAnimate:rate];
            } else if (scrollView.contentOffset.x > 0) {
                //从第一到第二张
                 [self scrollPageOneAnimate:rate];
            }
        } else {
            //
            // 从右到左滑动
            //
            if (scrollView.contentOffset.x < LBScreenW) {
                //从第二到第一张
                 [self scrollPageOneAnimate:rate];
            } else if (scrollView.contentOffset.x < LBScreenW * 2) {
                //从第三到第二张
                 [self scrollPageTwoAnimate:rate];
            }
        }
    }
}

// 1-2
- (void)scrollPageOneAnimate:(CGFloat)rate {
    self.OneTopTitleLabel.alpha = 1-(rate*2);
    self.OneBottomTitleLabel.alpha = 1-(rate*2);
    self.OnePageImageView.alpha = 1-(rate*2);
    self.OnePageControll.alpha = 1-(rate*2);
    
    self.OnePageImageView.frame = CGRectMake((self.pageOneView.width-LBFit(324))/2, (self.top+LBFit(50))*(1-rate*2), LBFit(324), LBFit(241));
    self.OneTopTitleLabel.frame = CGRectMake((self.pageOneView.width-LBFit(300))/2, (LBFit(241)+LBFit(70))+(self.top+LBFit(50))*(1+rate*2), LBFit(300), LBFit(30));
        self.OneBottomTitleLabel.frame = CGRectMake((self.pageOneView.width-LBFit(300))/2, (LBFit(241)+LBFit(70)+LBFit(50))+(self.top+LBFit(50))*(1+rate*2), LBFit(300), LBFit(30));
    self.OnePageControll.frame = CGRectMake((self.pageOneView.width-LBFit(75))/2, (self.pageOneView.height-LBFit(self.controllTop))*(1+rate/2), LBFit(75), LBFit(15));
    
    CGFloat pageTwoViewTransform = rate + 0.3 > 1 ? 1 : rate + 0.3;
    self.TwoTopTitleLabel.alpha = rate;
    self.TwoTopTitleLabel.transform = CGAffineTransformMakeScale(pageTwoViewTransform, pageTwoViewTransform);
    self.TwoBottomTitleLabel.alpha = rate;
    self.TwoBottomTitleLabel.transform = CGAffineTransformMakeScale(pageTwoViewTransform, pageTwoViewTransform);
    self.TwoPageImageView.alpha = rate;
    self.TwoPageImageView.transform = CGAffineTransformMakeScale(pageTwoViewTransform, pageTwoViewTransform);
    self.TwoPageControll.alpha = rate;
    self.TwoPageControll.transform = CGAffineTransformMakeScale(pageTwoViewTransform, pageTwoViewTransform);
}
// 2-3
- (void)scrollPageTwoAnimate:(CGFloat)rate {
    CGFloat pageThreeBgImgTransform = rate + 0.3 > 1 ? 1 : rate + 0.3;
    
    self.TwoTopTitleLabel.transform = CGAffineTransformMakeScale(1-rate/2,1-rate/2);
    self.TwoTopTitleLabel.alpha = 1-rate*2;
    self.TwoBottomTitleLabel.transform = CGAffineTransformMakeScale(1-rate/2,1-rate/2);
    self.TwoBottomTitleLabel.alpha = 1-rate*2;
    self.TwoPageImageView.transform = CGAffineTransformMakeScale(1-rate/2,1-rate/2);
    self.TwoPageImageView.alpha = 1-rate*2;
    self.TwoPageControll.transform = CGAffineTransformMakeScale(1-rate/2,1-rate/2);
    self.TwoPageControll.alpha = 1-rate*2;

    self.ThreeTopTitleLabel.alpha = rate;
    self.ThreeBottomTitleLabel.alpha = rate;
    self.ThreePageImageView.alpha = rate;
    self.insertAppBtn.alpha = rate;
    self.ThreePageControll.alpha = rate;
    
    self.ThreePageImageView.frame = CGRectMake((self.pageThreeView.width-LBFit(324))/2, (self.top+LBFit(50))*(1-(1-rate)), LBFit(324), LBFit(241));
    self.ThreeTopTitleLabel.frame = CGRectMake((self.pageThreeView.width-LBFit(300))/2, (self.top+LBFit(50)+LBFit(241)+LBFit(70))+(self.top+LBFit(50))*(1-rate), LBFit(300), LBFit(30));
    self.ThreeBottomTitleLabel.frame = CGRectMake((self.pageThreeView.width-LBFit(300))/2, (self.top+LBFit(50)+LBFit(241)+LBFit(70)+LBFit(50))+(self.top+LBFit(50))*(1-rate), LBFit(300), LBFit(30));
    self.insertAppBtn.transform = CGAffineTransformMakeScale(pageThreeBgImgTransform,pageThreeBgImgTransform);
    self.ThreePageControll.transform = CGAffineTransformMakeScale(pageThreeBgImgTransform,pageThreeBgImgTransform);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.beginContentOffsetX = scrollView.contentOffset.x;
}

- (UILabel *)OneTopTitleLabel {
    if (!_OneTopTitleLabel) {
        _OneTopTitleLabel = [UILabel new];
        _OneTopTitleLabel.text = @"一切都非常简单";
        _OneTopTitleLabel.textColor = LBUIColorWithRGB(0xEA521A, 1.0);
        _OneTopTitleLabel.font = LBFontNameSize(Font_Regular, 22);
        _OneTopTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _OneTopTitleLabel;
}
- (UILabel *)OneBottomTitleLabel {
    if (!_OneBottomTitleLabel) {
        _OneBottomTitleLabel = [UILabel new];
        _OneBottomTitleLabel.text = @"划出你的喜怒哀乐";
        _OneBottomTitleLabel.textColor = _OneTopTitleLabel.textColor;
        _OneBottomTitleLabel.font = LBFontNameSize(Font_Regular, 15);
        _OneBottomTitleLabel.textAlignment = _OneTopTitleLabel.textAlignment;
    }
    return _OneBottomTitleLabel;
}
- (UIImageView *)OnePageImageView {
    if (!_OnePageImageView) {
        _OnePageImageView = [UIImageView new];
        _OnePageImageView.image = [self imageWithName:@"leadImage1"];
    }
    return _OnePageImageView;
}
- (UIImageView *)OnePageControll {
    if (!_OnePageControll) {
        _OnePageControll = [UIImageView new];
        _OnePageControll.image = [self imageWithName:@"controllImg1"];
    }
    return _OnePageControll;
}
// 2
- (UILabel *)TwoTopTitleLabel {
    if (!_TwoTopTitleLabel) {
        _TwoTopTitleLabel = [UILabel new];
        _TwoTopTitleLabel.text = @"记录下你的今天吧";
        _TwoTopTitleLabel.textColor = self.OneTopTitleLabel.textColor;
        _TwoTopTitleLabel.font = self.OneTopTitleLabel.font;
        _TwoTopTitleLabel.textAlignment = self.OneTopTitleLabel.textAlignment;
    }
    return _TwoTopTitleLabel;
}
- (UILabel *)TwoBottomTitleLabel {
    if (!_TwoBottomTitleLabel) {
        _TwoBottomTitleLabel = [UILabel new];
        _TwoBottomTitleLabel.text = @"那些让你喜笑颜开的";
        _TwoBottomTitleLabel.textColor = self.OneBottomTitleLabel.textColor;
        _TwoBottomTitleLabel.font = self.OneBottomTitleLabel.font;
        _TwoBottomTitleLabel.textAlignment = self.OneBottomTitleLabel.textAlignment;
    }
    return _TwoBottomTitleLabel;
}
- (UIImageView *)TwoPageImageView {
    if (!_TwoPageImageView) {
        _TwoPageImageView = [UIImageView new];
        _TwoPageImageView.image = [self imageWithName:@"leadImage2"];
    }
    return _TwoPageImageView;
}
- (UIImageView *)TwoPageControll {
    if (!_TwoPageControll) {
        _TwoPageControll = [UIImageView new];
        _TwoPageControll.image = [self imageWithName:@"controllImg2"];
    }
    return _TwoPageControll;
}
// 3
- (UILabel *)ThreeTopTitleLabel {
    if (!_ThreeTopTitleLabel) {
        _ThreeTopTitleLabel = [UILabel new];
        _ThreeTopTitleLabel.text = @"我们在万千人和书中寻找最爱";
        _ThreeTopTitleLabel.textColor = self.OneTopTitleLabel.textColor;
        _ThreeTopTitleLabel.font = self.OneTopTitleLabel.font;
        _ThreeTopTitleLabel.textAlignment = self.OneTopTitleLabel.textAlignment;
    }
    return _ThreeTopTitleLabel;
}
- (UILabel *)ThreeBottomTitleLabel {
    if (!_ThreeBottomTitleLabel) {
        _ThreeBottomTitleLabel = [UILabel new];
        _ThreeBottomTitleLabel.text = @"找到了就爱它一生一世";
        _ThreeBottomTitleLabel.textColor = self.OneBottomTitleLabel.textColor;
        _ThreeBottomTitleLabel.font = self.OneBottomTitleLabel.font;
        _ThreeBottomTitleLabel.textAlignment = self.OneBottomTitleLabel.textAlignment;
    }
    return _ThreeBottomTitleLabel;
}
- (UIImageView *)ThreePageImageView {
    if (!_ThreePageImageView) {
        _ThreePageImageView = [UIImageView new];
        _ThreePageImageView.image = [self imageWithName:@"leadImage3"];
    }
    return _ThreePageImageView;
}
- (UIButton *)insertAppBtn {
    if (!_insertAppBtn) {
        _insertAppBtn = [UIButton new];
        [_insertAppBtn setTitle:@"立即开启" forState:UIControlStateNormal];
        [_insertAppBtn setTitleColor:LBUIColorWithRGB(0xEA521A, 1.0) forState:UIControlStateNormal];
        _insertAppBtn.titleLabel.font = LBFontNameSize(Font_Regular, 15);
        _insertAppBtn.layer.borderWidth = 1;
        _insertAppBtn.layer.borderColor = _insertAppBtn.titleLabel.textColor.CGColor;
        _insertAppBtn.layer.cornerRadius = 35/2;
        _insertAppBtn.clipsToBounds = YES;
        [_insertAppBtn addTarget:self action:@selector(inserAppAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _insertAppBtn;
}

- (UIImageView *)ThreePageControll {
    if (!_ThreePageControll) {
        _ThreePageControll = [UIImageView new];
        _ThreePageControll.image = [self imageWithName:@"controllImg3"];
    }
    return _ThreePageControll;
}

- (void)inserAppAction {
    if (self.callback) {
        self.callback();
    }
}

- (NSMutableArray *)colors {
    if (!_colors) {
        _colors = @[LBUIColorWithRGB(0xFFFFFF, 1.0)].mutableCopy;
    }
    return _colors;
}

- (UIImage *)imageWithName:(NSString *)imageName {
    // 图像文件包
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"images" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    NSString *fileName = [NSString stringWithFormat:@"%@@2x", imageName];
    NSString *path = [imageBundle pathForResource:fileName ofType:@"png"];
    
    return [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAutomatic];
}

@end


