//
//  UIView+Extension.m
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

/********************屏幕宽和高*******************/
#define LBScreenW [UIScreen mainScreen].bounds.size.width
#define LBScreenH [UIScreen mainScreen].bounds.size.height
#define LBkWindowFrame [[UIScreen mainScreen] bounds]
//字体类型
#define Font_Bold @"PingFangSC-Semibold"
#define Font_Medium @"PingFangSC-Medium"
#define Font_Regular @"PingFangSC-Regular"
//16进制颜色设置
#define LBUIColorWithRGB(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]
#define LBFontNameSize(name,s) [UIFont fontWithName:name size:(LBScreenW > 374 ? (LBScreenW > 375 ?s * 1.1 : s) :s / 1.1)]
//根据屏幕宽度计算对应View的高
#define LBFit(value) ((value * LBScreenW) / 375.0f)

#import "UIView+Extension.h"
#import <objc/runtime.h>

@implementation UIView (Extension)

- (void)setX:(CGFloat)x{
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    
    self.frame = frame;
}

- (CGFloat)x{
    
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    
    self.frame = frame;
}

- (CGFloat)y{
    
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width{
    
    CGRect frame = self.frame;
    frame.size.width = width;
    
    self.frame = frame;
}

- (CGFloat)width{
    
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    
    CGRect frame = self.frame;
    frame.size.height = height;
    
    self.frame = frame;
}

- (CGFloat)height{
    
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size{
    
    CGRect frame = self.frame;
    frame.size = size;
    
    self.frame = frame;
}

- (CGSize)size{
    
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX{
    
    CGPoint center = self.center;
    center.x = centerX;
    
    self.center = center;
}

- (CGFloat)centerX{
    
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    
    CGPoint center = self.center;
    center.y = centerY;
    
    self.center = center;
}

- (CGFloat)centerY{
    
    return self.center.y;
}

- (void)setLeft:(CGFloat)left{
    
    self.x = left;
}

- (CGFloat)left{
    
    return self.x;
}

- (void)setTop:(CGFloat)top{
    
    self.y = top;
}

- (CGFloat)top{
    
    return self.y;
}

- (void)setRight:(CGFloat)right{
    
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    
    self.frame = frame;
}

- (CGFloat)right{
    
    return CGRectGetMaxX(self.frame);
}

- (void)setBottom:(CGFloat)bottom{
    
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    
    self.frame = frame;
}

- (CGFloat)bottom{
    
    return CGRectGetMaxY(self.frame);
}

+ (UIView *)addLineWithFrame:(CGRect)frame WithView:(UIView *)view{
    
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lineView];
    
    return lineView;
    
}

///创建一个view的对象
+(UIView*)CreateViewWithFrame:(CGRect)frame BackgroundColor:(UIColor*)color InteractionEnabled:(BOOL)enabled{

    UIView * view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=color;
    view.userInteractionEnabled=enabled;
    return view;
}

/**
 *  获取最大的y
 *
 */
- (void)setMaxY:(CGFloat)maxY{
    
    self.y = maxY - self.height;
    
}

- (CGFloat)maxY{
    
    return CGRectGetMaxY(self.frame);
    
}

+ (void) getGradientWithFirstColor:(UIColor *)firstColor SecondColor:(UIColor *)secondColor WithView:(UIView *)view {
    CAGradientLayer * gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)firstColor.CGColor,(id)secondColor.CGColor];
    gradient.startPoint = CGPointMake(0, 1);
    gradient.endPoint = CGPointMake(1, 0);
    [view.layer addSublayer:gradient];
}

+ (void)addRefreshBGView:(UIView *)BGView ColorArray:(NSArray *)colorArray Locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectOffset(BGView.bounds, 0, -BGView.bounds.size.height)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    gradientLayer.bounds = bgView.bounds;
    gradientLayer.borderWidth = 0;
    gradientLayer.frame = bgView.bounds;
    gradientLayer.colors = colorArray;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    [bgView.layer insertSublayer:gradientLayer atIndex:0];
    [BGView insertSubview:bgView atIndex:0];
}

/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 * shadowPathWidth 阴影的宽度，
 */

