/************************
 Name : jinwe.zhang
 ID : 201219957
 ************************/
#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate{
    //audio player for background music
    AVAudioPlayer* audioPlayer;
    //list of track to store name of album artst name and all track
    NSMutableArray* trackList;
    NSOpenPanel *panel;
    //index of the trackList
    int playNo;
}

//execute when application finish launching
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //set up the background music path
    NSString* music = [[NSBundle mainBundle]pathForResource:
                     @"Rock-drum" ofType:@"wav"];
    //initialise the audio player
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                 [NSURL fileURLWithPath:music] error:NULL];
    audioPlayer.delegate = (id)self;
    //loop infinitely
    audioPlayer.numberOfLoops = -1;
    //initialize the array of track
    trackList = [[NSMutableArray alloc]init];
    
    //disable the these button at the beginning
    [self.nextButton setEnabled:false];
    [self.searchBox setEnabled:false];
    [self.previousButton setEnabled:false];
    [self.nextButton setEnabled:false];
    [self.playButton setEnabled:false];
    [self.searchButton setEnabled:false];
    //set play button on the top of the pause button.
    [self.pauseButton setHidden:true];
    [self.playButton setHidden:false];
    //set the table visable
    [self.scrollView setHidden: false];
    [self.coverImage setHidden: true];
}

//execute when application finish launching
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    NSLog(@"Thank you for using jinwei Music Player 😀😀😀😀😀");
}

//terminate the application when close button is clicked
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:
(NSApplication *)theApplication {
    return YES;
}

//action to change the volume by slide the NSSlider
- (IBAction)changVolume:(id)sender {
    NSSlider* slider = (NSSlider*) sender;
    NSString* volume;
    
    //get the volume as a NSString variable
    volume = [NSString stringWithFormat:@"%d"
            ,slider.intValue];
    //set the volumeBox display the volume
    [self.volumeBox setStringValue:volume];
    
}

