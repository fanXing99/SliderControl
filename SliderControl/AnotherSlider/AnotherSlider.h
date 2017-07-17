//
//  AnotherSlider.h
//  SliderControl
//
//  Created by fanXing on 2017/6/26.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderViewModel.h"


typedef void(^DragMovingOffsetBlock)(UIButton *btn,CGFloat offset);
typedef void (^DragPositionBlock)(UIButton *btn,int position);



@interface AnotherSlider : UIView {
    
}
/**
 * 监听btn的移动
 */
-(void) dragMovingOffset:(DragMovingOffsetBlock) dragMovingOffsetBlock;

/**
 *btn的移动最后停止的位置
 */
-(void) dragPosition:(DragPositionBlock) dragPositionBlock;


-(void) sliderViewModel:(SliderViewModel*)sliderViewModel;



@end
