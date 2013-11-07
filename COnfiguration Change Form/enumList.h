//
//  enumList.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#ifndef COnfiguration_Change_Form_enumList_h
#define COnfiguration_Change_Form_enumList_h

enum device {
    UNDEFINED,
    AD,
    AP,
    AR,
    AS,
    BD,
    CM,
    CS,
    CR,
    DS,
    DR,
    FW,
    LB,
    NM,
    PD,
    PS,
    PX,
    UP,
    VP,
    WC
};
enum sites {
    JSC,
    WSTF,
    JPL,
    LARC
};

enum connectType {
    
    BOTH,
    ADD,
    REMOVE
};
#define DEF_ROW 2
#endif
