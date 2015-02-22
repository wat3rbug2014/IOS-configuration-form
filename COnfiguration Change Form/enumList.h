//
//  enumList.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This header defines a number of things used throughout the application.
 * The device types as enums are defined here and used byt the PickerItems class
 * and all subsequent selection data models for selection.  Changes should be made 
 * in this file for new devices.
 */

#ifndef COnfiguration_Change_Form_enumList_h
#define COnfiguration_Change_Form_enumList_h

enum device {
    UNDEFINED,
    AD,     // Aggregation Device
    AP,     // Access Point
    AR,     // Access Router
    AS,     // Access Switch
    BD,     // Border Router
    CM,     // Call Manager
    CS,     // Core Switch
    CR,     // Core Router
    DS,     // Distribution Switch
    DR,     // Distribution Router
    FW,     // Firewall
    LB,     // Load Balancer
    NM,     // NAM Module
    PD,     // Power Distribution Unit
    PS,     // Power Strip
    PX,     // Proxy
    UP,     // UPS
    VP,     // VPN Controller
    WC,     // Wireless Controller
    WB      // Wireless Bridge
};
enum sites {
    JSC,
    WSTF,
    JPL,
    KSC,
    LARC
};

enum connectType {
    
    REPLACE,
    OTHER,
    ADD,
    REMOVE
};
#define DEF_ROW 2
#endif
