//
//  WYBaseViewController.h
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry.h>

#import "WYHttpRequest.h"

typedef void(^SuccessBlock)(id JSON);


typedef void(^ErrorBlock)(NSError *error);

@interface WYBaseViewController : UIViewController



@end
