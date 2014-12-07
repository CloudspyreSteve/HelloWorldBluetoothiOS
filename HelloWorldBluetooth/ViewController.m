//
//  ViewController.m
//  SerialConsole
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize ble;

//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

- (void)viewDidLoad
{
    ble = [[BLE alloc] init];
    [ble controlSetup:1];
    ble.delegate = self;
    
    btnOnOff.enabled = NO;
    
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Actions

// Connect button will call to this
- (IBAction)btnScanForPeripherals:(id)sender
{
    if (ble.activePeripheral)
        if(ble.activePeripheral.isConnected)
        {
            [[ble CM] cancelPeripheralConnection:[ble activePeripheral]];
            [btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
            return;
        }
    
    if (ble.peripherals)
        ble.peripherals = nil;
    
    [btnConnect setEnabled:false];
    [ble findBLEPeripherals:2];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    
}

-(void) connectionTimer:(NSTimer *)timer
{
    [btnConnect setEnabled:true];
//    lblText.text = @"Disconnect";
    
    if (ble.peripherals.count > 0)
    {
        [ble connectPeripheral:[ble.peripherals objectAtIndex:0]];
    }
    else
    {
//        lblText.text = @"Connect";
    }
}

- (IBAction)onPressed:(id)sender
{
    UInt8 buf[1];
    if ([lblText.text isEqualToString:@"On"]) {
        lblText.text = @"Off";
        buf[0] = 0x04;
    }
    else {
        lblText.text = @"On";
        buf[0] = 0x03;
    }
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [ble write:data];
}


#pragma mark - BLE delegate

- (void)bleDidDisconnect
{
    NSLog(@"->Disconnected");
  
    lblText.text = @"Connect";
//    [btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
    
    btnOnOff.enabled = false;
    
}

// When RSSI is changed, this will be called
-(void) bleDidUpdateRSSI:(NSNumber *) rssi
{
}

// When connected, this will be called
-(void) bleDidConnect
{
    NSLog(@"->Connected");
    
    btnOnOff.enabled = true;
    lblText.text = @"Disconnect";
    
}

// When data is comming, this will be called
-(void) bleDidReceiveData:(unsigned char *)data length:(int)length
{
}


@end
