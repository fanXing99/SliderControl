#一个选择不同档位的控件 如果滑动超过的当前档位的一半制动修正到下一档位。

![](https://github.com/fanXing99/SliderControl/blob/master/ezgif.com-video-to-gif.gif)

小圆点的样式在DotStyle.plist文件中
![](https://github.com/fanXing99/SliderControl/blob/master/C936F4FB-A0B9-4FE7-A236-57FA35C86FFF.png)
``` objective-c

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
```




