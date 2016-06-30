//
//  WYConfirmOrderViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/28.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYConfirmOrderViewController.h"
#import "WYDeliveryAddressViewController.h"

#import "WYConfirmOrderTableView.h"
#import "WYBottomPaymentView.h"
#import "WYTopConfirmView.h"

#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "WYContactsSiteModel.h"

@interface WYConfirmOrderViewController ()

/** 展示商品信息的 TableView */
@property (strong, nonatomic) WYConfirmOrderTableView *goodsTableView;

/** 顶部用户收货信息视图 */
@property (strong, nonatomic) WYTopConfirmView *topConfirmView;

/** 底部视图 */
@property (strong, nonatomic) WYBottomPaymentView *bottomView;

@end

@implementation WYConfirmOrderViewController

/** 懒加载 */
- (WYConfirmOrderTableView *)goodsTableView {
    if (!_goodsTableView) {
        _goodsTableView = [[WYConfirmOrderTableView alloc] initWithFrame:(CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT - 64 - 45)) style:(UITableViewStylePlain)];
        _goodsTableView.goodsArray = self.dataArray;
        [_goodsTableView setTableHeaderView:self.topConfirmView];
    }
    return _goodsTableView;
}

- (WYTopConfirmView *)topConfirmView {
    if (!_topConfirmView) {
        _topConfirmView = [[WYTopConfirmView alloc] initWithFrame:(CGRectMake(0, 0, VIEW_WIDTH, 96))];
    }
    return _topConfirmView;
}

- (WYBottomPaymentView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[WYBottomPaymentView alloc] init];
    }
    return _bottomView;
}

#pragma mark -
#pragma mark   ==============产生随机订单号==============
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 添加控件和约束 */
    [self controlAddMasonry];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSMutableArray *siteMuArray = [NSKeyedUnarchiver unarchiveObjectWithData:SITE_PATH];
    
    if (siteMuArray.count > 0) {
        
        for (WYContactsSiteModel *model in siteMuArray) {
            if (model.selected) {
                self.topConfirmView.model = model;
            }
        }
    }
}

/** 添加控件和约束 */
- (void)controlAddMasonry {
    
    [self.view addSubview:self.goodsTableView];
    [self.view addSubview:self.bottomView];
    self.bottomView.price = self.goodsPrice;
    
    WS(weakSelf);
    [_goodsTableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 45, 0));
    }];
    
    [_bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.goodsTableView.bottom);
        make.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view.bottom);
    }];
    
    /** 支付 */
    weakSelf.bottomView.blockPayment = ^() {
        
        /*
         *商户的唯一的parnter和seller。
         *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
         */
        
        /*============================================================================*/
        /*=======================需要填写商户app申请的===================================*/
        /*============================================================================*/
        NSString *partner = @"2088811244629885";
        NSString *seller = @"2088811244629885";
        NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMMtWTF/ZNrWvKTVBnKQnamD1GgTvGjm7gLxgWe9pGos/rLYZXQnAuNkQRPgnITwtCOclWMYHvTyufYWoCQgl6mYmL4UEccFwk7ehf8c+pJ3Tm0XTS6//ohcR/B8qD+jiQOxpU33A+UoplCRohlZv5Z2S+0xt/I5QLi0Nb8J0xY3AgMBAAECgYBONJmMr9MlrO2hzonq1e+WwPAXU/Emx4GPRF3px59du/HCj9r3E7qgisdYw6Nz0U8dBd0F++BLngbNiHtafoTGCO6bKJY6Wdiv7zbhC1YuOKAvFbPRKj6pDShZ0lGbIubE6fBtZ5u6nSwh6tr28Y7TLkfX04cYlHFq7u779EBIgQJBAOGg/rRROUwrpf9bMV8z7KMOFlE7EXtg/o0tinJYBd+lvtfAkdpgzQ5JOxfywmfcI33U+RXyFoMLSTuBtfDTb6cCQQDdcwJB/FfBb5HTrOMqshUXsEukT+SWs2vS6TKAlvyd2XGwJ/fP9mdyxtinTNJRpGM0uI+gF6EHfj6blbViMHbxAkA4Pbk/mT9/DSJDlKep43eI7WoCtYaWCodpCYEJH4fXR6laflXc6WQzu21PeuOan/T42K1+GuohoB6RBrQjY5DhAkEAwppmyYXvuFVLWTD9EHAeiQqr7mEnCCf0AQxdDROiOzTy61K0O1TV489KZPrleEl1xMbLsGwTXnpamm8dToQ4gQJBANjWYtsLAxbxgNF9zAKj+B38r0AInsxbY6TV77iejVGhL9wbnJtN5QHQ6yXTlvS6Cb5hmPDcbsM0rSrCyXpD38o=";
        /*============================================================================*/
        /*============================================================================*/
        /*============================================================================*/
        
        //partner和seller获取失败,提示
        if ([partner length] == 0 ||
            [seller length] == 0 ||
            [privateKey length] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"缺少partner或者seller或者私钥。"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        /*
         *生成订单信息及签名
         */
        //将商品信息赋予AlixPayOrder的成员变量
        Order *order = [[Order alloc] init];
        order.partner = partner;
        order.sellerID = seller;
        order.outTradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
        order.subject = @"不知道是什么"; //商品标题
        order.body = @"没钱就试试支付宝好用吗"; //商品描述
        order.totalFee = [NSString stringWithFormat:@"0.01"]; //商品价格
        order.notifyURL =  @"http://www.xxx.com"; //回调URL
        
        order.service = @"mobile.securitypay.pay";
        order.paymentType = @"1";
        order.inputCharset = @"utf-8";
        order.itBPay = @"30m";
        order.showURL = @"m.alipay.com";
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        //将商品信息拼接成字符串
        NSString *orderSpec = [order description];
        NSLog(@"orderSpec = %@",orderSpec);
        
        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
        id<DataSigner> signer = CreateRSADataSigner(privateKey);
        NSString *signedString = [signer signString:orderSpec];
        
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
            }];
        }
    };
    
    UIButton *chooseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [chooseBtn setBackgroundColor:RGB(248, 248, 248)];
    [chooseBtn setTitle:[NSString stringWithFormat:@"选择地址"] forState:(UIControlStateNormal)];
    [chooseBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [chooseBtn sizeToFit];
    [chooseBtn setTitleColor:RGB(55, 183, 236) forState:(UIControlStateNormal)];
    [chooseBtn addTarget:self action:@selector(btnTouchActionChoose) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:chooseBtn];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
}
- (void)btnTouchActionChoose {
    WYDeliveryAddressViewController *deliveryVC = [[WYDeliveryAddressViewController alloc] init];
    [self.navigationController pushViewController:deliveryVC animated:YES];
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
