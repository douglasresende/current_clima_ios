//
//  ViewController.h
//  CurrentClima
//
//  Created by Douglas Camargo on 03/04/14.
//  Copyright (c) 2014 mdlsistemas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocation *currentLocation;
}
@property (nonatomic, retain) NSString *filePath;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) IBOutlet UILabel *labelNomeCidade;
@property (nonatomic, retain) IBOutlet UILabel *labelTemperaturaAtual;
@property (weak, nonatomic) IBOutlet UIImageView *imgTipoTemperatura;
@property (weak, nonatomic) IBOutlet UILabel *labelDataAtualizacao;
@end
