//
//  PersonalSalesHistoryTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-08.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalSalesHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *docNo;
@property (weak, nonatomic) IBOutlet UILabel *submittedDate;
@property (weak, nonatomic) IBOutlet UILabel *pv;
@property (weak, nonatomic) IBOutlet UILabel *sdoNo;
@property (weak, nonatomic) IBOutlet UILabel *consignmentNo;
@property (weak, nonatomic) IBOutlet UILabel *consignmentDate;

@end