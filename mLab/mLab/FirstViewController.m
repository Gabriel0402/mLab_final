//
//  FirstViewController.m
//  mLab
//
//  Created by Chenyang  on 3/3/14.
//  Copyright (c) 2014 Chenyang . All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

static bool first=true;
@synthesize inputStream,outputStream;
@synthesize webView;
@synthesize frameNumber;
@synthesize image_obj;


- (IBAction)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}

- (void) viewDidLoad
{
    
    
    
    [self loadView];
    self.view.frame=CGRectMake(0, 200, 769, 911);
    if (first) {
       
        self.image_obj = [NSMutableArray array];
        self.images=self.image_obj;
        [self initNetworkCommunication];
        [self joinChat];
        [self sendMessage];
        first=false;
    }
    

}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"------------AAAAAAAA------------");
    
}



- (void) initNetworkCommunication {
	
	CFReadStreamRef readStream;
	CFWriteStreamRef writeStream;
	CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"158.130.105.143", 1234, &readStream, &writeStream);
	
	inputStream = (__bridge NSInputStream *)readStream;
	outputStream = (__bridge NSOutputStream *)writeStream;
	[inputStream setDelegate:self];
	[outputStream setDelegate:self];
	[inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[inputStream open];
	[outputStream open];
	
}

- (void) joinChat{
    NSString *response  = [NSString stringWithFormat:@"iam:ipad"];
	NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
	[outputStream write:[data bytes] maxLength:[data length]];
}

- (void) sendMessage{
    NSString *response  = [NSString stringWithFormat:@"msg:HELLO WORLD"];
	NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
	[outputStream write:[data bytes] maxLength:[data length]];
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
	//NSLog(@"stream event %u", streamEvent);
	
	switch (streamEvent) {
			
		case NSStreamEventOpenCompleted:
			NSLog(@"Stream opened");
			break;
		case NSStreamEventHasBytesAvailable:
            
			if (theStream == inputStream) {
				
				uint8_t buffer[1024];
				NSInteger len;
				
				while ([inputStream hasBytesAvailable]) {
					len = [inputStream read:buffer maxLength:sizeof(buffer)];
					if (len > 0) {
						
						NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
						
						if (nil != output) {
                            
							NSLog(@"server said: %@", output);
                            NSInteger output_int=[output integerValue];
                           // *frameNumber=output_int;
                            frameNumber=output_int;
                            [self showPics:output_int];
                        
						}
					}
				}
			}
			break;
            
			
		case NSStreamEventErrorOccurred:
			
			NSLog(@"Can not connect to the host!");
			break;
			
		case NSStreamEventEndEncountered:
            
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            //[theStream release];
            theStream = nil;
			
			break;
		default:
			NSLog(@"Unknown event");
	}
}

-(void) imgTouchUp:(id)sender {
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    NSLog(@"Taped Image tag is %ld", (long)gesture.view.tag);
    NSString *frameStr=[NSString stringWithFormat:@"%d",(int)frameNumber];
    frameStr=[frameStr stringByAppendingString:@".json"];
    NSString *searchURL=[@"http://158.130.12.47:3000/uploads/fullsize/" stringByAppendingString:frameStr];
    NSLog(@"url string: %@",searchURL);
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]];
    NSDictionary *json=[NSJSONSerialization JSONObjectWithData:imageData options:kNilOptions error:nil];
    NSString *myUrl= [json objectForKey:@"url"];
    NSLog(@"%@",myUrl);
    [self.view bringSubviewToFront:webView];
     NSURLRequest *myRequest =[NSURLRequest requestWithURL:[NSURL URLWithString:myUrl]];
    [webView loadRequest:myRequest];
    UIImageView *imageView = [self.imageViews objectAtIndex:gesture.view.tag];
    
    //TODO, call delegate and pass the imageView
    [self.delegate imageSelected:imageView];
}

- (void) showPics:(NSInteger) framenumber
{
    NSString *frameStr=[NSString stringWithFormat:@"%d",(int)frameNumber];
    frameStr=[frameStr stringByAppendingString:@".jpg"];
    NSString *searchURL=[@"http://158.130.12.47:3000/uploads/fullsize/" stringByAppendingString:frameStr];
    NSLog(@"url string: %@",searchURL);
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]];
    if(imageData)
    {
        [self.image_obj addObject:[UIImage imageWithData:imageData]];
    }
    self.images=self.image_obj;
    [self loadView];
    
    
}


@end
