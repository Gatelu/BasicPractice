//
//  Contact.m
//  私人通讯录
//
//  Created by Gate on 16/1/16.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "Contact.h"

@implementation Contact
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.phone forKey:@"phone"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
    }
    return self;
}
@end
