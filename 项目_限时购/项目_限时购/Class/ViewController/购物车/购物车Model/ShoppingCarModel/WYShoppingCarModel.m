//
//	WYShoppingCarModel.m
//
//	Create by c ma on 27/6/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WYShoppingCarModel.h"

@interface WYShoppingCarModel ()
@end
@implementation WYShoppingCarModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"Abbreviation"] isKindOfClass:[NSNull class]]){
		self.abbreviation = dictionary[@"Abbreviation"];
	}	
	if(![dictionary[@"Country"] isKindOfClass:[NSNull class]]){
		self.country = dictionary[@"Country"];
	}	
	if(![dictionary[@"Discount"] isKindOfClass:[NSNull class]]){
		self.discount = dictionary[@"Discount"];
	}	
	if(![dictionary[@"DomesticPrice"] isKindOfClass:[NSNull class]]){
		self.domesticPrice = dictionary[@"DomesticPrice"];
	}	
	if(![dictionary[@"GoodsCount"] isKindOfClass:[NSNull class]]){
		self.goodsCount = dictionary[@"GoodsCount"];
	}	
	if(![dictionary[@"GoodsId"] isKindOfClass:[NSNull class]]){
		self.goodsId = dictionary[@"GoodsId"];
	}	
	if(![dictionary[@"GoodsTitle"] isKindOfClass:[NSNull class]]){
		self.goodsTitle = dictionary[@"GoodsTitle"];
	}	
	if(![dictionary[@"ImgView"] isKindOfClass:[NSNull class]]){
		self.imgView = dictionary[@"ImgView"];
	}	
	if(![dictionary[@"Price"] isKindOfClass:[NSNull class]]){
		self.price = dictionary[@"Price"];
	}	
	if(![dictionary[@"UUID"] isKindOfClass:[NSNull class]]){
		self.uUID = dictionary[@"UUID"];
	}	
	if(![dictionary[@"Weight"] isKindOfClass:[NSNull class]]){
		self.weight = dictionary[@"Weight"];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.abbreviation != nil){
		dictionary[@"Abbreviation"] = self.abbreviation;
	}
	if(self.country != nil){
		dictionary[@"Country"] = self.country;
	}
	if(self.discount != nil){
		dictionary[@"Discount"] = self.discount;
	}
	if(self.domesticPrice != nil){
		dictionary[@"DomesticPrice"] = self.domesticPrice;
	}
	if(self.goodsCount != nil){
		dictionary[@"GoodsCount"] = self.goodsCount;
	}
	if(self.goodsId != nil){
		dictionary[@"GoodsId"] = self.goodsId;
	}
	if(self.goodsTitle != nil){
		dictionary[@"GoodsTitle"] = self.goodsTitle;
	}
	if(self.imgView != nil){
		dictionary[@"ImgView"] = self.imgView;
	}
	if(self.price != nil){
		dictionary[@"Price"] = self.price;
	}
	if(self.uUID != nil){
		dictionary[@"UUID"] = self.uUID;
	}
	if(self.weight != nil){
		dictionary[@"Weight"] = self.weight;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.abbreviation != nil){
		[aCoder encodeObject:self.abbreviation forKey:@"Abbreviation"];
	}
	if(self.country != nil){
		[aCoder encodeObject:self.country forKey:@"Country"];
	}
	if(self.discount != nil){
		[aCoder encodeObject:self.discount forKey:@"Discount"];
	}
	if(self.domesticPrice != nil){
		[aCoder encodeObject:self.domesticPrice forKey:@"DomesticPrice"];
	}
	if(self.goodsCount != nil){
		[aCoder encodeObject:self.goodsCount forKey:@"GoodsCount"];
	}
	if(self.goodsId != nil){
		[aCoder encodeObject:self.goodsId forKey:@"GoodsId"];
	}
	if(self.goodsTitle != nil){
		[aCoder encodeObject:self.goodsTitle forKey:@"GoodsTitle"];
	}
	if(self.imgView != nil){
		[aCoder encodeObject:self.imgView forKey:@"ImgView"];
	}
	if(self.price != nil){
		[aCoder encodeObject:self.price forKey:@"Price"];
	}
	if(self.uUID != nil){
		[aCoder encodeObject:self.uUID forKey:@"UUID"];
	}
	if(self.weight != nil){
		[aCoder encodeObject:self.weight forKey:@"Weight"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.abbreviation = [aDecoder decodeObjectForKey:@"Abbreviation"];
	self.country = [aDecoder decodeObjectForKey:@"Country"];
	self.discount = [aDecoder decodeObjectForKey:@"Discount"];
	self.domesticPrice = [aDecoder decodeObjectForKey:@"DomesticPrice"];
	self.goodsCount = [aDecoder decodeObjectForKey:@"GoodsCount"];
	self.goodsId = [aDecoder decodeObjectForKey:@"GoodsId"];
	self.goodsTitle = [aDecoder decodeObjectForKey:@"GoodsTitle"];
	self.imgView = [aDecoder decodeObjectForKey:@"ImgView"];
	self.price = [aDecoder decodeObjectForKey:@"Price"];
	self.uUID = [aDecoder decodeObjectForKey:@"UUID"];
	self.weight = [aDecoder decodeObjectForKey:@"Weight"];
	return self;

}
@end