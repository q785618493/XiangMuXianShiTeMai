//
//  WYMeCollectViewController.m
//  项目_限时购
//
//  Created by ma c on 16/7/1.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYMeCollectViewController.h"

@interface WYMeCollectViewController ()

@end

@implementation WYMeCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"我的收藏"];
    
    [self controlAddMasonry];
    
    ZDY_LOG(@"   --------- %@",_userID);
    [self httpGetRequestCollectShopsMemberId:_userID OrderName:[NSString stringWithFormat:@"host"] OrderType:[NSString stringWithFormat:@"DESC"]];
}

/** 添加控件和约束 */
- (void)controlAddMasonry {
    WS(weakSelf);
}

/**
 *  用户收藏商品列表的网络请求
 *
 *  @param MemberId  用户的 ID
 *  @param OrderName 排序字段
 *  @param OrderType 排序类型
 */
- (void)httpGetRequestCollectShopsMemberId:(NSString *)MemberId OrderName:(NSString *)OrderName OrderType:(NSString *)OrderType {
    
    WS(weakSelf);
    
    NSDictionary *requestDic = @{@"MemberId":MemberId,
                                 @"OrderName":OrderName,
                                 @"OrderType":OrderType};
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appCollection/myCollectionList.do"] progressDic:requestDic success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        NSString *nameJson = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSON options:0 error:nil] encoding:NSUTF8StringEncoding];
        
        ZDY_LOG(@"  ====%@",nameJson);
        
        if (array.count > 0) {
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            
            
        }
        else {
            ZDY_LOG(@" ===== 收藏列表请求数据失败 ===== ");
        }
        
        
    } failure:^(NSError *error) {
        ZDY_LOG(@" error == %@ ",error.localizedDescription);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
