//
//  CZValidate.h
//  EnjoyiOS
//
//  Created by Ug's iMac on 2016/12/14.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZValidate : NSObject

#pragma mark - 身份证
/** 验证身份证号码 */
+ (BOOL)isValidateIDCardNumber:(NSString *)idNumber;
/** 根据身份证号获取生日，格式为yyyy-MM-dd。若身份证格式不对，返回空串 */
+ (NSString *)birthdayStrFromIDCard:(NSString *)idNumber;
/** 根据身份证号获取年龄，若身份证号格式不对，返回0 */
+ (NSInteger)getIDCardAge:(NSString *)idNumber;
/**根据身份证号获取性别男女*/
+ (NSString *)getIdentityCardSex:(NSString *)idNumber;
/**根据身份证号获取年纪*/
+ (NSString *)getIdentityCardAge:(NSString *)idNumber;

/** 验证邮箱格式 */
+ (BOOL)isValidateEmail:(NSString *)email;
/** 验证手机号码格式 */
+ (BOOL)isValidateMobile:(NSString *)mobile;
/** 同时验证手机号码格式和座机号码格式 */
+ (BOOL)isValidatePhone:(NSString *)phone;
/** 验证密码长度是否有效，6～20位为有效 */
+ (BOOL)isValidatePwd:(NSString *)pwd;
/** 过滤字符串中的除数字外的其它字符 */
+ (BOOL)validateNumber:(NSString *)number;
/** 验证中国邮政编码 */
+ (BOOL)isValidateZipCode:(NSString *)zipCode;
/** 验证银行卡号码 */
+ (BOOL)isCheckBankCardNo:(NSString *)cardNo;
/** 车牌号 */
+ (BOOL)isValidateCarNumber:(NSString *)carNumber;

#pragma mark - 中文检验和提取
/** 验证姓名是否为中文 */
+ (BOOL)isValidateChineseName:(NSString *)name;
/** 获取一段字符串中的中文字 */
+ (NSArray *)getAStringOfChineseWord:(NSString *)string;
/** 获取一段字符串中的中文字和中文字符 */
+ (NSArray *)getAStringOfChineseCharacters:(NSString *)string;
/** 获取一段字符串中的中文字、数字、英文 */
+ (NSArray *)getAStringOfChineseWordNumberEnglish:(NSString *)string;
/**判断姓名中是否包含数字，包含数字表示名字格式不正确*/
+ (BOOL)isStringContainNumberWith:(NSString *)str;


#pragma mark -- 时间戳转换为时间
//时间戳转时间
+ (NSString *)getTimeFromTimestamp:(double)time;
//时间转时间戳
+ (long long)getTimeStampFromDate:(NSString *)dateStr;


#pragma mark -- 判断时间的大小
+ (NSInteger)compareWithDate:(NSString *)bDate;

#pragma mark -- 字典转json字符串
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (UIColor*)mostColor:(UIImage *)CGImage;

@end
