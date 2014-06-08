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
@synthesize mdataRecvDataBuf;
@synthesize sDataLength;
@synthesize bDataHeader;
@synthesize bDataTrailer;
@synthesize recvDataThread;

@synthesize sendRecvDataDelegate;

@synthesize m_act;
@synthesize m_obj;


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
        if (!self.mdataRecvDataBuf) {
            self.mdataRecvDataBuf = [[NSMutableData alloc] init];
        }
        
        //create socket
        if (!self.asyncSocket) {
            self.asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self  delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
        }
        
        
        //创建接收数据线程 一直从端口接收数据
        if (!self.recvDataThread) {
            recvDataThread = [[NSThread alloc] initWithTarget:self selector:@selector(reciveDataMethod) object:nil];
            [recvDataThread start];
        } else {
            [self.recvDataThread cancel];
//            [self.recvDataThread release];
            self.recvDataThread = [[NSThread alloc] initWithTarget:self selector:@selector(reciveDataMethod) object:nil];
            [self.recvDataThread start];
        }
        
        
    }
    return self;
}

- (void)dealloc
{
    
    if (self.recvDataThread) {
        [self.recvDataThread cancel];

    }
    
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
- (BOOL)sendData:(NSData *)sendData withDevType:(NSString *)devType withDevID:(Byte)bDevID withCom:(BOOL)bCom
{
    BOOL ret = [self connectToHostAddrees];
    NSLog(@"%d",ret);
    
//    Byte b[10] = {0,1,2,3,4,5,6,7,8,9,0};
//    NSData *da = [[NSData alloc] initWithBytes:b length:11];
//    
//    NSString *str = [[NSString alloc] initWithData:da encoding:6];
//    
//    
//    NSData *dat2 = [str dataUsingEncoding:6];
//    NSLog(@"%@",dat2);
    
    
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
    
//    NSData *tempdSendData = [sendData dataUsingEncoding:6];
//    
//    int len = [sendData length];
//    Byte tmpData[len];
//    
//    for (int i = 0; i<len; i++) {
//        [tempdSendData getBytes:&tmpData[i] range:NSMakeRange(i, 1)];
//        tmpData[i] -= 1;
//        NSLog(@"%hhu",tmpData[i]);
//    }
    NSData *dSendData = [[NSData alloc] initWithData:sendData];
    
//    NSString *s = [[NSString alloc] initWithData:dSendData encoding:NSASCIIStringEncoding];
//    NSLog(@"%@",s);
    self.sDataLength = dSendData.length;
    Byte bDataLenH = self.sDataLength >> 8;
    Byte bDataLenL = self.sDataLength & 0xFF;
    
    [self.mdataDataBuf appendBytes:&bDataHeader length:1];
    [self.mdataDataBuf appendBytes:&bDeviceType length:1];
    [self.mdataDataBuf appendBytes:&bDeviceID length:1];
    [self.mdataDataBuf appendBytes:&bComOrData length:1];
    [self.mdataDataBuf appendBytes:&bDataLenH length:1];
    [self.mdataDataBuf appendBytes:&bDataLenL length:1];
    [self.mdataDataBuf appendData:dSendData];
    [self.mdataDataBuf appendBytes:&bDataTrailer length:1];

    NSData *writeData = [[NSData alloc] initWithData:self.mdataDataBuf];
    [self.asyncSocket writeData:writeData withTimeout:5 tag:0];
//    [self.asyncSocket readDataWithTimeout:-1.0 tag:0];
    
    [self.mdataDataBuf setLength:0];
    return NO;
}

- (void)disconnectSocket
{
    [self.asyncSocket disconnect];
}




- (void)reciveDataMethod
{
    while (YES) {
        if ([[NSThread currentThread] isCancelled]) {
            [NSThread exit];
        }
        sleep(3);
        
        [self connectToHostAddrees];
        
        //TODO:处理接收的数据
        [self.asyncSocket readDataWithTimeout:3 buffer:self.mdataRecvDataBuf bufferOffset:self.mdataRecvDataBuf.length tag:10];
//        [self.asyncSocket readDataWithTimeout:5 tag:10];
        NSLog(@"Thread--mdataRecvDataBuf:%@",self.mdataRecvDataBuf);
        
        short dataLen;
        if (self.mdataRecvDataBuf.length > 6) {
            Byte len2[2];
            [self.mdataRecvDataBuf getBytes:&len2[0] range:NSMakeRange(4, 1)];
            [self.mdataRecvDataBuf getBytes:&len2[1] range:NSMakeRange(5, 1)];
            dataLen = ((len2[0] << 8) | len2[1]);
            NSLog(@"%ld",(unsigned long)self.mdataRecvDataBuf.length);
            if (dataLen + 4+2+1 == self.mdataRecvDataBuf.length) {
                NSMutableData *mdataTempData = [[NSMutableData alloc] initWithData:self.mdataRecvDataBuf];
                [self.mdataRecvDataBuf setLength:0];
                [self dealWithARecvPacktData:mdataTempData];
                
            } else if ((dataLen + 7) < self.mdataRecvDataBuf.length) { //接收数据错误重新接收
                [self.mdataRecvDataBuf setLength:0];
            }
        }
    }
}

- (void)dealWithARecvPacktData:(NSData *)recvData
{
    NSLog(@"dealWithData:%@",recvData);
    
    Byte header,trailer;
    [recvData getBytes:&header range:NSMakeRange(0, 1)];
    [recvData getBytes:&trailer range:NSMakeRange(recvData.length -1, 1)];
    
    if (header == 0x00 && trailer == 0xFF) {
        //使用代理将收的数据发出去
        if ([self.sendRecvDataDelegate respondsToSelector:@selector(recvSocketData:)])
        {
            [self.sendRecvDataDelegate recvSocketData:recvData];
            
        }
    } else {
        NSLog(@"DataError!");
    }
    
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
   
//    NSData *recData = [[NSData alloc] initWithData:data];
//    short recDataLen;
//    [self.mdataRecvDataBuf appendData:recData];
    NSLog(@"-----didReadData data:%@",data);
//     NSLog(@"didReadData mdataRecvDataBuf:%@",self.mdataRecvDataBuf);
}


- (void)socket:(GCDAsyncSocket *)sock didNotReceiveData:(NSData *)data withTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"didNotReceiveData,error:%@",error);
}


@end
