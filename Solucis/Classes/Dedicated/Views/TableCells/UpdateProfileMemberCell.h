//
//  UpdateProfileMemberCell.h
//  Solucis
//
//  Created by Lam Si Mon on 18-07-22.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateProfileMemberCellDelegate;

@interface UpdateProfileMemberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *memberCodeLbl;
@property (weak, nonatomic) IBOutlet UILabel *memberNameLbl;
@property (weak, nonatomic) IBOutlet UITextField *memberIC;
@property (nonatomic, strong) id <UpdateProfileMemberCellDelegate> delegate;
@end

@protocol UpdateProfileMemberCellDelegate<NSObject>
- (void)memberICDidFinishEditing:(NSString *)text cell:(UpdateProfileMemberCell *)cell;
@end


