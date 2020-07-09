//
//  AnnouncementTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-22.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnouncementTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *startLbl;
@property (weak, nonatomic) IBOutlet UILabel *endLbl;
@property (weak, nonatomic) IBOutlet UIButton *viewDetails;
@end
