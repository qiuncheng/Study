//
//  ViewController.m
//  SocketDemo
//
//  Created by 程庆春 on 07/11/2016.
//  Copyright © 2016 qiuncheng.com. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *hostTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *portTextField;
@property (weak, nonatomic) IBOutlet UITextField *msgTextField;
@property (weak, nonatomic) IBOutlet UILabel *receiveLabel;

@property (assign, nonatomic) int clientSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)connectButtonDidClicked:(id)sender {
    BOOL result = [self connectToHost:self.hostTextFiled.text port:self.portTextField.text.intValue];
    self.receiveLabel.text = result ? @"success" : @"failed";
}
- (IBAction)sendButtonDidClicked:(id)sender {
    self.receiveLabel.text = [self sendAndRecv:self.msgTextField.text];
}

#pragma mark -
- (BOOL) connectToHost:(NSString *)host port:(int)port {
    self.clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    struct sockaddr_in serverAddress;
    serverAddress.sin_family = AF_INET; // 协议簇
    // IP 查找机器
    serverAddress.sin_addr.s_addr = inet_addr(host.UTF8String);
    serverAddress.sin_port = htons(port); // 端口 查找程序
    return (connect(self.clientSocket, (const struct sockaddr *)&serverAddress, sizeof(serverAddress) == 0));
}
- (NSString *) sendAndRecv:(NSString *) message {
    /// 1. 发送消息
//    ssize_t sendLen = send(self.clientSocket, message.UTF8String, strlen(message.UTF8String), 0);
    send(self.clientSocket, message.UTF8String, strlen(message.UTF8String), 0);
    /// 2. 接收消息
    // 2.1 定义一个数组
    uint8_t buffer[2048];
    // ssize_t recvLen =
    recv(self.clientSocket, buffer, sizeof(buffer), 0);
    // 2.2 获取服务器返回的二进制数据
    NSData *data = [NSData dataWithBytes:buffer length:2048];
    // 2.3 转换成字符串
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}
- (void)disconnection {
    close(self.clientSocket);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
