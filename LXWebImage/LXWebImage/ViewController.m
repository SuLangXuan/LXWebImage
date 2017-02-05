//
//  ViewController.m
//  LXWebImage
//
//  Created by 轩 on 2017/2/4.
//  Copyright © 2017年 com.LX. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+LXWebImage.h"
#import "LXDownloadWebImageOperation.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong)NSArray *imgs;
@property (nonatomic,assign)uint32_t lastIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",NSHomeDirectory());
    self.lastIndex = 0;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}


static int a  = 0;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
    uint32_t index = arc4random_uniform((uint32_t)self.imgs.count);
//
//    while (self.lastIndex == index) {
//        index = arc4random_uniform((uint32_t)self.imgs.count);
//    }
    
    [self.imageView lx_setImageWithURLStr:self.imgs[index] WithPlaceHoder:[UIImage imageNamed:@"lady"]];
//    self.lastIndex = index;
    if (a == 5) {
        a = 0;
    }else {
        a++;
    }
    
}

- (NSArray *)imgs{
    if (!_imgs) {
        NSString *img1 = @"http://i2.itc.cn/20161213/a75_b19169e2_1423_a6e7_854f_b3a0521135e3_1.jpg";
        NSString *img2 = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1486184488&di=43d822f7dfb6241b2a1493413a2cfa62&src=http://img4.duitang.com/uploads/item/201410/25/20141025221045_G8Qih.jpeg";
        NSString *img3 = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1571275099,3149901519&fm=80&w=179&h=119&img.JPG";
        NSString *img4 = @"http://img.cyol.com/img/news/attachement/jpg/site2/20170205/IMGbc8556c8787343627608119.jpg";
        NSString *img5 = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=3831522226,3352728572&fm=80&w=179&h=119&img.JPEG";
        NSString *img6 = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1402459585,3762161313&fm=80&w=179&h=119&img.JPEG";
        _imgs = @[img1,img2,img3,img4,img5,img6];
    }
    return _imgs;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [LXWebImageManger cleanWebCache];
}


@end
