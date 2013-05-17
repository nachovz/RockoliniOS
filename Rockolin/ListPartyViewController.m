//
//  ListPartyViewController.m
//  Rockolin
//
//  Created by Nacho on 9/13/12.
//  Copyright (c) 2012 Rockolin. All rights reserved.
//

#import "ListPartyViewController.h"

@interface ListPartyViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ListPartyViewController
@synthesize partiesList = _partiesList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPartiesList:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
