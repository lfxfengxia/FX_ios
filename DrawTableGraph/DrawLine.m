//
//  ZXView.m
//  折线图
//
//  Created by iOS on 16/6/28.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "DrawLine.h"

@interface DrawLine ()<CAAnimationDelegate>

@property (nonatomic) int columCount;
@property (nonatomic) int rowCount;

@property (nonatomic, strong) CAShapeLayer *lineChartLayer;
@property (nonatomic, strong) UIBezierPath * path1;
/** 渐变背景视图 */
@property (nonatomic, strong) UIView *gradientBackgroundView;
/** 渐变图层 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
/** 颜色数组 */
@property (nonatomic, strong) NSMutableArray *gradientLayerColors;

@end

@implementation DrawLine

static CGFloat bounceX = 30;
static CGFloat bounceY = 20;
static bool isDraw = NO;//折现是否存在

- (instancetype)initWithFrame:(CGRect)frame withColumCount:(int)columCount rowCount:(int)rowCount {
    
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor whiteColor];
        self.columCount = columCount;
        self.rowCount = rowCount;
        
        [self createLabelX];
        [self createLabelY];
        [self drawGradientLayer];
        [self setHorLineDash];
//        [self setVerLineDash];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    /*******画出坐标轴********/
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextMoveToPoint(context, bounceX, bounceY);
    CGContextAddLineToPoint(context, bounceX, rect.size.height - bounceY);
    CGContextAddLineToPoint(context,rect.size.width -  bounceX, rect.size.height - bounceY);
    CGContextStrokePath(context);
}

#pragma mark 添加横向虚线
- (void)setHorLineDash{

    for (NSInteger i = 1;i < self.rowCount; i++ ) {
        
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
          dashLayer.strokeColor = [UIColor whiteColor].CGColor;
        dashLayer.fillColor = [[UIColor clearColor] CGColor];
        // 默认设置路径宽度为0，使其在起始状态下不显示
        dashLayer.lineWidth = 0.6;

        UILabel * label1 = (UILabel*)[self viewWithTag:2000 + i];
        
        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
        UIColor * color = [UIColor blueColor];
        
        [color set];
        [path moveToPoint:CGPointMake(0, label1.frame.origin.y - bounceY)];
        [path addLineToPoint:CGPointMake(self.frame.size.width - 2*bounceX,label1.frame.origin.y - bounceY)];
        NSArray *dash = @[@3,@2];
        [path stroke];
        dashLayer.path = path.CGPath;
        dashLayer.lineDashPattern = dash;
        [self.gradientLayer addSublayer:dashLayer];
    }
}

#pragma mark 添加纵向虚线
- (void)setVerLineDash{
    
    for (NSInteger i = 1;i < self.columCount; i++ ) {
        
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor whiteColor].CGColor;
        dashLayer.fillColor = [[UIColor clearColor] CGColor];
        // 默认设置路径宽度为0，使其在起始状态下不显示
        dashLayer.lineWidth = 0.6;
        
        UILabel * label1 = (UILabel*)[self viewWithTag:1000 + i];
        
        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
        UIColor * color = [UIColor blueColor];
        
        [color set];
        [path moveToPoint:CGPointMake(label1.frame.origin.x - bounceX, 0)];
        [path addLineToPoint:CGPointMake(label1.frame.origin.x - bounceX,self.frame.size.height - 2*bounceY)];
        NSArray *dash = @[@3,@2];
        [path stroke];
        dashLayer.path = path.CGPath;
        dashLayer.lineDashPattern = dash;
        [self.gradientLayer addSublayer:dashLayer];
    }
}

