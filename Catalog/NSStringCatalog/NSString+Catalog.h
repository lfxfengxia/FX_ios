//
//  NSString-Catalog.h
//  catalog
//
//  Created by emoneybag on 15/7/20.
//  Copyright (c) 2015年 emoneybag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Catalog)


// ------------------------------------convert date------------------------------------

// 时间转换 @"yyyy-MM-dd hh:mm:ss"
+(NSString *)converDate:(NSString *)value withFormat:(NSString *)format;

// 时间转换 @"yyyy-MM-dd"  @"yyyy/MM/dd"
+ (NSString *)format_DateStringWith:(float)time withFormat:(NSString *)formatStr;


// ------------------------------------phone number------------------------------------

// 把手机号第4-7位变成星号
+(NSString *)phoneNumToAsterisk:(NSString*)phoneNum;

// 手机号码验证
+(BOOL)validateMobile:(NSString *)mobile;


// ---------------------------------------email-----------------------------------------

// 邮箱验证
+(BOOL)validateEmail:(NSString *)email;


// --------------------------------------ID card----------------------------------------

// 把身份证号第5-14位变成星号
+(NSString *)idCardToAsterisk:(NSString *)idCardNum;

// 判断是否是身份证号码
+(BOOL)validateIdCard:(NSString *)idCard;


// --------------------------------money string seperator-------------------------------

+ (NSString *)formatMoneyWithmoneyString:(NSString *)moneyStr;


// ------------------------------caculate string text hight-----------------------------

+ (CGFloat)heightForText:(NSString *)text;

@end
