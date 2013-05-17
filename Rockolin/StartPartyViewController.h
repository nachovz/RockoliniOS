//
//  StartPartyViewController.h
//  Rockolin
//
//  Created by Nacho on 9/13/12.
//  Copyright (c) 2012 Rockolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface StartPartyViewController : UIViewController

@property (nonatomic, strong)PFObject *party;
@property (weak, nonatomic) IBOutlet UILabel *partyTitle;
@property (retain, nonatomic) IBOutlet UIImageView *qrView;
@end
