//
//  IPlanUtility.h
//  iPlan
//
//  Created by Xu Yecheng on 6/20/11.
//  Copyright 2011 NUS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConstantFile.h"


@interface IPlanUtility : NSObject {

}

+ (NSNumber*) weekOfDayStringToNSNumber:(NSString*)day;
+ (NSArray*) frequencyStringToNSArray:(NSString*)fre;

@end