//
//  ViewController.m
//  CurrentClima
//
//  Created by Douglas Camargo on 03/04/14.
//  Copyright (c) 2014 mdlsistemas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize filePath, locationManager, labelTemperaturaAtual, labelNomeCidade, labelDataAtualizacao, imgTipoTemperatura;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Clima";
    [self startPlist];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) startPlist
{
    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,NSUserDomainMask, YES);
    NSString *documentsDirectory = [sysPaths objectAtIndex:0];
    self.filePath = [documentsDirectory stringByAppendingPathComponent:@"cidade_escolhida.plist"];
    NSMutableDictionary *plistDict;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSLog(@"Arquivo existe");
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    } else {
        NSLog(@"Arquivo Nao existe");
        plistDict = [[NSMutableDictionary alloc] init];
        [plistDict setValue:@"Rio de Janeiro" forKey:@"nome"];
        [plistDict setValue:@"-22.91" forKey:@"latitude"];
        [plistDict setValue:@"-43.18" forKey:@"longitude"];
        [plistDict setValue:@"21" forKey:@"temperatura"];
        [plistDict setValue:@"07/04/2014 18:29:35" forKey:@"data_atualizacao"];
        
        BOOL didWriteToFile = [plistDict writeToFile:filePath atomically:YES];
        if (didWriteToFile)
        {
            NSLog(@"Write to .plist file is a SUCCESS!");
        }
        else
        {
            NSLog(@"Write to .plist file is a FAILURE!");
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = locations.lastObject;
}

-(void) viewDidAppear:(BOOL)animated
{
    [self carregarDados];
}

-(void) carregarDados
{
    NSDictionary *dadosCidadeEscolhida;
    dadosCidadeEscolhida = [NSDictionary dictionaryWithContentsOfFile:filePath];
    [self.labelNomeCidade setText:[dadosCidadeEscolhida valueForKey:@"nome"]];
    [self.labelTemperaturaAtual setText:[dadosCidadeEscolhida valueForKey:@"temperatura"]];
    [self mudarImagemTemperatura:[dadosCidadeEscolhida valueForKey:@"temperatura"]];
    [self.labelDataAtualizacao setText:[self formatarData:[dadosCidadeEscolhida valueForKey:@"data_atualizacao"]]];
}

-(void) mudarImagemTemperatura:(NSString *) temperatura
{
    NSInteger temp = [temperatura intValue];
    if(temp <= 17)
    {
        [self.imgTipoTemperatura setImage:[UIImage imageNamed:@"frio"]];
    } else if (temp > 17 && temp < 27)
    {
        [self.imgTipoTemperatura setImage:[UIImage imageNamed:@"tropical"]];
    } else {
        [self.imgTipoTemperatura setImage:[UIImage imageNamed:@"quente"]];
    }
}

-(NSString *) formatarData:(NSDate *)data
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    NSString *dateNow = [dateFormat stringFromDate:data];
    return [NSString stringWithFormat:@"Última atualização em %1$@", dateNow];
}

- (IBAction)atualizarDados:(id)sender
{
    NSMutableDictionary *plistDict;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSLog(@"Arquivo existe");
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    } else {
        NSLog(@"Arquivo Nao existe");
        plistDict = [[NSMutableDictionary alloc] init];
        [plistDict setValue:@"Goiania" forKey:@"nome"];
        [plistDict setValue:@"-22.91" forKey:@"latitude"];
        [plistDict setValue:@"-43.18" forKey:@"longitude"];
        [plistDict setValue:@"27" forKey:@"temperatura"];
        [plistDict setValue:@"07/04/2014 18:29:35" forKey:@"data_atualizacao"];
        
        BOOL didWriteToFile = [plistDict writeToFile:filePath atomically:YES];
        if (didWriteToFile)
        {
            NSLog(@"Write to .plist file is a SUCCESS!");
        }
        else
        {
            NSLog(@"Write to .plist file is a FAILURE!");
        }
    }

    [self carregarDados];
}



@end