//action that open a system pane and load txt file.
- (IBAction)loadAlbum:(NSButton *)sender {
    //To allow the user to select a file, declare panel and disable
    //muti-selection
    panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:NO];
    //only allow .txt file be selected
    [panel setAllowedFileTypes:[NSArray arrayWithObject:@"txt"]];
    
    //and check to see if the OK button has been pressed
    //(as opposed to the cancel button):
    if ([panel runModal] == NSFileHandlingPanelOKButton) {
        //set these button enable
        [self.nextButton setEnabled:true];
        [self.previousButton setEnabled:true];
        [self.playButton setEnabled:true];
        [self.searchBox setEnabled:true];
        [self.playButton setEnabled:true];
        [self.searchButton setEnabled:true];
        
        //get the selected filename in the form of a URL
        NSURL *albumURL = [panel URL];
        //convert contents of that file to a string
        NSString *info = [NSString stringWithContentsOfURL:
                          albumURL encoding: NSASCIIStringEncoding error: NULL];
        //put text on trackList
        trackList = (NSMutableArray*)[info componentsSeparatedByString:@"\n"];
        //if there is no neline at the ending of file
        if([trackList[[trackList count]-1] isNotEqualTo:@""]){
            trackList[[trackList count]] = @"";
            NSLog(@"adding empty string to the end");
        }
        //load album cover image
        NSURL * imageURL = [albumURL URLByAppendingPathExtension:@"jpg"];
        NSImage *cover = [[NSImage alloc] initWithContentsOfURL: imageURL];
        //set the image to the imageView
        [self.coverImage setImage:cover];
        
        //invoke tableView method to load contant into tableView.
        [self.tableView reloadData];
        //put the first as the playing music
        playNo = 2;
        [self.previousButton setEnabled:false];
        [self.trackPlaying setStringValue:trackList[playNo]];
        [self.titleAlbum setStringValue:trackList[0]];
        [self.artistName setStringValue:trackList[1]];
        //set the selected track to be the first track
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:playNo-2];
        [self.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
    }
}
//check if the search number is 
-(BOOL)checkDigit:(NSString*)str{

    NSCharacterSet* notDigits =
    [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([str rangeOfCharacterFromSet:notDigits].location == NSNotFound){
        //newString consists only digits
        return true;
    }else{
        return false;
    }

}
//search action allowing you to type in a track number so that you can
//go directly to that track
- (IBAction)searchTrack:(id)sender {
    int x = [self.searchBox.stringValue intValue];
    BOOL flag= [self checkDigit:self.searchBox.stringValue];
    
    //judge if the searchNumber is a number between 1 and size of trackList - 3
    if(x >= 1 && x<= [trackList count]-3 && flag == true){
        playNo = x+1;
        [self.trackPlaying setStringValue:trackList[playNo]];
        [self.errorMessage setStringValue:@""];
        //index of row
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:playNo-2];
        //select the corrisponding row in the tableView
        [self.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
        [self.tableView scrollRowToVisible:playNo-2];
        //set button enable after searching
        if(x == 1){
            [self.nextButton setEnabled:true];
            [self.previousButton setEnabled:false];
        }else if(x == [trackList count]-3){
            [self.nextButton setEnabled:false];
            [self.previousButton setEnabled:true];
        }else{
            [self.nextButton setEnabled:true];
            [self.previousButton setEnabled:true];
        }
    }else{
        //prompt user track number is not right
        [self.errorMessage setStringValue:@"Wrong Track Nunmber"];
    }
    
}

//search action by clicking the search button
- (IBAction)searchTrackNo:(id)sender {
    int x = [self.searchBox.stringValue intValue];
    BOOL flag= [self checkDigit:self.searchBox.stringValue];
    
    //judge if the searchNumber is a number between 1 and size of trackList - 3
    if(x >= 1 && x<= [trackList count]-3 && flag == true){
        playNo = x+1;
        [self.trackPlaying setStringValue:trackList[playNo]];
        [self.errorMessage setStringValue:@""];
        //index of row
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:playNo-2];
        //select the corrisponding row in the tableView
        [self.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
        [self.tableView scrollRowToVisible:playNo-2];
        //set button enable after searching
        if(x == 1){
            [self.nextButton setEnabled:true];
            [self.previousButton setEnabled:false];
        }else if(x == [trackList count]-3){
            [self.nextButton setEnabled:false];
            [self.previousButton setEnabled:true];
        }else{
            [self.nextButton setEnabled:true];
            [self.previousButton setEnabled:true];
        }
    }else{
        //prompt user track number is not right
        [self.errorMessage setStringValue:@"Wrong Track Nunmber"];
    }
}

//action next to go to the next track in sequence
- (IBAction)nextTrack:(id)sender {
    //set previousButton to be enable again
    [self.previousButton setEnabled:true];
    //judge if the playNo is with in range
    if(playNo < [trackList count]-2 && playNo >= 2){
        playNo++;
        //set the text in trackPlaying testField and select in tableView
        [self.trackPlaying setStringValue:trackList[playNo]];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:playNo-2];
        [self.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
        [self.tableView scrollRowToVisible:playNo-2];
        if(playNo == [trackList count] - 2){
            //if the last track is selected
            [self.nextButton setEnabled:false];
        }
    }
}

//action to go to the previous track in sequence
- (IBAction)previousTrack:(id)sender {
    //set nextButton to be enable again
    [self.nextButton setEnabled:true];
    //judge if the playNo is with in range
    if(playNo <= [trackList count] && playNo>2){
        
        playNo--;
        //set the text in trackPlaying testField and select in tableView
        [self.trackPlaying setStringValue:trackList[playNo]];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:playNo-2];
        [self.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
        [self.tableView scrollRowToVisible:playNo-2];
        if(playNo == 2){
            //if the first track is selected
            [self.previousButton setEnabled:false];
        }
    }
}

//action of playing the music
- (IBAction)playMusic:(id)sender {
    //play the music and set pause button visable
    [audioPlayer play];
    [self.playButton setHidden:true];
    [self.pauseButton setHidden:false];
}

//action of pausing the music
- (IBAction)pauseMusic:(id)sender {
    //pause the music and set play button visable
    [audioPlayer pause];
    [self.pauseButton setHidden:true];
    [self.playButton setHidden:false];
    
}

//switched between a numbered list of all tracks on the album and
//an image of the album cover
- (IBAction)switchCover:(id)sender {
    [self.coverImage setHidden:![self.coverImage isHidden]];
    [self.scrollView setHidden:![self.scrollView isHidden]];
}

//nib-loading infrastructure define double click action.
-(void)awakeFromNib{
    
    [self.tableView setDoubleAction:@selector(doubleClick)];
}

//action of double click the tableView
-(void)doubleClick{
    NSInteger index = [self.tableView selectedRow];
    
    //judge if the clicked index is within boundary
    if(index >= 0 && index <= [trackList count]-4){
        //list index= table index+2
        playNo=(int)index+2;
        
        //set the trackPlaying textField as the clicked track name
        [self.trackPlaying setStringValue:trackList[playNo]];
        //(last one in .txt file is a space)
        if(playNo == [trackList count]-2){
            //last song
            [self.nextButton setEnabled:false];
            [self.previousButton setEnabled:true];
        }else if(playNo == 2){
            //first song
            [self.previousButton setEnabled:false];
            [self.nextButton setEnabled:true];
        }else{
            [self.nextButton setEnabled:true];
            [self.previousButton setEnabled:true];
        }
        //play the audio if valid row of track is clicked
        [audioPlayer play];
        [self.playButton setHidden:true];
        [self.pauseButton setHidden:false];
    }
    
}

//telling the table view how many rows you have
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return  [trackList count];
}

//method that returns the data displayed in each column cell
-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSString* identifier = [tableColumn identifier];
    
    //check if
    if(row<[trackList count]-3){
        if([identifier isEqualToString:@"number"]){
            //return the row index of the table
            NSString *inStr = [NSString stringWithFormat: @"%ld", (long)(row+1)];
            
            return inStr;
        }else {
            //return the content of the trackList
            return trackList[row+2];
        }
    }
    return nil;
}

@end
