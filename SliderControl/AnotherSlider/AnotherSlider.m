//
//  AnotherSlider.m
//  SliderControl
//
//  Created by fanXing on 2017/6/26.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import "AnotherSlider.h"
#import <objc/runtime.h>

@interface CALayer (center)
@property (nonatomic,readwrite,assign) CGPoint center;
@end

static NSString *strKey = @"strCenterKey";

@implementation CALayer (center)

-(void) setCenter:(CGPoint)center{
    objc_setAssociatedObject(self, &strKey,NSStringFromCGPoint(center), OBJC_ASSOCIATION_COPY);
}
-(CGPoint) center {

    return CGPointFromString(objc_getAssociatedObject(self, &strKey));
}
@end



static NSString * const MYAnotherSlider = @"AnotherSlider";
@interface AnotherSlider(){
    
    SliderViewModel  *_sliderViewModel;
    
    DragMovingOffsetBlock _dragMovingOffsetBlock;//监听btn的移动
    DragPositionBlock _dragPositionBlock;//btn的移动最后停止的位置
    NSMutableDictionary *_layerMdic;
    UIButton *_carBtn;
}

@property (nonatomic,readwrite, assign) CGFloat slider_bar_width; // 线的宽度
@property (nonatomic,readwrite,assign) CGFloat slider_bar_height;//线的高度

@property (weak, nonatomic) IBOutlet UIView *sliderView;
@property (nonatomic,readwrite,strong) AnotherSlider *anotherSlider;
@property (nonatomic,readwrite,assign) CGFloat carButtonStepWidth;



@end

CGFloat const kTextFontSize = 16.0f;


//汽车btn的高度
#define CAR_BTN_HEIGHT 44
//汽车btn的宽度
#define CAR_BTN_WIDTH 44

#define RGB_HEX(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation AnotherSlider
@synthesize slider_bar_width = _slider_bar_width;
@synthesize slider_bar_height = _slider_bar_height;


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        
       
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//       [self addSubview:self.anotherSlider];
    }
    return self;
}


-(void )sliderViewModel:(SliderViewModel *)sliderViewModel{
    
     _sliderViewModel = sliderViewModel;
    
    
     [self addSubview:self.anotherSlider];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}
-(CGFloat) slider_bar_width{
    
    return CGRectGetWidth(self.frame) - 100;
}
-(CGFloat) slider_bar_height {

    CGFloat min = [_sliderViewModel.dotModelArr lastObject].sliderDotWidth ;
    for(DotModel *dotModel in _sliderViewModel.dotModelArr){
        
        if(min > dotModel.sliderDotWidth){
            min = dotModel.sliderDotWidth;
        }
    }
    
    
    return min *0.5;
}
-(CGFloat) carButtonStepWidth{

    return self.sliderView.frame.size.width / (_sliderViewModel.dotModelArr.count - 1);
}
/**
 * 加载UI  绘制线条 圆点
 */
-(AnotherSlider *)anotherSlider {
    
    if(!_anotherSlider){
        AnotherSlider *anotherSlider = [[[NSBundle mainBundle] loadNibNamed:MYAnotherSlider owner:self options:nil] firstObject];
        _anotherSlider = anotherSlider;
        _anotherSlider.backgroundColor = _sliderViewModel.sliderConfig.outerLayerColor;
        self.sliderView.backgroundColor = _sliderViewModel.sliderConfig.sliderColor;
       
    }
    return _anotherSlider;
}


