//
//  PartyViewController.h
//  Rockolin
//
//  Created by Nacho on 9/12/12.
//  Copyright (c) 2012 Rockolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *loginLogoutButton;
@property (weak, nonatomic) IBOutlet UILabel *userName;
- (IBAction)createParty:(id)sender;
- (IBAction)launchParty:(id)sender;
- (IBAction)joinParty:(id)sender;
- (IBAction)loginLogout:(id)sender;


@end
