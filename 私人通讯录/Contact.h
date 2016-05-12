//
//  Contact.h
//  私人通讯录
//
//  Created by Gate on 16/1/16.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject <NSCoding>
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *phone;


@end
