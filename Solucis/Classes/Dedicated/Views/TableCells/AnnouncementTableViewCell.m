//
//  AnnouncementTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-22.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "AnnouncementTableViewCell.h"

#define CELL_OFFSET 10.0

@interface AnnouncementTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLoc;
@property (weak, nonatomic) IBOutlet UILabel *dateLoc;
@property (weak, nonatomic) IBOutlet UIButton *viewDetailsButton;

@end


@implementation AnnouncementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLoc.text = NSLocalizedString(@"announcement_title", "");
    self.dateLoc.text = NSLocalizedString(@"announcement_date", "");
    [self.viewDetailsButton setTitle:NSLocalizedString(@"announcement_view_details", "") forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.size.width -= CELL_OFFSET * 2;
    contentViewFrame.size.height -= CELL_OFFSET * 2;
    
    contentViewFrame.origin.x += CELL_OFFSET;
    contentViewFrame.origin.y += CELL_OFFSET;
    
    self.contentView.frame = contentViewFrame;
}

@end
