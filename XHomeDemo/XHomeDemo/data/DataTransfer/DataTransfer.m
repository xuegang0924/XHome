//
//  DataTransfer.m
//  XHomeDemo
//
//  Created by Gene on 14-6-7.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "DataTransfer.h"

@implementation DataTransfer

@synthesize asyncSocket;
@synthesize bComOrData;
@synthesize bDeviceID;
@synthesize bDeviceType;
@synthesize mdataDataBuf;
@synthesize sDataLength;
@synthesize bDataHeader;
@synthesize bDataTrailer;



/**
 *初始化socket
 */
- (id)init
{

    self = [super init];
    if (self) {
        
        self.bDataHeader = 0x00;
        self.bDataTrailer = 0xFF;
        if (!self.mdataDataBuf) {
            self.mdataDataBuf = [[NSMutableData alloc] init];
        }
        
        //create socket
        if (!self.asyncSocket) {
            self.asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self  delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
        }
//        //connect to host
//        if ([self.asyncSocket isDisconnected]) {
//            NSError *error;
//            if (![self.asyncSocket connectToHost:@"192.168.1.1" onPort:2001 withTimeout:5 error:&error]) {
//                NSLog(@"connect error");
//            }
//        }
    }
    return self;
}


- (BOOL)connectToHostAddrees
{
    if ([self.asyncSocket isDisconnected]) {
        NSError *error;
        if (![self.asyncSocket connectToHost:@"192.168.1.1" onPort:2001 withTimeout:5 error:&error]) {
            return NO;
        }
        return YES;
    }
    return YES;
}


/**
 *上位机发送数据
 *(NSString *)sendData：从数据库获取到的command数据
 *(NSString *)devType：设备的类型
 *(Byte)bDevID：设备的ID （传入数据表中的rowid即可）
 *(BOOL)bCom：是命令还是数据
 */
- (BOOL)sendData:(NSString *)sendData withDevType:(NSString *)devType withDevID:(Byte)bDevID withCom:(BOOL)bCom
{
    BOOL ret = [self connectToHostAddrees];
    NSLog(@"%d",ret);
    
//    Byte b[10] = {1,2,3,4,5,6,7,8,9,0};
//    NSData *dat = [[NSData alloc] initWithBytes:b length:10];
//    
//    NSString *str = [[NSString alloc] initWithData:dat encoding:NSASCIIStringEncoding];
//    
//    
//    NSData *dat2 = [str dataUsingEncoding:NSASCIIStringEncoding];
    
    
    if ([devType isEqualToString:@"电灯"]) {
        self.bDeviceType = 0x05;
    } else if ([devType isEqualToString:@"电视"]) {
        self.bDeviceType = 0x12;
    } else if ([devType isEqualToString:@"空调"]) {
        self.bDeviceType = 0x11;
    } else if ([devType isEqualToString:@"插座"]) {
        self.bDeviceType = 0x03;
    } else if ([devType isEqualToString:@"窗帘"]) {
        self.bDeviceType = 0x01;
    } else if ([devType isEqualToString:@"摄像头"]) {
        self.bDeviceType = 0x07;
    }
    
    self.bDeviceID = bDevID;
    
    if (bCom) {
        self.bComOrData = 0x01;
    } else {
        self.bComOrData = 0x00;
    }
    
    NSData *dSendData = [sendData dataUsingEncoding:NSASCIIStringEncoding];
    
    self.sDataLength = dSendData.length;

    [self.mdataDataBuf appendBytes:&bDataHeader length:1];
    [self.mdataDataBuf appendBytes:&bDeviceType length:1];
    [self.mdataDataBuf appendBytes:&bDeviceID length:1];
    [self.mdataDataBuf appendBytes:&bComOrData length:1];
    [self.mdataDataBuf appendBytes:&sDataLength length:2];
    [self.mdataDataBuf appendData:dSendData];
    [self.mdataDataBuf appendBytes:&bDataTrailer length:1];

    NSData *writeData = [[NSData alloc] initWithData:self.mdataDataBuf];
    [self.asyncSocket writeData:writeData withTimeout:5 tag:0];
    [self.asyncSocket readDataWithTimeout:-1.0 tag:0];
    
//    [self.asyncSocket disconnect];
    [self.mdataDataBuf setLength:0];
    return NO;
}

- (void)disconnectSocket
{
    [self.asyncSocket disconnect];
}


#pragma mark socket delegate
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	// You could add checks here
    NSLog(@"write data:%ld",tag);
//    [self.asyncSocket disconnect];
    
    
}

- (void)socket:(GCDAsyncSocket *)sock didNotWriteDataWithTag:(long)tag dueToError:(NSError *)error
{
	// You could add checks here
    NSLog(@"--------didNot write data:%ld  %@",tag,error);
//    [self.asyncSocket disconnect];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	NSLog(@"socket:%p didReadData:withTag:%ld", sock, tag);
	
	NSString *httpResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	NSLog(@"HTTP Response:\n%@", httpResponse);
	
}


- (void)socket:(GCDAsyncSocket *)sock didNotReceiveData:(NSData *)data withTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"didNotReceiveData,error:%@",error);
}


@end
