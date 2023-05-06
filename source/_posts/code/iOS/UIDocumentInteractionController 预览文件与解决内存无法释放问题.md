---
title: UIDocumentInteractionController 预览文件与解决内存无法释放问题
updated: 2023-05-05 04:28:56Z
created: 2023-05-05 04:28:51Z
---

##设置为属性

    @property (nonatomic ,strong) UIDocumentInteractionController *documentInteractionController;
创建

    - ( void )setupDocumentControllerWithURL:( NSURL *)url
    {
        if ( self.documentInteractionController == nil ){
            self.documentInteractionController = [ UIDocumentInteractionController interactionControllerWithURL :url];
        self.documentInteractionController.delegate = self ;
        }
        else {
            self.documentInteractionController.URL = url;
        }
     }

      /**
      *  打开文件
      */
    -(void)openFileWithPath:(NSString*)path{
    NSURL* URL = [NSURL fileURLWithPath:path];
    if (URL) {
    [ self setupDocumentControllerWithURL :URL];
    // CGRect rect = CGRectMake ( 0 , 0 , kScreenW , kScreenH);
    // [self.documentInteractionController presentOptionsMenuFromRect:rect inView:self.view  animated:YES];//包含快速预览菜单
    [self.documentInteractionController presentPreviewAnimated:YES];
    }
    }

##必须需要实现代理方法才能预览

    /**
    *  预览用的Controller
    */
    -(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
    }

    /**
    *  预览用的View
    */
    -(UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
    }

    - (void)documentInteractionControllerWillBeginPreview:(UIDocumentInteractionController *)controller{
    NSLog(@"will begin preview");
    }

    - (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller{
    NSLog(@"did end preview");
    }

###这样使用是可以了.当你要在下载文件完成后打开文件,会这样写

    NSData *data = responseObject;
    BOOL isWrite = [data writeToFile:[MyTools filePathInTmpWithFile:fileName] atomically:YES];
    MAIN(^{
    [self.mbHud hideAnimated:YES];
    });
    if (isWrite) {//调用打开文件
    [self openFileWithPath:[MyTools filePathInTmpWithFile:fileName]];
    }else{
    MAIN(^{
    [MyTools showAlertWithTitle:kLocStr(@"提示") andContent:kLocStr(@"打开文件失败!") andBlock:nil atController:self];
    });
    }

####这样会出现问题,当下载的过程中,退出当前页面,下载会继续的,下载完成后继续运行你的代码打开文件进行预览,虽然你看不到这个过程,但是确实是这样的,而且会造成当前控制器无法释放,造成内存泄漏!

###解决办法:
    @property (nonatomic ,assign) BOOL isAppear;         //判断是否当前页面正在显示
     - (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isAppear = NO;
    if (self.documentInteractionController) {
    self.documentInteractionController.delegate = nil;
    NSLog(@"\\ndelegate == nil\\n");
    }
    }

    - (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isAppear = YES;
    if (self.documentInteractionController) {
    self.documentInteractionController.delegate = self;
    }
    }



    - ( void )setupDocumentControllerWithURL:( NSURL *)url
    {
    if (!self.isAppear) {
    return;
    }
    if ( self.documentInteractionController == nil ){
    self.documentInteractionController = [ UIDocumentInteractionController interactionControllerWithURL :url];
    self.documentInteractionController.delegate = self ;
    }
    else {
    self.documentInteractionController.URL = url;
    }
    }

    - (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller{
    NSLog(@"did end preview");
    self.documentInteractionController = nil;
    }

#这样就可以了!