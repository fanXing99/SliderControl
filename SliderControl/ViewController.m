//
//  ViewController.m
//  SliderControl
//
//  Created by fanXing on 2017/6/29.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import "ViewController.h"
#import "AnotherSlider.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet AnotherSlider *anotherSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    //小圆点样式在DotStyle.plist文件中
    //初始化ViewModel处理数据
    //SliderControl的背景颜色
    SliderConfig *sliderConfig = [[SliderConfig alloc] initWithOuterLayerColor:[UIColor greenColor] sliderColor:[UIColor yellowColor] imgStr:@"car"];
    SliderViewModel *sliderViewModel = [[SliderViewModel alloc] initWithSliderConfig:sliderConfig];
    
    //直接使用xib加载
    [self.anotherSlider sliderViewModel:sliderViewModel];
    
    //偏移的offset
    [self.anotherSlider dragMovingOffset:^(UIButton *btn, CGFloat offset) {
        
        NSLog(@"%f",offset);
        
    }];
    //当前选择档位
    [self.anotherSlider dragPosition:^(UIButton *btn, int position) {
        NSLog(@"%d",position);
        
    }];
    //代码初始化xib不用管
    AnotherSlider *anotherSlider = [[AnotherSlider alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    anotherSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [anotherSlider sliderViewModel:sliderViewModel];
    [self.view addSubview:anotherSlider];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
