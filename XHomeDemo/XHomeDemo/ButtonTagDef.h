//
//  ButtonTagDef.h
//  XHomeDemo
//
//  Created by Gene on 14-5-20.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#ifndef XHomeDemo_ButtonTagDef_h
#define XHomeDemo_ButtonTagDef_h

////////////////////////////////////////////////////////////////////
//BUTTON_TAG

#define BUTTON_TAG_OK           1
#define BUTTON_TAG_CANCLE       0

#define ROOMS_BUTTON_TAG        10000

#define SCENARY_BUTTON_TAG      20000
#define ADDNEW_SCENARY_BUTTON_TAG (SCENARY_BUTTON_TAG + 1000)

#define DEVICE_BUTTON_TAG       25000
#define ADDNEWDEV_BUTTON_TAG    (DEVICE_BUTTON_TAG + 1000)
#define DEVICE_TYPE_BUTTON_TAG  (DEVICE_BUTTON_TAG + 1001)
#define DEVICE_ROOM_BUTTON_TAG  (DEVICE_BUTTON_TAG + 1002)

#define AIRCON_BUTTON_TAG       30000

#define SOC_BUTTON_TAG          40000

#define TV_BUTTON_TAG           50000

#define CURTAIN_BUTTON_TAG      60000

#define WEBCAM_BUTTON_TAG       70000

#define LAMP_BUTTON_TAG         80000
#define ADDNEW_LAMP_BUTTON_TAG  (LAMP_BUTTON_TAG + 1)

#define OTHER_BUTTON_TAG        90000
#define MOREROOMINFO_BUTTON_TAG (OTHER_BUTTON_TAG + 1)
#define ADDNEWROOM_BUTTON_TAG   (OTHER_BUTTON_TAG + 2)

///////////////////////////////////////////////////////////////
//ALERTVIEW_TAG

#define ALERT_VIEW_TAG          1000
#define ALERT_VIEW_UPDATE       (ALERT_VIEW_TAG + 1)
#define ALERT_VIEW_BTN_LONG_PRESS   (ALERT_VIEW_TAG +2)
#define ALERT_VIEW_ADDDEV       (ALERT_VIEW_TAG + 3)
#define ALERT_VIEW_ADDSCENARY   (ALERT_VIEW_TAG + 4)


#endif
