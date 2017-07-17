//
//  SliderViewModel.h
//  SliderControl
//
//  Created by fanXing on 2017/6/27.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DotModel.h"
#import "SliderConfig.h"

@interface SliderViewModel : NSObject


@property (nonatomic,strong,readwrite) NSArray <DotModel*> *dotModelArr;
@property (nonatomic,strong,readwrite) SliderConfig *sliderConfig;

-(instancetype)initWithSliderConfig:(SliderConfig *)sliderConfig;
@end
