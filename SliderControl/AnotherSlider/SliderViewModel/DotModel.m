//
//  DotModel.m
//  SliderControl
//
//  Created by fanXing on 2017/6/27.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import "DotModel.h"

@implementation DotModel


- (instancetype)initWithSliderDotWidth:(CGFloat)sliderDotWidth borderWidth:(CGFloat)borderWidth borderColor:(NSString*)borderColor backColor:(NSString*)backColor title:(NSString*)title
{
    self = [super init];
    if (self) {
        _sliderDotWidth = sliderDotWidth;
        _borderWidth    = borderWidth;
        _borderColor    = borderColor;
        _backColor      = backColor;
        _title          = title;
    }
    return self;
}
-(CGFloat) sliderDotWidth {
    if(_sliderDotWidth == 0){
        _sliderDotWidth = 10;
    }
    return _sliderDotWidth;
}


-(NSString*) borderColor {
    if(_borderWidth != 0 && !_borderColor){
        return @"B8B8B8";
    }
    return _borderColor;
}


-(NSString*) backColor{
    if(!_backColor){
        return @"FFFFFF";
    }
    return _backColor;
}


@end