-(void) layoutSubviews {
    
    if(!_sliderViewModel){
        NSLog(@"请设置SliderViewMode");
        return;
    }
    //设置约束，调用方法会得到正确的值
    [super layoutSubviews];
    self.anotherSlider.frame = self.bounds;
    if(!_layerMdic){
        _layerMdic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    
    NSMutableArray *textLayerMarr = _layerMdic[@"textLayerMarr"];
    if(!textLayerMarr){
        textLayerMarr = [NSMutableArray arrayWithCapacity:0];
    }
    if(textLayerMarr.count == 0){
        //textLayer
        for(DotModel *dotModel in _sliderViewModel.dotModelArr){
            
            CATextLayer  *textLayer = [self setupTextLayerWithTagModel:dotModel];
            //文本宽高
            CGSize textLayerSize = [textLayer preferredFrameSize];
            textLayer.bounds = CGRectMake(0, 0, textLayerSize.width, textLayerSize.height);
            [self.layer addSublayer:textLayer];
            [textLayerMarr addObject:textLayer];
        }
        
         _layerMdic[@"textLayerMarr"] = textLayerMarr;
    }
    
    
    CALayer  *sliderBorderLayer = _layerMdic[@"sliderBorderLayer"];
    if(!sliderBorderLayer){
        //绘制一条线
        sliderBorderLayer = [CALayer  layer];
        sliderBorderLayer.borderColor = [UIColor lightGrayColor].CGColor;
        sliderBorderLayer.borderWidth = 1;
        sliderBorderLayer.backgroundColor = [UIColor whiteColor].CGColor;
        sliderBorderLayer.cornerRadius = self.slider_bar_height /2.0;
        _layerMdic[@"sliderBorderLayer"] = sliderBorderLayer;
        [self.sliderView.layer addSublayer:sliderBorderLayer];
    }
    
    DotModel *dotModelFirst  =[_sliderViewModel.dotModelArr firstObject];
    DotModel *dotModelLast  =[_sliderViewModel.dotModelArr lastObject];
    
    CGFloat sliderWidthX =   (dotModelFirst.sliderDotWidth +dotModelLast.sliderDotWidth)/2.0;
    
    sliderBorderLayer.frame = CGRectMake(0, 0, self.slider_bar_width - sliderWidthX, self.slider_bar_height);
    
    CGRect sliderBorderLayerRect =  sliderBorderLayer.frame;
    sliderBorderLayerRect.origin = CGPointMake(dotModelFirst.sliderDotWidth/2, CGRectGetHeight(self.sliderView.frame)/2 -  self.slider_bar_height /2);
    sliderBorderLayer.frame = sliderBorderLayerRect;
    
    

    NSMutableArray *dotLayerMarr = _layerMdic[@"dotLayerMarr"];
    if(!dotLayerMarr){
        dotLayerMarr = [NSMutableArray arrayWithCapacity:0];
    }

    if(dotLayerMarr.count == 0){
        
        //小圆点
        for(DotModel *dotModel in _sliderViewModel.dotModelArr){
            unsigned long dotBackColor   =  [[self class] hexValueToUnsigned:dotModel.backColor];
            unsigned long dotBorderColor =[[self class] hexValueToUnsigned:dotModel.borderColor];
            CALayer *dotLayer = [CALayer layer];
            dotLayer.backgroundColor = [RGB_HEX(dotBackColor) CGColor];
            dotLayer.cornerRadius = dotModel.sliderDotWidth/2;
            dotLayer.borderWidth = dotModel.borderWidth;
            dotLayer.borderColor = [RGB_HEX(dotBorderColor) CGColor];
            [self.sliderView.layer addSublayer:dotLayer];
            [dotLayerMarr addObject:dotLayer];
        }
   
        _layerMdic[@"dotLayerMarr"] = dotLayerMarr;
    }
    for(int i = 0;i < dotLayerMarr.count;i ++){
        DotModel *dotModel = _sliderViewModel.dotModelArr[i];

        CALayer *dotLayer = dotLayerMarr[i];
        dotLayer.frame = CGRectMake(sliderBorderLayer.frame.origin.x+i * ((sliderBorderLayer.frame.size.width) /(_sliderViewModel.dotModelArr.count - 1) ) - dotModel.sliderDotWidth /2   , CGRectGetHeight(self.sliderView.frame)/2 -  dotModel.sliderDotWidth /2, dotModel.sliderDotWidth, dotModel.sliderDotWidth);
        
        dotLayer.center = CGPointMake(dotLayer.frame.origin.x + dotModel.sliderDotWidth /2 , dotLayer.frame.origin.y +dotModel.sliderDotWidth /2 );
        
        CATextLayer *textLayer  = textLayerMarr[i];
        CGPoint point =  [self.sliderView.layer convertPoint:dotLayer.center toLayer:self.layer];
        
        point = CGPointMake(point.x - textLayer.frame.size.width/2, 12);
        
        CGRect textLayerFrame =   textLayer.frame;
        textLayerFrame.origin = point;
        textLayer.frame = textLayerFrame;
        
    }
    if(!_carBtn){
        _carBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_carBtn setImage:[UIImage imageNamed:_sliderViewModel.sliderConfig.imgStr] forState:UIControlStateNormal];
        _carBtn.tintColor = [UIColor blackColor];
        _carBtn.backgroundColor = [UIColor whiteColor];
        _carBtn.layer.cornerRadius = CAR_BTN_WIDTH / 2;
        _carBtn.layer.shadowColor = [UIColor grayColor].CGColor;
        _carBtn.layer.shadowOffset = CGSizeMake(1, 1);
        _carBtn.layer.shadowOpacity = 0.3;
        [self.sliderView addSubview:_carBtn];
     
        [_carBtn addTarget:self action:@selector(dragMoving:withEvent: ) forControlEvents:UIControlEventTouchDragInside];
        [_carBtn addTarget:self action:@selector(dragEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _carBtn.frame = CGRectMake(0, 0, CAR_BTN_WIDTH, CAR_BTN_HEIGHT);
    _carBtn.center = ((CALayer*)dotLayerMarr[_carBtn.tag]).center;
    
    
}

//button的移动事件
-(void) dragMoving: (UIButton *) btn withEvent:(UIEvent*)ev{
    
    
    if(btn.center.x < 0 || btn.center.x > self.sliderView.frame.size.width){
        
        return;
    }
    UITouch *touch = [[ev allTouches] anyObject];
    CGFloat offset =   [touch locationInView:btn].x - [touch previousLocationInView:btn].x;
    CGRect rectBtn = btn.frame ;
    rectBtn.origin.x += offset;
    btn.frame = rectBtn;
    if(_dragMovingOffsetBlock){
        _dragMovingOffsetBlock(btn,offset);
    }
}
//button点击
- (void) dragEnded: (UIButton *) btn withEvent:(UIEvent*)ev{
    int position = [self findCarButtonNearestPosition];
    _carBtn.tag = position;
    [self carButtonMoveToPosition:position];
    
    if(_dragPositionBlock){
        _dragPositionBlock(btn,position);
    }

}
-(int) findCarButtonNearestPosition{
    int position = (int)roundf(_carBtn.center.x /self.carButtonStepWidth);
    if(position < 0){
        position = 0;
    }
    if(position > _sliderViewModel.dotModelArr.count - 1){
        position = (int)_sliderViewModel.dotModelArr.count - 1;
    }
    return position;
}
-(void) carButtonMoveToPosition:(int)position {
    
    CALayer *dotLayer = _layerMdic[@"dotLayerMarr"][position];
    _carBtn.center = dotLayer.center;
}
-(void) dragMovingOffset:(DragMovingOffsetBlock)dragMovingOffsetBlock {
    _dragMovingOffsetBlock = dragMovingOffsetBlock;
}
-(void) dragPosition:(DragPositionBlock)dragPositionBlock
{
    _dragPositionBlock = dragPositionBlock;
}



//创建文本图层
- (CATextLayer *)setupTextLayerWithTagModel:(DotModel *)model
{
    if(!model){
        return nil;
    }
    if(!model.title ||  model.title.length == 0){
        return nil;
    }
    
    CATextLayer *textLayer = [CATextLayer layer];
    
    UIFont *font = [UIFont systemFontOfSize:kTextFontSize];
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    
    
    textLayer.string = [NSString stringWithFormat:@"%@", model.title];
    
    return textLayer;
}
+(unsigned)hexValueToUnsigned:(NSString *)hexValue
{
    unsigned value = 0;
    
    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    
    return value;
}

@end
