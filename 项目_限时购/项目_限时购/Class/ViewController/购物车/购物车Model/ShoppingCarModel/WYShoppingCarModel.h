//
//	WYShoppingCarModel.h
//
//	Create by c ma on 27/6/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface WYShoppingCarModel : NSObject

@property (nonatomic, strong) NSString * abbreviation;
@property (nonatomic, strong) NSString * country;
@property (nonatomic, strong) NSString * discount;
@property (nonatomic, strong) NSString * domesticPrice;
@property (nonatomic, strong) NSString * goodsCount;
@property (nonatomic, strong) NSString * goodsId;
@property (nonatomic, strong) NSString * goodsTitle;
@property (nonatomic, strong) NSString * imgView;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * uUID;
@property (nonatomic, strong) NSString * weight;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end