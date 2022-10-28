//
//  Encryptor.h
//  Encryptor
//
//  Created by hwzx on 2019/9/2.
//  Copyright © 2019 hwzx. All rights reserved.
//



////! Project version number for Encryptor.
//FOUNDATION_EXPORT double EncryptorVersionNumber;
//
////! Project version string for Encryptor.
//FOUNDATION_EXPORT const unsigned char EncryptorVersionString[];
//
//// In this header, you should import all the public headers of your framework using statements like #import <Encryptor/PublicHeader.h>
#import <Foundation/Foundation.h>


/**
 当前FrameWork版本号： 0.0.1
 最低支持iOS版本： iOS 9.0
 **/

@interface Encryptor : NSObject


/**
 给特定的字符串加密，得到加密后的字符串

 @param originString 要加密的字符串，json字符串再传
 @param tmString 当前的时间戳，13位，如果为空，则取默认的时间
 @param pbkStr 加密用的RSA的公钥字符串
 @param shouldLogDetailInfo 是否打印详细信息，详细信息包含处理的每一步的结果
 @return 返回值为加密后的字符串，如果originString、tmString和pbkStr有一个为空，则加密结果为空字符串
 */

+ (NSString *)encryptOriginString:(NSString *)originString withTimeStampString:(NSString *)tmString andPublicKeyString:(NSString *)pbkStr shouldLogDetailInfo:(BOOL)shouldLogDetailInfo;


@end

