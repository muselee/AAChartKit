//
//  AABaseViewController.m
//  AAChartKitDemo
//
//  Created by AnAn on 2020/7/5.
//  Copyright © 2020 Danny boy. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * 🌕 🌖 🌗 🌘  ❀❀❀   WARM TIPS!!!   ❀❀❀ 🌑 🌒 🌓 🌔
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/7842508/codeforu
 * JianShu       : https://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import "AABaseViewController.h"
#import "AAEasyTool.h"

@interface AABaseViewController ()

@end

@implementation AABaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTitle];
    [self setupNextTypeChartButton];

    [self setupChartView];
}

- (void)setupTitle {
    NSString *chartType = self.navigationItemTitleArr[self.selectedIndex];
    self.title = [NSString stringWithFormat:@"%@ chart",chartType];
}


- (void)setupChartView {
    self.aaChartView = [[AAChartView alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.aaChartView.scrollEnabled = NO;
    [self.view addSubview:self.aaChartView];
    
    AAAnimation *aaAnimation = AAAnimation.new
    .durationSet(@1000)
    .easingSet(AAChartAnimationEaseOutQuart);
    [self.aaChartView aa_adaptiveScreenRotationWithAnimation:aaAnimation];
    
    // ⚠️
    self.aaChartView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *constraintsArr = [AAEasyTool configureTheConstraintArrayWithSonView:self.aaChartView
                                                                    toFatherView:self.view];
    [self.view addConstraints:constraintsArr];
    
    [self drawChartWithChartConfiguration];
}

- (void)setupNextTypeChartButton {
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"Next Chart"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(monitorTap)];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (void)monitorTap {
    if (self.selectedIndex == self.navigationItemTitleArr.count - 1) {
        self.title = [NSString stringWithFormat:@"❗️This is the last chart❗️"];
    } else {
        self.selectedIndex = self.selectedIndex + 1;
        self.title = self.navigationItemTitleArr[self.selectedIndex];
        [self refreshChartWithChartConfiguration];
    }
}

- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
   return nil;
}

- (void)drawChartWithChartConfiguration {
    id chartOption = [self chartConfigurationWithSelectedIndex:self.selectedIndex];
    if ([chartOption isKindOfClass:AAChartModel.class]) {
        [self.aaChartView aa_drawChartWithChartModel:chartOption];
    } else if ([chartOption isKindOfClass:AAOptions.class]) {
        [self.aaChartView aa_drawChartWithOptions:chartOption];
    }
}

- (void)refreshChartWithChartConfiguration {
    id chartOption = [self chartConfigurationWithSelectedIndex:self.selectedIndex];
    if ([chartOption isKindOfClass:AAChartModel.class]) {
        [self.aaChartView aa_refreshChartWithChartModel:chartOption];
    } else if ([chartOption isKindOfClass:AAOptions.class]) {
        [self.aaChartView aa_refreshChartWithOptions:chartOption];
    }
}

@end