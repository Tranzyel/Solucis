//
//  AnnouncementDetailsViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-22.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "AnnouncementDetailsViewController.h"
#import "AnnouncemetnListDetailTableViewCell.h"
#import "MCOAnnouncementListDetailModel.h"
#import <UIImageView+AFNetworking.h>


@interface AnnouncementDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic, strong) NSArray *announcementDetails;

@end

@implementation AnnouncementDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"nav_bar_announcement_title", "");
    [self showBackButton];
    [self.webview loadHTMLString:self.htmlText baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.announcementDetails.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnouncemetnListDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AnnouncemetnListDetailTableViewCellIdentifier];
    
    MCOAnnouncementListDetailModel *model = self.announcementDetails[indexPath.row];
    
    if (model.bannerImage == nil)
    {
        NSURLRequest *imageURLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:model.imageURL]];
        
        [cell.bannerImageView setImageWithURLRequest:imageURLRequest placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            cell.bannerImageView.image = image;
            model.bannerImage = image;
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            
        }];
    }
    else
    {
        cell.bannerImageView.image = model.bannerImage;
    }
    
    return cell;
}
*/
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

@end
