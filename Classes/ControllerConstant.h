//
//  ControllerConstant.h
//  iPlan
//
//  Created by Yingbo Zhan on 11-7-2.
//  Copyright 2011 NUS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HEADER_ORIGIN_X 10
#define HEADER_ORIGIN_Y	10
#define NUMBER_OF_ROW_LINES 17
#define NUMBER_OF_COL_LINES 7
#define GAP_HEIGHT 20
#define GAP_WIDTH 50
#define TOTAL_HEIGHT (NUMBER_OF_ROW_LINES-1)*GAP_HEIGHT
#define TOTAL_WIDTH (NUMBER_OF_COL_LINES-1)*GAP_WIDTH
#define SCROLLVIEW_HEIGHT TOTAL_HEIGHT+HEADER_ORIGIN_Y
#define SCROLLVIEW_WIDTH TOTAL_WIDTH+HEADER_ORIGIN_X
#define SCROLLVIEW_HEIGHT_ZOOM TOTAL_HEIGHT*2.2
#define SCROLLVIEW_WIDTH_ZOOM TOTAL_WIDTH*2.3
#define SCROLL_AFTER_ZOOM_X TOTAL_WIDTH*1.1
#define SCROLL_AFTER_ZOOM_Y TOTAL_HEIGHT*1.4
#define SCROLL_BEFORE_ZOOM_X 160
#define SCROLL_BEFORE_ZOOM_Y 250

#define LINE_TAG 100
#define LABEL_TAG 100
#define CLASS_VIEW_TAG 200
#define SCROLL_TAG 0
#define DISPLAY_TAG 1
@interface ControllerConstant : NSObject {

}

@end
