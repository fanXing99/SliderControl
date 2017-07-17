//
//  SliderConfig.m
//  SliderControl
//
//  Created by fanXing on 2017/6/27.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import "SliderConfig.h"

@implementation SliderConfig

-(instancetype) initWithOuterLayerColor:(UIColor *)outerLayerColor sliderColor:(UIColor*)sliderColor imgStr:(NSString *)imgStr{
    
    self = [super init];
    if (self) {
        _outerLayerColor = outerLayerColor;
        _sliderColor =  sliderColor;
        _imgStr = imgStr;
    }
    return self;

}
-(UIColor*) outerLayerColor {
    
    if(!_outerLayerColor){
        return [UIColor lightGrayColor];
    }
    return _outerLayerColor;
}
-(UIColor*) sliderColor {
    if(!_sliderColor){
        return [UIColor lightGrayColor];
    }
    return _sliderColor;
}
@end
