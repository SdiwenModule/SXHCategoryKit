//
//  CZValidate.m
//  EnjoyiOS
//
//  Created by Ug's iMac on 2016/12/14.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import "CZValidate.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

@implementation CZValidate

+ (BOOL)isValidateIDCardNumber:(NSString *)idNumber {
    idNumber = [idNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    idNumber = [idNumber uppercaseString];
    NSUInteger length = 0;
    if (! idNumber) {
        return NO;
    }else {
        length = idNumber.length;
        
        if (length != 15 && length != 18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34",
                           @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54",
                           @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString *valueStart2 = [idNumber substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    
    if (! areaFlag) {
        return false;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [idNumber substringWithRange:NSMakeRange(6, 2)].intValue + 1900;
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idNumber
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idNumber.length)];
            
            
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
            
        case 18:
            year = [idNumber substringWithRange:NSMakeRange(6, 4)].intValue;
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idNumber
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idNumber.length)];
            
            if(numberofMatch > 0) {
                int S = ([idNumber substringWithRange:NSMakeRange(0, 1)].intValue+ [idNumber substringWithRange:NSMakeRange(10, 1)].intValue) * 7
                + ([idNumber substringWithRange:NSMakeRange(1, 1)].intValue+ [idNumber substringWithRange:NSMakeRange(11, 1)].intValue) * 9
                + ([idNumber substringWithRange:NSMakeRange(2, 1)].intValue+ [idNumber substringWithRange:NSMakeRange(12, 1)].intValue) * 10
                + ([idNumber substringWithRange:NSMakeRange(3, 1)].intValue+ [idNumber substringWithRange:NSMakeRange(13, 1)].intValue) * 5
                + ([idNumber substringWithRange:NSMakeRange(4, 1)].intValue+ [idNumber substringWithRange:NSMakeRange(14, 1)].intValue) * 8
                + ([idNumber substringWithRange:NSMakeRange(5, 1)].intValue+ [idNumber substringWithRange:NSMakeRange(15, 1)].intValue) * 4
                + ([idNumber substringWithRange:NSMakeRange(6, 1)].intValue+ [idNumber substringWithRange:NSMakeRange(16, 1)].intValue) * 2
                + [idNumber substringWithRange:NSMakeRange(7, 1)].intValue * 1
                + [idNumber substringWithRange:NSMakeRange(8, 1)].intValue * 6
                + [idNumber substringWithRange:NSMakeRange(9, 1)].intValue * 3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y, 1)]; // 判断校验位
                if ([M isEqualToString:[idNumber substringWithRange:NSMakeRange(17, 1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

+ (NSString *)birthdayStrFromIDCard:(NSString *)idNumber {
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    if ([CZValidate isValidateIDCardNumber:idNumber]) {
        BOOL isAllNumber = YES;
        NSString *day = nil;
        if([idNumber length]<14)
            return result;
        
        //**截取前14位
        NSString *fontNumer = [idNumber substringWithRange:NSMakeRange(0, 13)];
        
        //**检测前14位否全都是数字;
        const char *str = [fontNumer UTF8String];
        const char *p = str;
        while (*p!='\0') {
            if(!(*p>='0'&&*p<='9'))
                isAllNumber = NO;
            p++;
        }
        if(!isAllNumber)
            return result;
        
        year = [idNumber substringWithRange:NSMakeRange(6, 4)];
        month = [idNumber substringWithRange:NSMakeRange(10, 2)];
        day = [idNumber substringWithRange:NSMakeRange(12,2)];
        
        [result appendString:year];
        [result appendString:@"-"];
        [result appendString:month];
        [result appendString:@"-"];
        [result appendString:day];
        return result;
    } else {
        return result;
    }
}

+ (NSString *)getIdentityCardSex:(NSString *)idNumber{
    NSString *sex = @"";
    if (idNumber.length == 18) {
        int sexInt=[[idNumber substringWithRange:NSMakeRange(16,1)] intValue];
        if(sexInt%2!=0)
        {
            sex = @"男";
        }else{
            sex = @"女";
        }
    }
    if (idNumber.length == 15) {
        int sexInt=[[idNumber substringWithRange:NSMakeRange(14,1)] intValue];
        if (sexInt%2!=0) {
            sex = @"男";
        }else{
            sex = @"女";
        }
    }
    return sex;
}

+ (NSString *)getIdentityCardAge:(NSString *)idNumber{
    NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
    [formatterTow setDateFormat:@"yyyy-MM-dd"];
    NSDate *bsyDate = [formatterTow dateFromString:[self birthdayStrFromIdentityCard:idNumber]];
    NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
    int age = trunc(dateDiff/(60*60*24))/365;
    return [NSString stringWithFormat:@"%d",-age];
}
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr
{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<18)
        return result;
    //**从第6位开始 截取8个数
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(6, 8)];
    //**检测前12位否全都是数字;
    const char *str = [fontNumer UTF8String];
    
    const char *p = str;
    
    while (*p!='\0') {
        
        if(!(*p>='0'&&*p<='9'))
            
            isAllNumber = NO;
        
        p++;
        
    }
    if(!isAllNumber)
        return result;
    year = [NSString stringWithFormat:@"19%@",[numberStr substringWithRange:NSMakeRange(8, 2)]];
    
    //    NSLog(@"year ==%@",year);
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    
    //    NSLog(@"month ==%@",month);
    
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    
    //    NSLog(@"day==%@",day);
    
    [result appendString:year];
    
    [result appendString:@"-"];
    
    [result appendString:month];
    
    [result appendString:@"-"];
    
    [result appendString:day];
    
    //    NSLog(@"result===%@",result);
    
    return result;
}



+ (NSInteger)getIDCardAge:(NSString *)idNumber {
    if ([CZValidate isValidateIDCardNumber:idNumber]) {
        NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
        [formatterTow setDateFormat:@"yyyy-MM-dd"];
        NSDate *bsyDate = [formatterTow dateFromString:[CZValidate birthdayStrFromIDCard:idNumber]];
        
        NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
        
        int age = trunc(dateDiff/(60*60*24))/365;
        
        return -age;
    } else {
        return 0;
    }
}

+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidateMobile:(NSString *)mobile {
    // 手机号以13，14，15，17，18开头，八个 \d 数字字符/^((13|14|15|17|18)[0-9]{1}\d{8})$/
    NSString *mobileRegex = @"^1[3|4|5|6|7|8|9][0-9]\\d{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    return [mobileTest evaluateWithObject:mobile];
}

+ (BOOL)isValidatePhone:(NSString *)phone {
    NSString *phoneRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

+ (BOOL)isValidatePwd:(NSString *)pwd {
    BOOL isMatch = NO;
    if (pwd.length > 5) {
        NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,10}";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pattern];
        isMatch = [pred evaluateWithObject:pwd];
    }
    return isMatch;
}

+ (BOOL)validateNumber:(NSString *)number {
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString *string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i ++;
    }
    return res;
}

+ (BOOL)isValidateZipCode:(NSString *)zipCode {
    NSString *zipCodeRegex = @"[1-9]\\d{5}(?!\\d)";
    NSPredicate *zipCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipCodeRegex];
    return [zipCodeTest evaluateWithObject:zipCode];
}

+ (BOOL)isCheckBankCardNo:(NSString *)cardNo {
    if (cardNo.length == 0) {
        return NO;
    }
    int oddsum = 0;	// 奇数求和
    int evensum = 0;	// 偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength - 1; i >= 1; i --) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i - 1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 == 1) {
            if ((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal >= 10)
                    tmpVal -= 9;
                evensum += tmpVal;
            } else {
                oddsum += tmpVal;
            }
        } else {
            if ((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal >= 10)
                    tmpVal -= 9;
                evensum += tmpVal;
            } else {
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if ((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

+ (BOOL)isValidateCarNumber:(NSString *)carNumber {
    NSString *carRegex = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [predicate evaluateWithObject:carNumber];
}


+ (BOOL)isValidateChineseName:(NSString *)name {
    NSString *cnNameRegex = @"^\\s*[\\u4e00-\\u9fa5]{1,}[\\u4e00-\\u9fa5.·]{0,15}[\\u4e00-\\u9fa5]{1,}\\s*$";
    NSPredicate *cnNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cnNameRegex];
    return [cnNameTest evaluateWithObject:name];
}

+ (NSArray *)getAStringOfChineseWord:(NSString *)string {
    if (string == nil || [string isEqual:@""]) {
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < string.length; i ++) {
        int a = [string characterAtIndex:i];
        if (a < 0x9fff && a > 0x4e00) {
            [arr addObject:[string substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return arr;
}

+ (NSArray *)getAStringOfChineseCharacters:(NSString *)string {
    if (string == nil || [string isEqual:@""]) {
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < string.length; i ++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subStr = [string substringWithRange:range];
        const char *c = [subStr UTF8String];
        if (strlen(c) == 3) {
            [arr addObject:subStr];
        }
    }
    return arr;
}

+ (NSArray *)getAStringOfChineseWordNumberEnglish:(NSString *)string {
    if (string == nil || [string isEqual:@""]) {
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < string.length; i ++) {
        int a = [string characterAtIndex:i];	// ASCII 码
        if (a < 0x9fff && a > 0x4e00) {	// 中文
            [arr addObject:[string substringWithRange:NSMakeRange(i, 1)]];
        }
        else if (48 <= a && a <= 57) {	// 数字
            [arr addObject:[string substringWithRange:NSMakeRange(i, 1)]];
        }
        else if ((65 <= a && a <= 90) || (97 <= a && a <= 122)) {	// 英文
            [arr addObject:[string substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return arr;
}

+ (BOOL)isStringContainNumberWith:(NSString *)str{
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    //count是str中包含[0-9]数字的个数，只要count>0，说明str中包含数字
    if (count > 0) {
        return YES;
    }
    return NO;
}


#pragma mark ---- 将13位时间戳转换成时间
+ (NSString *)getTimeFromTimestamp:(double)time{
    //将对象类型的时间转换为NSDate类型
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time/1000];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}

#pragma mark -- 将时间转换为时间戳
+ (long long)getTimeStampFromDate:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //    NSDate *lastDate = [dateFormatter dateFromString:dateStr];
    NSDate *lastDate = [NSDate date];
    long long timeSp = [lastDate timeIntervalSince1970]*1000;
    return timeSp;
}

#pragma mark --
+ (NSInteger)compareWithDate:(NSString *)bDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *aDate = [formatter stringFromDate:[NSDate date]];
    NSDate *dta = [[NSDate alloc]init];
    NSDate *dtb = [[NSDate alloc]init];
    dta = [formatter dateFromString:aDate];
    dtb = [formatter dateFromString:bDate];
    
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedDescending) {
        return 1;
    }
    else if (result == NSOrderedAscending)
    {
        return -1;
    }else{
        return 0;
    }
}


#pragma mark -- 字典转json字符串方法
+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
#pragma mark -- 把jsonString转换为Dic
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//获取图片主色调
+(UIColor*)mostColor:(UIImage *)CGImage{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    
#else
    
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
    
#endif
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    
    CGSize thumbSize=CGSizeMake(50, 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 
                                                 thumbSize.width,
                                                 
                                                 thumbSize.height,
                                                 
                                                 8,//bits per component
                                                 
                                                 thumbSize.width*4,
                                                 
                                                 colorSpace,
                                                 
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    
    CGContextDrawImage(context, drawRect, CGImage.CGImage);
    
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL) return nil;
    
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        
        for (int y=0; y<thumbSize.height; y++) {
            
            int offset = 4*(x*y);
            
            int red = data[offset];
            
            int green = data[offset+1];
            
            int blue = data[offset+2];
            
            int alpha =  data[offset+3];
            
            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
            
            [cls addObject:clr];
            
        }
        
    }
    
    CGContextRelease(context);
    
    //第三步 找到出现次数最多的那个颜色
    
    NSEnumerator *enumerator = [cls objectEnumerator];
    
    NSArray *curColor = nil;
    
    NSArray *MaxColor=nil;
    
    NSUInteger MaxCount=0;
    
    while ( (curColor = [enumerator nextObject]) != nil )
        
    {
        
        NSUInteger tmpCount = [cls countForObject:curColor];
        
        if ( tmpCount < MaxCount ) continue;
        
        MaxCount=tmpCount;
        
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
    
}
@end
