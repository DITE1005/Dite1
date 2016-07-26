//
//  ViewController.m
//  POPDecayAnimation
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ViewController.h"
#import "POP.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *igView;

@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 30)];
        _label.backgroundColor = [UIColor whiteColor];
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.igView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    self.igView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
//    [self.view addSubview:self.igView];
    //基本的动画可以用来插入值在指定的时间段。使用一个在打发走动画动画视图的α违约持续时间从0.0到1.0
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    
    anim.fromValue = @(0.0);
    anim.toValue = @(1.0);
//    [self.view pop_addAnimation:anim forKey:@"fade"];
//    [self.igView pop_addAnimation:anim forKey:@"fade"];
    
    // 春天动画可以用来给对象一个令人愉快的反弹。在这个例子中,我们使用一个春天动画动画层的边界从其当前值(0,0,400,400)
    POPSpringAnimation *anim1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    anim1.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
//    [self.view.layer pop_addAnimation:anim1 forKey:@"size"];
    
    //衰变可以使用动画逐渐缓慢的物体停止。在这个例子中,我们衰变一层positionX从它的当前值和速度每秒1000分
    POPDecayAnimation *anim2 = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
//    anim2.duration = 3.0;
    anim2.velocity = @(400.);
//    [self.view.layer pop_addAnimation:anim2 forKey:@"slide"];
//    [self.igView.layer pop_addAnimation:anim2 forKey:@"slide"];
    
#pragma mark ==============      =================
    
    // POPBasicAnimation使用最广泛 提供固定时间间隔的动画(如淡入淡出效果)
    POPBasicAnimation *anBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
   anBasic.toValue = @(self.view.center.y+300);
    anBasic.beginTime = CACurrentMediaTime() + 3.0f;
//    [self.view  pop_addAnimation:anBasic forKey:@"position"];
    // 添加一个动画最少仅需三步
    
    //     定义一个animation对象，并指定对应的动画属性
    
//    设置初始值和默认值(初始值可以不指定，会默认从当前值开始)
//    
//    添加到想产生动画的对象上
    
    // POPBasicAnimation可配置的属性与默认值为  duration:0.4    //动画间隔
    /*
     这个貌似是个定时功能， 可是没有说怎么用
     POPBasicAnimation提供四种timingfunction(很熟悉，对不对? 就是Core Animation中那些)
     
     kCAMediaTimingFunctionLinear
     
     kCAMediaTimingFunctionEaseIn
     
     kCAMediaTimingFunctionEaseOut
     
     kCAMediaTimingFunctionEaseInEaseOut
     */
    
#pragma mark ==============     ===============================
    // POPSpringAnimation也许是大多数人使用POP的理由，其提供一个类似弹簧一般的动画效果(使用后，APP立马就活泼起来了，有木有?
    POPSpringAnimation *anSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anSpring.toValue = @(self.igView.center.y + 200);
    // 动画开始时间
    anSpring.beginTime = CACurrentMediaTime() + 3.f;
    anSpring.springBounciness = 20.0f;
    [self.igView pop_addAnimation:anSpring forKey:@"position"];
    /*
     POPSpringAnimation可配置的属性与默认值为
    
     
     1 springBounciness:4.0    //[0-20] 弹力 越大则震动幅度越大
     2 springSpeed     :12.0   //[0-20] 速度 越大则动画结束越快
     3 dynamicsTension :0      //拉力  接下来这三个都跟物理力学模拟相关 数值调整起来也很费时 没事不建议使用哈
     4 dynamicsFriction:0      //摩擦 同上
     5 dynamicsMass    :0      //质量 同上
     */
    
#pragma mark ============= =============================
    //POPDecayAnimation 提供一个过阻尼效果(其实Spring是一种欠阻尼效果)，可以实现类似UIScrollView的滑动衰减效果(是的 你可以靠它来自己实现一个UIScrollView)
    POPDecayAnimation *anDecay = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anDecay.velocity = @(700);
    anDecay.beginTime = CACurrentMediaTime() + 1.0f;
    
//    [self.igView pop_addAnimation:anDecay forKey:@"position"];
    
    // 注意:这里对POPDecayAnimation设置toValue是没有意义的，会被忽略(因为目的状态是动态计算得到的)
    
    /*
     POPDecayAnimation可配置的属性与默认值为
     
     
     deceleration:0.998  //衰减系数(越小则衰减得越快)
     
     注意:POPDecayAnimation也是没有duration字段的，其动画持续时间由velocity与deceleration决定
     */
    
#pragma mark =====         =========================
    
    
    
    /*
     
     自定义属性
     
     POP默认支持的三种动画都继承自POPPropertyAnimation。POPPropertyAnimation中定义了一个叫property的属性( 之前没有用到它是因为POP根据不同的默认动画属性帮你生成了默认的property) 而这个property则是用来驱动POP的动画效果中的重要一环。
     
     */
    
    // POPAnimatableProperty其实是POP中一个比较重要的东西，像上面提到的POP自带的动画属性，查看源代码可以看到也只是POP自动帮你设置好了POPAnimatableProperty而已，其作用就是当动画的某个时间片被触发时，告诉系统如何根据当前时间片做出变化
//    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"prop" initializer:^(POPMutableAnimatableProperty *prop) {
//       // read value
//        prop.readBlock = ^(id obj, CGFloat values[]){
//            
//        };
//        // write value
//        prop.writeBlock = ^(id obj, const CGFloat values[]){
//            
//        };
//        // dynamics threshold
//        prop.threshold = 0.01;
        /*
         其组成就是一个readBlock一个writeBlock和一个threashold
         
         readBlock告诉POP当前的属性值
         
         writeBlock中修改变化后的属性值
         
         threashold决定了动画变化间隔的阈值，值越大writeBlock的调用次数越少
         */
        
//        POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
//            prop.writeBlock = ^(id obj, const CGFloat values[]){
//                UILabel *label = (UILabel *)obj;
//                label.text = [NSString stringWithFormat:@"d:d:d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)0];
//                label.text = [NSString stringWithFormat:@"d:d:d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)0];
//                label.text = [NSString stringWithFormat:@"d:d:d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)0];
//                label.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];
//            };
//            
//        }];
//        // 秒表当然是用线性的时间函数
//        POPBasicAnimation *anBasic1 = [POPBasicAnimation linearAnimation];
//        // 自定义属性
//        anBasic1.property = prop;
//        // 从0 开始
//        anBasic1.fromValue = @(0);
//        // 180
//        anBasic1.toValue = @(3*60);
//        // 持续3分钟
//        anBasic1.duration = 3 *60;
//        anBasic1.beginTime = CACurrentMediaTime() + 1.0f;
//        [self.label pop_addAnimation:anBasic1 forKey:@"countdown"];
//    }];
    
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            self.label = (UILabel*)obj;
            self.label.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];
        };
        
        //        prop.threshold = 0.01f;
    }];
    
    POPBasicAnimation *anBasic2 = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic2.property = prop;    //自定义属性
    anBasic2.fromValue = @(0);   //从0开始
    anBasic2.toValue = @(3*60);  //180秒
    anBasic2.duration = 3*60;    //持续3分钟
    anBasic2.beginTime = CACurrentMediaTime() + 1.0f;    //延迟1秒开始
    [self.label pop_addAnimation:anBasic2 forKey:@"countdown"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