+ (void)LJX_AddShadowToView:(UIView *)theView SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(LJXShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth{
    
    theView.layer.masksToBounds = NO;
    theView.layer.shadowColor = shadowColor.CGColor;
    theView.layer.shadowOpacity = shadowOpacity;
    theView.layer.shadowRadius =  shadowRadius;
    theView.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;
    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat originW = theView.bounds.size.width;
    CGFloat originH = theView.bounds.size.height;
    
    switch (shadowPathSide) {
        case LJXShadowPathTop:
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW,  shadowPathWidth);
            break;
        case LJXShadowPathBottom:
            shadowRect  = CGRectMake(originX, originH -shadowPathWidth/2, originW, shadowPathWidth);
            break;
            
        case LJXShadowPathLeft:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
            
        case LJXShadowPathRight:
            shadowRect  = CGRectMake(originW - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case LJXShadowPathNoTop:
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY +1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case LJXShadowPathAllSide:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY - shadowPathWidth/2, originW +  shadowPathWidth, originH + shadowPathWidth);
            break;
    }
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
    theView.layer.shadowPath = path.CGPath;
}

/* 显示提示框的动画 */
+ (void)shakeToShow:(UIView*)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1,1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2,1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0,1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

+ (void)view:(UIView *)view WitchCorner:(UIRectCorner)corner WithCornerRadii:(CGSize)radSize{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corner cornerRadii:radSize];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    //    return maskLayer;
}

- (void)borderGradientColorWithColors:(NSArray *)colors radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth percentages:(NSArray *)percentages {
    [self layoutIfNeeded];
    CGSize buttonSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = percentages;
    gradientLayer.frame = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
    self.layer.cornerRadius = radius;
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    maskLayer.lineWidth = lineWidth;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:maskLayer.frame cornerRadius:radius];
    maskLayer.path = path.CGPath;
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    maskLayer.strokeColor = [UIColor blackColor].CGColor;
    gradientLayer.mask = maskLayer;
    gradientLayer.cornerRadius = radius;
    gradientLayer.masksToBounds = YES;

    gradientLayer.type = kCAGradientLayerAxial;
    [self.layer insertSublayer:gradientLayer atIndex:0];

    gradientLayer.shouldRasterize = self.layer.shouldRasterize = YES; // 光栅化，设置后会有缓存效果，提升运行效率
    gradientLayer.rasterizationScale = [UIScreen mainScreen].scale; // 如果不这样设置，在使用masksToBounds的时候可能会有锯齿状
}

- (void)showNoDataImageInView:(UIView *)view withImage:(NSString *)imageName title:(NSString *)title callback:(void (^)(void))callback{
    self.callBlock = callback;
    
    [self removeImageView:view];
    
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, LBFit(115), LBFit(203), LBFit(152))];
    imageView.size = CGSizeMake(LBFit(203), LBFit(152));
    imageView.centerX = view.centerX;
    imageView.centerY = view.centerY - imageView.height/2 - LBFit(50);
    imageView.image=[UIImage imageNamed:imageName];
    [view addSubview:imageView];
    imageView.tag=1000;
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = @"当前网络不可用，请检查你的网络设置";
    lable.tag = 1000;
    lable.textColor = LBUIColorWithRGB(0xEA521A, 1.0);
    lable.font = LBFontNameSize(Font_Regular, 15);
    [lable sizeToFit];
    lable.centerX = view.centerX;
    lable.centerY = imageView.bottom+LBFit(45);
    [view addSubview:lable];
    
    UIButton *subLabel = [[UIButton alloc] init];
    subLabel.size = CGSizeMake(LBFit(130), LBFit(35));
    [subLabel setTitle:title forState:UIControlStateNormal];
    [subLabel setTitleColor:LBUIColorWithRGB(0xEA521A, 1) forState:UIControlStateNormal];
//    subLabel.text = title;
    subLabel.tag = 1000;
//    subLabel.textColor = LBUIColorWithRGB(0xEA521A, 1.0);//LBUIColorWithRGB(0x0000EE, 1.0);
    subLabel.titleLabel.font = LBFontNameSize(Font_Regular, 15);
//    subLabel.textAlignment = NSTextAlignmentCenter;
//    [subLabel sizeToFit];
    subLabel.centerX = view.centerX;
    subLabel.centerY = lable.bottom+LBFit(60);
    subLabel.layer.cornerRadius = LBFit(17.5);
    subLabel.clipsToBounds = YES;
    subLabel.layer.borderColor = subLabel.titleLabel.textColor.CGColor;
    subLabel.layer.borderWidth = 1.0f;
    [subLabel addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:subLabel];
}

- (void)subAction {
    if (self.callBlock) {
        self.callBlock();
    }
}

- (void)hideNoDataImageInView:(UIView *)view{
    [self removeImageView:view];
}

- (void)removeImageView:(UIView *)view{
    //按照tag值进行移除
    for (UIImageView *subView in view.subviews) {
        
        if (subView.tag == 1000) {
            
            [subView removeFromSuperview];
        }
    }
}

- (void)setCallBlock:(ClickBlock)callBlock
{
    objc_setAssociatedObject(self, @selector(callBlock), callBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ClickBlock)callBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
