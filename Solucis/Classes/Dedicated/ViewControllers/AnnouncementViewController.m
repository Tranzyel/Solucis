//
//  AnnouncementViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-22.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "AnnouncementViewController.h"
#import "AnnouncementTableViewCell.h"
#import "MCOAnnoucementListModel.h"
#import "AnnouncementDetailsViewController.h"

static NSString *const AnnouncementTableViewCellIdentifier = @"AnnouncementTableViewCellIdentifier";

@interface AnnouncementViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong) NSArray *annoucements;
@end

@implementation AnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"nav_bar_announcement_title", "");
    
    [[RequestMgr shared] requestAnnouncementListWithCompletionBlock:^(id response) {
        
        self.annoucements = [[LocalStorage shared] announcementLists];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AnnouncementTableViewCell class]) bundle:nil] forCellReuseIdentifier:AnnouncementTableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.0f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.annoucements.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnouncementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AnnouncementTableViewCellIdentifier];
    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.contentView.layer.borderWidth = 1.0f;

    MCOAnnoucementListModel *model = self.annoucements[indexPath.row];
    
    cell.titleLbl.text = model.f_title;
    cell.startLbl.text = [NSString stringWithFormat:@"%@",model.startDate];
    cell.endLbl.text = [NSString stringWithFormat:@"%@",model.endDate];
    cell.viewDetails.tag = indexPath.row;
    [cell.viewDetails addTarget:self action:@selector(viewDetailsAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)viewDetailsAction:(id)sender
{
    MCOAnnoucementListModel *model = self.annoucements[[sender tag]];
    
    AnnouncementDetailsViewController *controller = [[AnnouncementDetailsViewController alloc] init];
    controller.htmlText = model.f_detail;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
