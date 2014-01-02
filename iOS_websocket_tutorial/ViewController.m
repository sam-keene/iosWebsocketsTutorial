//
//  ViewController.m
//  iOS_websocket_tutorial
//
//  Created by Sam  keene on 1/01/14.
//  Copyright (c) 2014 Sam  keene. All rights reserved.
//

#import "ViewController.h"

#define kAccelerometerFrequency        50.0 //Hz
#define kNodeJSServer                   @"MY_SERVER_NAME.nodejitsu.com" // insert your server name here without http://

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.socketIO = [[SocketIO alloc] initWithDelegate:self];
    
    // socketIO.useSecure = NO;
    [self.socketIO connectToHost:kNodeJSServer onPort:80];
    
    [self configureAccelerometer];
}

-(void)configureAccelerometer
{
    self.accelerometer = [UIAccelerometer sharedAccelerometer];
    self.accelerometer.updateInterval = 1 / kAccelerometerFrequency;
    self.accelerometer.delegate = self;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    UIAccelerationValue x, y, z;
    x = acceleration.x;
    y = acceleration.y;
    z = acceleration.z;
    
    // NSLog(@"x : %f", x);
    // NSLog(@"y : %f", y);
    // NSLog(@"z : %f", z);
    
    [self.socketIO sendMessage:[NSString stringWithFormat:@"x:%f, y:%f, z:%f", x, y, z] withAcknowledge:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.socketIO.delegate = nil;
    [self.socketIO disconnect];
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    SocketIOCallback cb = ^(id argsData) {
        NSDictionary *response = argsData;
        // do something with response
        NSLog(@"packet arrived: %@", response);
    };
    [self.socketIO sendMessage:@"hello back!" withAcknowledge:cb];
}

- (void) socketIO:(SocketIO *)socket failedToConnectWithError:(NSError *)error
{
    NSLog(@"failedToConnectWithError() %@", error);
}


@end