#pragma mark 画折线图
- (void)drawLine{
    
    CGFloat maxY = [self.yDataArray[self.rowCount] floatValue];
    
    UILabel * label = (UILabel*)[self viewWithTag:1000];
    UIBezierPath * path = [[UIBezierPath alloc]init];
    path.lineWidth = 1.0;
    self.path1 = path;
    UIColor * color = [UIColor greenColor];
    [color set];
    //创建折现点标记
    for (NSInteger i = 0; i< self.dataArray.count; i++) {
        
        UILabel * label1 = (UILabel*)[self viewWithTag:1000 + i];
        CGFloat y = [self.dataArray[i] floatValue];
        
        if (i == 0) {
            
            [path moveToPoint:CGPointMake( label.frame.origin.x - bounceX, (maxY - y) /maxY * (self.frame.size.height - bounceY*2 ))];
        }else {
            
            [path addLineToPoint:CGPointMake(label1.frame.origin.x - bounceX,  (maxY -y) /maxY * (self.frame.size.height - bounceY*2 ) )];
        }
        //tianjia
        UILabel * falglabel = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x , (maxY -y) /maxY * (self.frame.size.height - bounceY*2 )+ bounceY, 30, 15)];
        if (y < 100) {
            
            falglabel.frame = CGRectMake(label1.frame.origin.x, (maxY -y) /maxY * (self.frame.size.height - bounceY*2 )+ bounceY - 10, 30, 15);
        }
        falglabel.tag = 3000+ i;
        falglabel.text = [NSString stringWithFormat:@"%.1f",y];
        falglabel.font = [UIFont systemFontOfSize:8.0];
        [self addSubview:falglabel];
    }
    // [path stroke];
    
    self.lineChartLayer = [CAShapeLayer layer];
    self.lineChartLayer.path = path.CGPath;
    self.lineChartLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
    // 默认设置路径宽度为0，使其在起始状态下不显示
    self.lineChartLayer.lineWidth = 0;
    self.lineChartLayer.lineCap = kCALineCapRound;
    self.lineChartLayer.lineJoin = kCALineJoinRound;
    
    [self.gradientLayer addSublayer:self.lineChartLayer];

}
#pragma mark 创建x轴的数据
- (void)createLabelX {
    
    for (NSInteger i = 0; i < self.columCount; i++) {
        UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 2*bounceX)/self.columCount * i + bounceX, self.frame.size.height - bounceY + bounceY*0.3, (self.frame.size.width - 2*bounceX)/self.columCount- 2, bounceY/2)];
        LabelMonth.tag = 1000 + i;
        LabelMonth.font = [UIFont systemFontOfSize:10];
        LabelMonth.transform = CGAffineTransformMakeRotation(M_PI * 0.1);
        [self addSubview:LabelMonth];
    }
}

- (void)setXDataArray:(NSArray *)xDataArray {

    _xDataArray = [xDataArray copy];
    
    for (int i = 0; i < self.columCount; i ++) {
        
        UILabel *label = (UILabel *)[self viewWithTag:1000 + i];
        label.text = xDataArray[i];
    }
}

#pragma mark 创建y轴数据
- (void)createLabelY{
    
    for (NSInteger i = 0; i < self.rowCount; i++) {
        
        UILabel * labelYdivision = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.frame.size.height - 2 * bounceY)/self.rowCount *i + bounceY, bounceX, bounceY/2.0)];
        labelYdivision.tag = 2000 + i;
        labelYdivision.textAlignment = NSTextAlignmentCenter;
        labelYdivision.text = [NSString stringWithFormat:@"%.1f",(self.rowCount - i)*100.0];
        labelYdivision.font = [UIFont systemFontOfSize:10];
        [self addSubview:labelYdivision];
    }
}

- (void)setYDataArray:(NSArray *)yDataArray {

    _yDataArray = [yDataArray copy];
    
    for (int i = self.rowCount - 1; i >= 0; i --) {
        
        UILabel *label = (UILabel *)[self viewWithTag:2000 + self.rowCount - 1 - i];
        label.text = yDataArray[i];
    }
}

#pragma mark 渐变的颜色
- (void)drawGradientLayer {
 
    /** 创建并设置渐变背景图层（不包含坐标轴） */
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = CGRectMake(bounceX, bounceY, self.bounds.size.width - bounceX * 2, self.bounds.size.height - 2 * bounceY);
    [self.layer addSublayer:self.gradientLayer];
    //设置渐变区域的起始和终止位置（范围为0-1），即渐变路径
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    //设置颜色的渐变过程
    self.gradientLayerColors = [NSMutableArray arrayWithArray:@[(__bridge id)[UIColor colorWithRed:253 / 255.0 green:164 / 255.0 blue:8 / 255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:251 / 255.0 green:37 / 255.0 blue:45 / 255.0 alpha:1.0].CGColor]];
    self.gradientLayer.colors = self.gradientLayerColors;
    //将CAGradientlayer对象添加在我们要设置背景图层layer
    [self.layer addSublayer:self.gradientLayer];
}

#pragma mark 点击重新绘制折线和背景
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (isDraw) {
        [self.lineChartLayer removeFromSuperlayer];
        for (NSInteger i = 0; i < 12; i++) {
            UILabel * label = (UILabel*)[self viewWithTag:3000 + i];
            [label removeFromSuperview];
        }
    }else{

        [self drawLine];

        self.lineChartLayer.lineWidth = 2;
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 3;
        pathAnimation.repeatCount = 1;
        pathAnimation.removedOnCompletion = YES;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
        pathAnimation.delegate = self;
        [self.lineChartLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    }
    
    isDraw = !isDraw;
}
- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"开始®");
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"停止~~~~~~~~");
}
@end
