//
//  ViewController.m
//  04-FinalDemo
//
//  Created by qingyun on 16/5/5.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
- (IBAction)finalAction:(id)sender {
    //1.创建一个串行队列
     dispatch_queue_t queue=dispatch_queue_create("com.hnqingyun.ser", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"======2");
        //在串行队列里，同步派发一个任务，势必会造成死锁
       dispatch_sync(queue, ^{
           [NSThread sleepForTimeInterval:1];
           NSLog(@"=======1");
           
       });
        
        NSLog(@"==========完成");
        
    });
    
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
