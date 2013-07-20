//
//  CreatePartyViewController.h
//  Rockolin
//
//  Created by Nacho on 9/13/12.
//  Copyright (c) 2012 Rockolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatePartyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *partyName;
@property (weak, nonatomic) IBOutlet UITextField *partyLocation;
@property (retain, nonatomic) IBOutlet UITableView *songTable;

- (IBAction)createParty:(UIButton *)sender;

@end
