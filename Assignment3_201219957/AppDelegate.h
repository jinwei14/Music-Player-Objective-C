/************************
  Name : jinwe.zhang
  ID : 201219957
 ************************/
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>

//implement the NSTableViewDataSource and the NSTableViewDelegate protocols.
//inorder to handle the tableview
@interface AppDelegate : NSObject <NSApplicationDelegate,
NSTableViewDataSource, NSTableViewDelegate>

//table of all the track including the track number
@property (weak) IBOutlet NSTableView *tableView;
//cover image of the album
@property (weak) IBOutlet NSImageView *coverImage;
//table of all the track the load up the tableView
@property (weak) IBOutlet NSScrollView *scrollView;
//text field errorMessage will load prompt user the Correctness of search number
@property (weak) IBOutlet NSTextField *errorMessage;
//volumeBox will show up the current volume of the music pkayer
@property (weak) IBOutlet NSTextField *volumeBox;
//titleAlbum will show up the title of album
@property (weak) IBOutlet NSTextField *titleAlbum;
//artiseName will shows up the name of the artist
@property (weak) IBOutlet NSTextField *artistName;
//the name of the current playing track
@property (weak) IBOutlet NSTextField *trackPlaying;
/*A text box allowing you to type in a track number so that youcan go directly
to that track*/
@property (weak) IBOutlet NSTextField *searchBox;
//next button to switch to the next track in the album
@property (weak) IBOutlet NSButton *nextButton;
//previous button to go to the previous track in sequence
@property (weak) IBOutlet NSButton *previousButton;
//play button to play the background music
@property (weak) IBOutlet NSButton *playButton;
//pause button to pause the background music
@property (weak) IBOutlet NSButton *pauseButton;
//search button to search the track number
@property (weak) IBOutlet NSButton *searchButton;

//A volume slider, with a display to show the current volume (range 0 to 100)
- (IBAction)changVolume:(id)sender;
//action loadAlbum to open system pane and load txt file.
- (IBAction)loadAlbum:(id)sender;
//action searchTrackNo to search the track number and select
- (IBAction)searchTrackNo:(id)sender;
//action nextTrack to switch to the next track in the album
- (IBAction)nextTrack:(id)sender;
//action previousTrack to switch to the previous track in the album
- (IBAction)previousTrack:(id)sender;
//action playMusic to play the background music
- (IBAction)playMusic:(id)sender;
//action pauseMusic to pause the background music
- (IBAction)pauseMusic:(id)sender;
/*A display which can be switched between:A numbered list of all tracks
on the album and an image of the album cover*/
- (IBAction)switchCover:(id)sender;
//action to search the track number
- (IBAction)searchTrack:(id)sender;
//check if the nsstring is digit
-(BOOL)checkDigit:(NSString*)str;

@end

