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
#import <AVFoundation/AVFoundation.h>

@interface CreatePartyViewController ()

@property (nonatomic, strong)PFObject *createdParty;
@property (nonatomic, strong)NSArray *songList;
@property (strong, nonatomic) AVPlayer *audioPlayer;

@end

@implementation CreatePartyViewController
@synthesize partyName = _partyName;
@synthesize partyLocation = _partyLocation;
@synthesize createdParty = _createdParty;
@synthesize songTable = _songTable;
@synthesize songList = _songList;
@synthesize audioPlayer = _audioPlayer;

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
    self.audioPlayer = [[AVPlayer alloc] init];
    
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
    static NSString *CellIdentifier = @"SongCell";
            
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = (NSString *)[(MPMediaItem *)[self.songList objectAtIndex: indexPath.row] valueForProperty: MPMediaItemPropertyTitle];
    cell.detailTextLabel.text = (NSString *)[(MPMediaItem *)[self.songList objectAtIndex: indexPath.row] valueForProperty: MPMediaItemPropertyArtist];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPMediaItemCollection *songs = [self.songList objectAtIndex:indexPath.row];
    MPMediaItem *song = [songs representativeItem];
    
    AVPlayerItem * currentItem = [AVPlayerItem playerItemWithURL:[song valueForProperty:MPMediaItemPropertyAssetURL]];
    [self.audioPlayer replaceCurrentItemWithPlayerItem:currentItem];
    [self.audioPlayer play];
    //MPMusicPlayerController *appPlayer = [MPMusicPlayerController iPodMusicPlayer];
}

@end
