//
//  DroiFeedbackViewController.m
//  DroiFeedbackDemo
//
//  Created by Jon on 16/6/27.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "DroiFeedbackViewController.h"
#import "DroiFeedbackSubmitViewController.h"
#import "DroiFeedbackCell.h"
#import "DroiFeedbackRequest.h"
#import "DroiFeedbackDB.h"
#import "DroiFeedbackConfig.h"
@interface DroiFeedbackViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) IBOutlet UIButton *createFeedbackButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UIView *navgationView;
@property (weak, nonatomic) IBOutlet UIView *blankView;

@end

@implementation DroiFeedbackViewController


- (void)dealloc{
    
    [DroiFeedbackDB closeDB];
}

- (instancetype)init{
    
    return [super initWithNibName:@"DroiFeedback.framework/DroiFeedbackViewController" bundle:[NSBundle mainBundle]];
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidAppear:(BOOL)animated{
    
    
    
 
    [DroiFeedbackDB initializeDB];
    [DroiFeedbackRequest requestToGetFeedback:^(BOOL sucess, id object) {
        [self.dataSource removeAllObjects];
        if (sucess) {
            [DroiFeedbackDB deleteAllFeedback];
            for (NSDictionary *dict in object) {
                DroiFeedbackModel *model = [[DroiFeedbackModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataSource addObject:model];
                [DroiFeedbackDB addFeedback:model];
            }
        }
        else{
            NSArray *feedbackArr = [DroiFeedbackDB allFeedback];
            [self.dataSource addObjectsFromArray:feedbackArr];
        }
        [self refreshBlankView];
        [self.tableView reloadData];
    }];
}

- (void)refreshBlankView{
    
    if ([self.dataSource count] == 0) {
        self.blankView.hidden = NO;
    }
    else{
        self.blankView.hidden = YES;
    }

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UINib *cellNib = [UINib nibWithNibName:@"DroiFeedback.framework/DroiFeedbackCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DroiFeedbackCell"];
    
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    UIImage *image = [UIImage imageNamed:@"DroiFeedback.framework/NewFeedback"];
    [self.createFeedbackButton setImage:image forState:UIControlStateNormal];
    
    UIImage *closeimage = [UIImage imageNamed:@"DroiFeedback.framework/CloseFeedback"];
    [self.closeButton setImage:closeimage forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DroiFeedbackModel *model = (DroiFeedbackModel *)self.dataSource[indexPath.section];
    DroiFeedbackCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DroiFeedbackCell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 设置为一个接近“平均”行高的值
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



- (IBAction)createFeedback:(UIButton *)sender {

    [self createFeedback];
}

- (IBAction)close:(id)sender {
    
    [self close];
}

- (void)createFeedback{
    
    DroiFeedbackSubmitViewController *submitVC = [[DroiFeedbackSubmitViewController alloc] init];
    [self.navigationController pushViewController:submitVC animated:YES];
}


- (void)close{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setupNavigationBar{
    
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navgationView.backgroundColor = [DroiFeedbackConfig defaultConfig].color;
//    self.navigationItem.title = @"意见反馈";
//    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(createFeedback)];
}
@end
