---
title: NSTimer 简单用法以及容易造成内存泄漏解决办法
updated: 2023-05-05 06:23:53Z
created: 2023-05-05 06:20:32Z
---

#### 使用NSTimer最好是升级为属性,容易控制

### 简单使用
- 设置为属性
     > @property (nonatomic ,strong) NSTimer *timer;           //定时器
- 懒加载
 ```c
      -(NSTimer*)timer{
        if (_timer == nil) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
        }
        return _timer;
      }
```
- 开始动画与暂停动画
```c
      /**
       *  开始动画
       */
        -(void)beginAnimation{
          self.timer.fireDate=[NSDate distantPast];
      }
       /**
       *  结束动画
       */
       -(void)endAnimation{
          self.timer.fireDate=[NSDate distantFuture];
      }
```

### 如果只是使用的话,这已经完了,但是会造成self无法释放
### ==================================
----------------
### 解决办法,在界面要不显示的时候把定时器注销并且置空
```
        -(void)viewWillDisappear:(BOOL)animated{
            [super viewWillDisappear:animated];
            [self.timer invalidate];
            self.timer = nil;
        }
```

### 这样就可以了,可以打印dealloc测试了



## GCD
    dispatch source是一个监视某些类型事件的对象。当这些事件发生时，它自动将一个block放入一个dispatch queue的执行例程中。
```c
    /**
     *  创建dispatch源
     *
     *  @param DISPATCH_SOURCE_TYPE_TIMER 事件源的类型
     *  @param 0                          <#0 description#>
     *  @param 0                          <#0 description#>
     *  @param dispatch_get_main_queue    在哪个线程上执行
     *
     *  @return dispatch_source_t
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    /**
     * @param start 控制计时器第一次触发的时刻
     * @param interval 每隔多长时间执行一次
     * @param leeway 误差值，0表示最小误差，值越小性能消耗越大
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    /**
     *  事件处理的回调
     */
    dispatch_source_set_event_handler(timer, ^{
        //取消定时器
    dispatch_cancel(timer);
    });
    /**
     *  Dispatch source启动时默认状态是挂起的，我们创建完毕之后得主动恢复，否则事件不会被传递，也不会被执行
     */
    dispatch_resume(timer);
```

##### GCD定时器的优点有很多，首先不受Mode的影响，而NSTimer受Mode影响时常不能正常工作，除此之外GCD的精确度明显高于NSTimer，这些优点让我们有必要了解GCD定时器这种方法。


#### 示例
```c
    -(void)clickOnButton
    {    
        //获取一个并行队列 (默认优先级队列)
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //创建 timer
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        _timer = timer;
        //设置timer间隔和精度
        //interval:间隔 (纳秒),配合NSEC_PER_SEC用就是秒
        //leeway:精度 ,最高精度当然就传0。
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
        //设置回调
        WeakObj(self);
        __block NSInteger count = 0;
        dispatch_source_set_event_handler(timer, ^{
            NSString *str = nil;
            if (count >= 3600) {
                str = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)(count/3600),(int)((count%3600)/60),(int)(count%60)];
            }else{
                str = [NSString stringWithFormat:@"%02d:%02d",(int)(count/60),(int)(count%60)];
            }
        
            MAIN(^{
                selfWeak.timeLabel.text = str;
            });
            count++;
        });
        dispatch_resume(timer);
    }
```