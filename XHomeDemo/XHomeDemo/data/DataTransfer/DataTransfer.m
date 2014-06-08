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
        sleep(1);

        [self connectToHostAddrees];
        //TODO:处理接收的数据
        
        [self.asyncSocket readDataWithTimeout:5 buffer:self.mdataRecvDataBuf bufferOffset:self.mdataRecvDataBuf.length tag:10];

        sleep(5);
//        [self.asyncSocket readDataWithTimeout:-1.0 tag:10];
        
        NSLog(@"Thread--mdataRecvDataBuf:%@",self.mdataRecvDataBuf);
        
//        int len = [self.mdataRecvDataBuf length];
//        Byte tmpData[len];
//        
//        for (int i = 0; i<len; i++) {
//            [self.mdataRecvDataBuf getBytes:&tmpData[i] range:NSMakeRange(i, 1)];
//            NSLog(@"%hhu",tmpData[i]);
//        }
        
        
    }
}

- (void)dealWithARecvPacktData:(NSData *)recvData
{
    
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
   
    NSData *recData = [[NSData alloc] initWithData:data];
//    short recDataLen;
//    [self.mdataRecvDataBuf appendData:recData];
    NSLog(@"-----didReadData data:%@",data);
//     NSLog(@"didReadData mdataRecvDataBuf:%@",self.mdataRecvDataBuf);
    /*
    int len = [recMultData length];
    recvDataCount = len;
    Byte tmpData[recvDataCount];
    
    for (int i = 0; i<recvDataCount; i++) {
        [recMultData getBytes:&tmpData[i] range:NSMakeRange(i, 1)];
        NSLog(@"%hhu",tmpData[i]);
    }
    if (tmpData[0] == 0x00) {
        if (recvDataCount >= 3) {
            recDataLen = (tmpData[1] << 8) | (tmpData[2]&0xFF);
            
            if(recvDataCount == recDataLen && (tmpData[recvDataCount - 1] == 0xFF) ) {//如果数据接收完整
                
                //得到数据
                gType = tmpData[3];
                
                //TODO:find the max id
                NSMutableArray *tmpMutArry = [self readDataFile];
                Byte tmpLastID = 0, tmpPreID  = 0, tmpMaxID = 0;
                for (NSInteger i = 0; i<tmpMutArry.count; i++) {
                    NSMutableDictionary * tmpMutDic = [tmpMutArry objectAtIndex:i];
                    
                    Byte tmpType = [[tmpMutDic objectForKey:@"type"] unsignedCharValue];
                    if (tmpType == gType) {
                        
                        tmpPreID = [[tmpMutDic objectForKey:@"ID"] unsignedCharValue];
                        tmpMaxID = tmpPreID >= tmpLastID ? tmpPreID :tmpLastID;
                        tmpLastID = tmpPreID;
                        
                    }
                }
                
                gID = tmpMaxID + 1;
                
                uint64_t tmpUUID = 0;
                for (int i = 0; i<8; i++) {
                    tmpUUID = tmpUUID << 8;
                    tmpUUID |= tmpData[i+6];
                }
                
                gUUIDH = tmpUUID;
                
                tmpUUID = 0;
                for (int i = 0; i<8; i++) {
                    tmpUUID = tmpUUID << 8;
                    tmpUUID |= tmpData[i+14];
                }
                
                gUUIDL = tmpUUID;
                
                
                
                switch (tmpData[3]) {
                    case 0x00:
                        NSLog(@"主控");
                        [_DevNameLab setText:@"主控"];
                        gDevNameTextf.text = [NSString stringWithFormat: @"主控%d",gID];
                        
                        break;
                    case 0x01:
                        NSLog(@"窗帘开关型");
                        [_DevNameLab setText:@"窗帘开关型"];
                        gDevNameTextf.text = [NSString stringWithFormat: @"窗帘开关型%d",gID];
                        break;
     
                }
                
                
                [_actIdctV stopAnimating];
                [recMultData setLength:0];
                recvDataCount = 0;
                //                [_asyncSocket readDataWithTimeout:-1.0 tag:1];
            }
            else{//如果接收到的数据没有到达接收到数据的长度 并且帧尾不是0xFF继续接收
                [_asyncSocket readDataWithTimeout:-1.0 tag:1];
            }
        } else { //如果接受的数据不够 继续接收
            [_asyncSocket readDataWithTimeout:-1.0 tag:1];
        }
        
    } else { //如果枕头不是0x00 抛掉以前接收的数据重新接收
        //clean recMultData;重新接受
        [recMultData setLength:0];
        recvDataCount = 0;
        [_asyncSocket readDataWithTimeout:-1.0 tag:1];
    }
	*/
}


- (void)socket:(GCDAsyncSocket *)sock didNotReceiveData:(NSData *)data withTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"didNotReceiveData,error:%@",error);
}


@end
