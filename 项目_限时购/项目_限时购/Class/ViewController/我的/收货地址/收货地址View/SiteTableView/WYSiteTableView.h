//
//  WYSiteTableView.h
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaesTableView.h"

typedef void(^ReturnDataBlock)(NSMutableArray *muarray);

@interface WYSiteTableView : WYBaesTableView

/** 接收数据 */
@property (strong, nonatomic) NSMutableArray *dataMuArray;

/**  */


@end
