//
//  ViewController.m
//  KBPlayer
//
//  Created by chengshenggen on 5/18/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "ViewController.h"
//#import "PlayerController.h"
#import "KBPlayerController2_0.h"

typedef NS_ENUM(NSUInteger, KBVideoType) {
    KBVideoTypeDefault,  //普通视屏
    KBVideoTypePanorama,  //全景视屏
    KBVideoTypePanoramaUpAndDown  //上下全景
};

const NSString *keyVideoType = @"keyVideoType";
const NSString *keyVideoTypeValue = @"keyVideoTypeValue";
const NSString *keyVideoUrl = @"keyVideoUrl";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *array;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.array[indexPath.row] objectForKey:keyVideoTypeValue];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KBPlayerController2_0 *vc = [[KBPlayerController2_0 alloc] init];
    vc.videoDictionary = self.array[indexPath.row];
    [self presentViewController:vc animated:NO completion:nil];
    
}

#pragma mark - setters and getters

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

-(NSMutableArray *)array{
    if (_array == nil) {
        _array = [[NSMutableArray alloc] init];
        
        [_array addObject:@{
                            keyVideoType:[NSNumber numberWithInteger:KBVideoTypeDefault],
                            keyVideoTypeValue:@"普通视屏"}];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"cuc_ieschool" ofType:@"flv"];
        
        //rtmp://0fwc91.live1-rtmp.z1.pili.qiniucdn.com/shutong/test1  香港卫视直播流
        [_array addObject:@{
                            keyVideoType:[NSNumber numberWithInteger:KBVideoTypePanorama],
                            keyVideoTypeValue:@"全景视屏",
                            keyVideoUrl:@"rtmp://0fwc91.live1-rtmp.z1.pili.qiniucdn.com/shutong/test1"}];
        [_array addObject:@{
                            keyVideoType:[NSNumber numberWithInteger:KBVideoTypePanoramaUpAndDown],
                            keyVideoTypeValue:@"上下全景"}];
        
        
    }
    return _array;
}

@end
