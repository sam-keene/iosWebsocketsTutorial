//
//  ViewController.h
//  iOS_websocket_tutorial
//
//  Created by Sam  keene on 1/01/14.
//  Copyright (c) 2014 Sam  keene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"

@interface ViewController : UIViewController<SocketIODelegate, UIAccelerometerDelegate>
@property (nonatomic, strong) UIAccelerometer*  accelerometer;
@property (nonatomic, strong) SocketIO *socketIO;

@end
