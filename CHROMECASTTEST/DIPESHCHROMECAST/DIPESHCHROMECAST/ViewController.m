//
//  ViewController.m
//  DIPESHCHROMECAST
//
//  Created by Dipesh Pokhrel on 04/09/18.
//  Copyright © 2018 Dipesh Pokhrel. All rights reserved.
//

#import "ViewController.h"
#import <GoogleCast/GoogleCast.h>

#import "AppDelegate.h"

#define LIVE_VIDEO_URL @"https://wowzaprod134-i.akamaihd.net/hls/live/577814/ccddaf02/playlist.m3u8"

#define CHROMECAST_PRODUCTION_IMAGE_URL @"http://production.web.mcg.demandware.net/on/demandware.static/-/Sites-jtv-Library/default/mobile/apps/chrome-cast.png"
#define CHROMECAST_STAGING_IMAGE_URL @"http://staging.web.mcg.demandware.net/on/demandware.static/-/Sites-jtv-Library/default/mobile/apps/chrome-cast.png"

NSString *siteAPIURL =  @"https://www.jtv.com";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUPMedia];
 
    GCKUICastButton  *castButtonGCK =
    [[GCKUICastButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-15 , 44)];
    [castButtonGCK setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
 
    castButtonGCK.tintColor = [UIColor blueColor];
    [castButtonGCK setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    castButtonGCK.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    castButtonGCK.hidden = NO;
  
    [self.view addSubview:castButtonGCK];
}

-(void)setUPMedia
{

    GCKMediaMetadata *metadata = [[GCKMediaMetadata alloc] initWithMetadataType:GCKMediaMetadataTypeTVShow];
    [metadata setString:@"Hello" forKey:kGCKMetadataKeyTitle];
    
    [metadata setString:@"Subtitle" forKey:@"description"];
    [metadata setString: @"Hello moto" forKey:kGCKMetadataKeyStudio];
    
    [metadata addImage:[[GCKImage alloc] initWithURL:[NSURL URLWithString:CHROMECAST_STAGING_IMAGE_URL]
                                               width:320
                                              height:480]];

    [metadata addImage:[[GCKImage alloc] initWithURL:[NSURL URLWithString:CHROMECAST_PRODUCTION_IMAGE_URL]
                                                   width:320
                                                  height:480]];
    
    NSURL *url = [NSURL URLWithString:@"https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/mp4/GoogleIO-2014-CastingToTheFuture.mp4"];
    GCKMediaInformation *mediaInfo = [[GCKMediaInformation alloc]
                                      initWithContentID:[url absoluteString]
                                      streamType:GCKMediaStreamTypeBuffered
                                      contentType:@"video/mp4"
                                      metadata:metadata
                                      streamDuration:0
                                      mediaTracks:nil
                                      textTrackStyle:nil
                                      customData:nil];
    
    GCKCastSession *session =
    [GCKCastContext sharedInstance].sessionManager.currentCastSession;
    if (session) {
        GCKMediaLoadOptions *options = [[GCKMediaLoadOptions alloc]init];
        options.autoplay = YES;
        [session.remoteMediaClient loadMedia:mediaInfo withOptions:options];
    }
    
  
}


- (void)playSelectedItemRemotely {
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    if (appDelegate.castControlBarsEnabled) {
        appDelegate.castControlBarsEnabled = NO;
    }
    [[GCKCastContext sharedInstance] presentDefaultExpandedMediaControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
