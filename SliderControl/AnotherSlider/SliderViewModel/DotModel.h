//
//  DotModel.h
//  SliderControl
//
//  Created by fanXing on 2017/6/27.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DotModel : NSObject

@property (nonatomic,readwrite,assign) CGFloat  sliderDotWidth;
@property (nonatomic,readwrite,assign) CGFloat borderWidth;
@property (nonatomic,readwrite,copy) NSString *borderColor;
@property (nonatomic,readwrite,copy) NSString *backColor;
@property (nonatomic,readwrite,copy) NSString *title;

-(instancetype) initWithSliderDotWidth:(CGFloat) sliderDotWidth borderWidth:(CGFloat)borderWidth \
borderColor:(NSString*)borderColor backColor:(NSString*)backColor title:(NSString*)title;


@end
