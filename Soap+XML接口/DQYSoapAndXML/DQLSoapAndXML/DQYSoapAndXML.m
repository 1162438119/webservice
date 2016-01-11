//
//  DQYSoapAndXML.m
//  DQLSoapAndXML
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dqy. All rights reserved.
//

#import "DQYSoapAndXML.h"

@implementation DQYSoapAndXML


- (void)requestWithSoapMessage:(NSString *)soapMessage url:(NSString *)urlString view:(UIView *) view resultStringArray:(NSArray *)resultStringArray{
    
    //初始化xmlString
    self.xmlString = [[NSMutableString alloc] init];
    
    //接受需要解析的字段数组
    self.argsArray = [NSMutableArray arrayWithArray:resultStringArray];
    
    //父视图
    self.view = view;
   
    //启动hud
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    //创建请求
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    //soap的长度
    NSString * soapMessageLenth = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    
    
    [request addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:soapMessageLenth forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPMethod:@"POST"];
    
    //将soap请求加入到请求中
    
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //创建连接
    
    NSURLSession * session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //进行xml解析
        self.xmlParser = [[NSXMLParser alloc] initWithData:data];
        
        self.xmlParser.delegate = self;
        
        [self.xmlParser parse];
        
    }];
    
    
    //启动 session
    [dataTask resume];
    
}


- (void)stopHUD {
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}



#pragma mark ------------------- xml delegate
// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    
    if (self.argsArray.count > 0) {
        
        
        if ([elementName isEqualToString:self.argsArray[0]]) {
            if (self.xmlString == nil) {
                self.xmlString = [[NSMutableString alloc] init];
            }
            
            self.elementFound = YES;
        }
        
    }
    else {
        
    }
    
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (self.elementFound) {
        [self.xmlString appendString: string];
    }
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:self.argsArray[0]]){
        
        //传值
        if (self.delegate) {
            
            
            [self performSelectorOnMainThread:@selector(stopHUD) withObject:nil waitUntilDone:NO];
            
            [self.delegate getResult:self.xmlString];
        }
        
        [self.argsArray removeObjectAtIndex:0];
    
    }
    
    if (self.argsArray.count == 0) {
        
        self.elementFound = NO;
        
        [self.xmlParser abortParsing];
    }
}

// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    
    
    if (self.xmlString) {
        self.xmlString = nil;
    }
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.xmlString) {
        self.xmlString = nil;
    }
}





@end
