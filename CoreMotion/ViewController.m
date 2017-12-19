#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "BasicDemoController.h"
#import "ImageDemoController.h"
#import "PopDemoController.h"

@interface ViewController ()

//UI
@property (nonatomic,strong) UIButton *basicDemoButton;
@property (nonatomic,strong) UIButton *imageDemoButton;
@property (nonatomic,strong) UIButton *popDemoButton;

@end

@implementation ViewController

#pragma mark - 懒加载

- (UIButton *)basicDemoButton{
    if (!_basicDemoButton) {
        _basicDemoButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-15-200, 100, 30)];
        [_basicDemoButton setTitle:@"基本演示" forState:UIControlStateNormal];
        [_basicDemoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_basicDemoButton addTarget:self action:@selector(pushToBasic) forControlEvents:UIControlEventTouchUpInside];
    }
    return _basicDemoButton;
}

- (UIButton *)imageDemoButton{
    if (!_imageDemoButton) {
        _imageDemoButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-15, 100, 30)];
        [_imageDemoButton setTitle:@"旋转演示" forState:UIControlStateNormal];
        [_imageDemoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_imageDemoButton addTarget:self action:@selector(pushToImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageDemoButton;
}

- (UIButton *)popDemoButton{
    if (!_popDemoButton) {
        _popDemoButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-15+200, 100, 30)];
        [_popDemoButton setTitle:@"Pop演示" forState:UIControlStateNormal];
        [_popDemoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_popDemoButton addTarget:self action:@selector(pushToPop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popDemoButton;
}


#pragma mark - 生命周期处理

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.basicDemoButton];
    [self.view addSubview:self.imageDemoButton];
    [self.view addSubview:self.popDemoButton];
}

#pragma mark - method

- (void)pushToBasic{
    [self.navigationController pushViewController:[BasicDemoController new] animated:YES];
}

- (void)pushToImage{
    [self.navigationController pushViewController:[ImageDemoController new] animated:YES];
}

- (void)pushToPop{
    [self.navigationController pushViewController:[PopDemoController new] animated:YES];
}

@end


