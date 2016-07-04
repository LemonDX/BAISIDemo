//
//  RSUser.h
//  BSBDJ
//
//  Created by 杜鑫 on 16/7/1.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
@end
