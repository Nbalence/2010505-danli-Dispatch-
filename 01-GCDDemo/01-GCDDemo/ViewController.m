//
//  ViewController.m
//  01-GCDDemo
//
//  Created by qingyun on 16/5/5.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@end

@implementation ViewController


-(NSString *)fetchLabname{
    [NSThread sleepForTimeInterval:3];
    return @"获取名字成功";
}

-(NSString *)featchLabAge{
  [NSThread sleepForTimeInterval:1];
  return @"年龄获取成功";
}

-(NSString *)featchLabPhone{
    [NSThread sleepForTimeInterval:4];
    return @"电话获取成功";
}

-(NSString *)featchLabSex{
    [NSThread sleepForTimeInterval:2];
    return @"性别获取成功";
}



- (IBAction)FeatchView:(id)sender {
#if 0//1.派发一个异步的请求
    //开始启动的时间
    NSDate *date=[NSDate date];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
     //1.模拟一个耗时的操作
      [NSThread sleepForTimeInterval:2];
       NSLog(@"======耗时2s");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          NSString *str=[self featchLabAge];
          NSLog(@"======%@======",str);
       });
        
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           NSString *str=[self fetchLabname];
           NSLog(@"========%@",str);
           
       });
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           NSString *str=[self featchLabPhone];
           NSLog(@"=====%@",str);
           dispatch_async(dispatch_get_main_queue(), ^{
               //主队列，主线程
               _myTextView.text=@"数据获取完毕，更新成功";
           });
       });
    
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           NSString *str=[self featchLabSex];
           NSLog(@"========%@",str);
           
       });
        //结束时间
        NSDate *sincDate=[NSDate date];
        double times=[sincDate timeIntervalSinceDate:date];
        NSLog(@"=========%f",times);
    });
#endif
    
    //1.创建组
    dispatch_group_t group=dispatch_group_create();
    
    //2.把队列和组关联起来
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"====休眠2s");
       //派发
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str=[self featchLabAge];
        NSLog(@"======%@======",str);
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str=[self fetchLabname];
        NSLog(@"====%@",str);
        
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str=[self featchLabPhone];
        NSLog(@"=======%@",str);
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str=[self featchLabSex];
        NSLog(@"=======%@",str);
    });
    //组关联队列内的任务全部完成，通知组进行监听,主队列进行监听
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       _myTextView.text=@"完成更新";
        
    });
        
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
