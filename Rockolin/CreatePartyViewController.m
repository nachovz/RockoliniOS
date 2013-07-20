//
//  CreatePartyViewController.m
//  Rockolin
//
//  Created by Nacho on 9/13/12.
//  Copyright (c) 2012 Rockolin. All rights reserved.
//

#import "CreatePartyViewController.h"
#import "Parse/Parse.h"
#import "StartPartyViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface CreatePartyViewController ()

@property (nonatomic, strong)PFObject *createdParty;
@property (nonatomic, strong)NSArray *songList;

@end

@implementation CreatePartyViewController
@synthesize partyName = _partyName;
@synthesize partyLocation = _partyLocation;
@synthesize qrView = _qrView;
@synthesize createdParty = _createdParty;
@synthesize songTable = _songTable;
@synthesize songList = _songList;

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
    
    self.songList = [[NSMutableArray alloc] init];
    
    //Loading Songs
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    
    NSLog(@"Logging items from a generic query...");
    //NSArray *itemsFromGenericQuery = [everything items];
    self.songList = [everything items];
    
    /*for (MPMediaItem *song in itemsFromGenericQuery) {
        NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
        NSLog (@"%@", songTitle);
    }*/
    
}

- (void)viewDidUnload
{
    [self setPartyName:nil];
    [self setPartyLocation:nil];
    [self setQrView:nil];
    [self setQrView:nil];
    [self setSongTable:nil];
    [self setSongList:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)createParty:(UIButton *)sender {
    
    if (self.createdParty) {
        [self performSegueWithIdentifier:@"Lets Party" sender:self];
    }else{
        
        [self.partyName resignFirstResponder];
        [self.partyLocation resignFirstResponder];
        
        PFUser *currentUser = [PFUser currentUser];
        
        PFObject *newParty = [PFObject objectWithClassName:@"party"];
        [newParty setObject:currentUser forKey:@"user"];
        [newParty setObject:self.partyName.text forKey:@"name"];
        [newParty setObject:self.partyLocation.text forKey:@"address"];
        [newParty save];
    
        //NSString *code = newParty.objectId;
    
        /*Barcode *barcode = [[Barcode alloc] init];
    
        [barcode setupQRCode:code];
        [self.qrView setImage:barcode.qRBarcode];*/
    
        [self setCreatedParty:newParty];
        
        [sender setTitle:@"Lets Party!" forState:UIControlStateNormal];
        
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setParty:self.createdParty];
}


//TABLE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.songList count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Configure the cell
    UITableViewCell *cell;
    
    //if ([self.songList count]>0) {
            
            static NSString *CellIdentifier = @"SongCell";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    MPMediaItem *song = [self.songList objectAtIndex: indexPath.row];
    NSString *songTitle = [song valueForProperty:MPMediaItemPropertyTitle];
    
    cell.textLabel.text = songTitle;//(NSString *)[(MPMediaItem *)[self.songList objectAtIndex: indexPath.row] valueForProperty: MPMediaItemPropertyTitle];
            //BACKGROUND
            /*cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"cell%d.png",indexPath.row%4]]];
            
            //INFO - NAME
            if (!((Game *) [self.games objectAtIndex:indexPath.row]).opponent.fbUsername) {
                ( (UILabel *)[cell viewWithTag:1]).text = ((Game *) [self.games objectAtIndex:indexPath.row]).opponent.username;
            }else{
                ( (UILabel *)[cell viewWithTag:1]).text = ((Game *) [self.games objectAtIndex:indexPath.row]).opponent.fbUsername;
            }
            
            //INFO - SET OPPONENT SCORE
            ((UILabel *)[cell viewWithTag:2]).text = [NSString stringWithFormat:@"%@", ((Game *) [self.games objectAtIndex:indexPath.row]).opponent.score];
            
            //INFO - SET TURN LABEL
            /*if ([((Game *) [self.games objectAtIndex:indexPath.row]).turnLabel intValue] < 1) {
             ((UILabel *)[cell viewWithTag:5]).text =@"Their Turn";
             }else{
             ((UILabel *)[cell viewWithTag:5]).text =@"Your Turn";
             }*/
            
            /*if ([((Game *) [self.games objectAtIndex:indexPath.row]).turnLabel intValue] < 1) {
                ((UIImageView *)[cell viewWithTag:4]).image = [UIImage imageNamed:@"icon_theirturn.png"];
            }else{
                ((UIImageView *)[cell viewWithTag:4]).image = [UIImage imageNamed:@"icon_yourturn.png"];
            }
            
            //INFO - SET OPPONENT PHOTO
            if (((Game *) [self.games objectAtIndex:indexPath.row]).opponent.fbid) {
                
                NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=53&height=53", ((Game *) [self.games objectAtIndex:indexPath.row]).opponent.fbid];
                
                NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                
                //get a dispatch queue
                dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                //this will start the image loading in bg
                dispatch_async(concurrentQueue, ^{
                    NSData *image = [[NSData alloc] initWithContentsOfURL:url];
                    
                    //this will set the image when loading is finished
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //imageView.image = [UIImage imageWithData:image];
                        
                        //NSData *data = [NSData dataWithContentsOfURL:url];
                        ((UIImageView *)[cell viewWithTag:3]).image = [UIImage imageWithData:image];
                        dispatch_release(concurrentQueue);
                    });
                });
                
                /*NSData *data = [NSData dataWithContentsOfURL:url];
                 ((UIImageView *)[cell viewWithTag:3]).image = [UIImage imageWithData:data];*/
            /*}else{
                ((UIImageView *)[cell viewWithTag:3]).image = [UIImage imageNamed:@"player_notfound.png"];
            }*/
    /*}else{
        static NSString *CellIdentifier = @"New";
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }*/
    
    return cell;

}


@end
