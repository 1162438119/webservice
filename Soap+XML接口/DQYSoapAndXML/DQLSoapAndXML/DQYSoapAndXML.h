//
//  DQYSoapAndXML.h
//  DQLSoapAndXML
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dqy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MBProgressHUD.h"



//协议
@protocol getResultDelegate <NSObject>

- (void)getResult:(NSString *) str;

@end

@interface DQYSoapAndXML : NSObject<NSXMLParserDelegate>


@property (nonatomic, strong) NSMutableArray * webData;

@property (nonatomic, strong) NSXMLParser * xmlParser;


@property (nonatomic, strong) NSMutableString * xmlString;

@property (nonatomic, assign) BOOL elementFound;


@property (nonatomic, strong) UIView * view;

@property (nonatomic, assign) id<getResultDelegate>delegate;

//获取结果的字段的数组
@property (nonatomic, strong) NSMutableArray * argsArray;



- (void)requestWithSoapMessage:(NSString *) soapMessage url:(NSString *) urlString view:(UIView *) view resultStringArray:(NSArray *) resultStringArray;
@end
