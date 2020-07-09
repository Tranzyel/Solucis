//
//  EAccountStatementTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-08.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAccountStatementTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *docNo;
@property (weak, nonatomic) IBOutlet UILabel *transDate;
@property (weak, nonatomic) IBOutlet UILabel *inAmt;
@property (weak, nonatomic) IBOutlet UILabel *outAmt;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UILabel *remark;

//Localization
@property (weak, nonatomic) IBOutlet UILabel *docNoLoc;
@property (weak, nonatomic) IBOutlet UILabel *transDateLoc;
@property (weak, nonatomic) IBOutlet UILabel *inAmtLoc;
@property (weak, nonatomic) IBOutlet UILabel *outAmtLoc;
@property (weak, nonatomic) IBOutlet UILabel *balanceLoc;
@property (weak, nonatomic) IBOutlet UILabel *remarkLoc;

@end
