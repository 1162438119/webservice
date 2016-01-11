//
//  ViewController.m
//  DQLSoapAndXML
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dqy. All rights reserved.
//

#import "ViewController.h"
#import "DQYSoapAndXML.h"
@interface ViewController ()<getResultDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *soapMessage = [NSString stringWithFormat:
                             
                             
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n"
                             "<soap12:Body>\n"
                             "<Login xmlns=\"http://tempuri.org/\" >\n"
                             "<ID>%@</ID>\n"
                             "<Password>%@</Password>\n"
                             
                             "</Login>\n"
                             "</soap12:Body>\n"
                             "</soap12:Envelope>",@"15751165579",@"123"
                             ];
    
    
    //请求发送到的路径
    NSString *url =[NSString stringWithFormat:@"http://192.168.1.69/oil_verify.asmx"];
    
    //解析的字段
    
    NSArray * array = [NSArray arrayWithObjects:@"LoginResult", nil];
    
    DQYSoapAndXML * manager = [[DQYSoapAndXML alloc] init];
    
    manager.delegate = self;
    
    [manager requestWithSoapMessage:soapMessage url:url view:self.view resultStringArray:array];
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)getResult:(NSString *)str {
    
    NSLog(@"====================%@",str);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
