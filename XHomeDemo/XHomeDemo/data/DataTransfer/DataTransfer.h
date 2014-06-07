//
//  DataTransfer.h
//  XHomeDemo
//
//  Created by Gene on 14-6-7.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@interface DataTransfer : NSObject<GCDAsyncSocketDelegate>

@property(strong,nonatomic)GCDAsyncSocket *asyncSocket;
@property Byte bDeviceType;
@property Byte bDeviceID;
@property Byte bComOrData;
@property Byte bDataHeader;
@property Byte bDataTrailer;
@property short sDataLength;
@property(strong,nonatomic)NSMutableData *mdataDataBuf;


/**
 *初始化socket
 */
- (id)init;


/**
 *上位机发送数据 
 *(NSString *)sendData：从数据库获取到的command数据
 *(NSString *)devType：设备的类型
 *(Byte)bDevID：设备的ID （传入数据表中的rowid即可）
 *(BOOL)bCom：是命令还是数据
 */
- (BOOL)sendData:(NSString *)sendData withDevType:(NSString *)devType withDevID:(Byte)bDevID withCom:(BOOL)bCom;


- (void)disconnectSocket;

@end
