//
//  ViewController.h
//  SerialConsole
//
//

#import <UIKit/UIKit.h>
#import "BLE.h"

#define BUFFER_LEN 1024

@interface ViewController : UIViewController <BLEDelegate> {

    IBOutlet UIButton *btnConnect;
    IBOutlet UIButton *btnOnOff;
    IBOutlet UILabel *lblText;

}

@property (strong, nonatomic) BLE *ble;

- (IBAction)btnScanForPeripherals:(id)sender;
- (IBAction)onPressed:(id)sender;

@end
