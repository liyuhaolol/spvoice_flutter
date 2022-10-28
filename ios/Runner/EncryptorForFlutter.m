//
//  EncryptorForFlutter.m
//  Runner
//
//  Created by hwzx on 2022/10/27.
//

#import "EncryptorForFlutter.h"
#import <Encryptor/Encryptor.h>
NSString *channelName = @"ntpToken";
NSString *methodName = @"getNtpToken";

@implementation EncryptorForFlutter


+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar{
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:[registrar messenger]];
    EncryptorForFlutter *enc = [[EncryptorForFlutter alloc]init];
    [registrar addMethodCallDelegate:enc channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result{
    if([call.method isEqualToString:methodName]){
        NSDictionary *dict = call.arguments;
        NSString *jsonStr = [dict valueForKey:@"json"]?:@"";
        NSString *rsaKey = [dict valueForKey:@"rsa"]?:@"";
        
        NSString *resultStr = [Encryptor encryptOriginString:jsonStr withTimeStampString:nil andPublicKeyString:rsaKey shouldLogDetailInfo:NO];
        result(resultStr);
        
    }else{
        result(FlutterMethodNotImplemented);
    }
}
@end
