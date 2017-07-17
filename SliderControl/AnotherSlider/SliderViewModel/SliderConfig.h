//
//  SliderConfig.h
//  SliderControl
//
//  Created by fanXing on 2017/6/27.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SliderConfig : NSObject
{
    
}

@property (nonatomic,readwrite,strong) UIColor *outerLayerColor;
@property (nonatomic,readwrite,strong) UIColor *sliderColor;
@property (nonatomic,readwrite,copy) NSString *imgStr;




-(instancetype) initWithOuterLayerColor:(UIColor *)outerLayerColor sliderColor:(UIColor*)sliderColor imgStr:(NSString *)imgStr;





@end
