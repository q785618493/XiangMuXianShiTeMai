//
//  WYContactsSiteModel.m
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYContactsSiteModel.h"

static NSString *nameKey = @"userName";
static NSString *phoneKey = @"phoneNumber";
static NSString *siteKey = @"siteInfo";
static NSString *seleKey = @"selected";

@implementation WYContactsSiteModel

- (instancetype)initWithContactsSiteModelDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)contactsSiteModelDict:(NSDictionary *)dict {
    return [[self alloc] initWithContactsSiteModelDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.userName forKey:nameKey];
    [aCoder encodeObject:self.phoneNumber forKey:phoneKey];
    [aCoder encodeObject:self.siteInfo forKey:siteKey];
    [aCoder encodeBool:self.selected forKey:seleKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self.userName = [aDecoder decodeObjectForKey:nameKey];
    self.phoneNumber = [aDecoder decodeObjectForKey:phoneKey];
    self.siteInfo = [aDecoder decodeObjectForKey:siteKey];
    self.selected = [aDecoder decodeBoolForKey:seleKey];
    return self;
}

@end
