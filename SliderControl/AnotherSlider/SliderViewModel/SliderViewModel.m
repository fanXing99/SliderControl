//
//  SliderViewModel.m
//  SliderControl
//
//  Created by fanXing on 2017/6/27.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import "SliderViewModel.h"
#import "SliderConfig.h"


@implementation SliderViewModel



-(instancetype)initWithSliderConfig:(SliderConfig *)sliderConfig {
    self = [self init];
    if (self) {
        
        
        _sliderConfig = sliderConfig;
    }
    return self;
    
}
- (instancetype)init
{
    self = [super init];
    //样式
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DotStyle" ofType:@"plist"];
        NSArray  *styleArr = [[NSArray array] initWithContentsOfFile:plistPath];
        
        if(styleArr.count <= 1){
            NSLog(@"DotStyle.plist itme数应该大于1");
            return ;
        }

        NSMutableArray *tempDotArr = @[].mutableCopy;
        for(NSDictionary *dict in styleArr){
           DotModel *dotModel = [[DotModel alloc] initWithSliderDotWidth:[dict[@"sliderDotWidth"] floatValue] borderWidth:[dict[@"borderWidth"] floatValue] borderColor:dict[@"borderColor"] backColor:dict[@"backColor"] title:dict[@"title"]];
            [tempDotArr addObject:dotModel];
        }
        _dotModelArr = tempDotArr;
     });
    return self;
}


@end
