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
    dadosCidadeEscolhida = [NSDictionary dictionaryWithContentsOfFile:[
                                                       [NSBundle mainBundle] pathForResource:@"cidade_escolhida" ofType:@"plist"]
                      ];
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
    NSMutableDictionary *novosDados;
    [novosDados setObject:@"Rio de Janeiro" forKey:@"nome"];
    if([novosDados writeToFile:[[NSBundle mainBundle] pathForResource:@"cidade_escolhida2" ofType:@"plist"] atomically:YES])
    {
        NSLog(@"Gravou");
    } else {
        NSLog(@"Nao gravou =(");
    }
    NSLog(@"%@", [[NSBundle mainBundle] pathForResource:@"cidade_escolhida2" ofType:@"plist"]);
    
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:@"cidade_escolhida2"];
    [plistDict setObject:@"Rio de Janeiro" forKey:@"nome"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@", paths);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@", documentsDirectory);
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"cidade_escolhida2.plist"];
    NSLog(@"%@", filePath);
    
    NSString* plistPath = nil;
    NSFileManager* manager = [NSFileManager defaultManager];
    if ((plistPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"cidade_escolhida2.plist"]))
    {
        if ([manager isWritableFileAtPath:plistPath])
        {
            NSMutableDictionary* infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
            [infoDict setObject:@"blaaa" forKey:@"nome"];
            [infoDict writeToFile:plistPath atomically:YES];
            [manager setAttributes:[NSDictionary dictionaryWithObject:[NSDate date] forKey:NSFileModificationDate] ofItemAtPath:[[NSBundle mainBundle] bundlePath] error:nil];
        }
    }
    
    
//    ------------------------------
    
    
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    path = [path stringByAppendingPathComponent:@"cidade_escolhida2.plist"];
    
//    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    destPath = [destPath stringByAppendingPathComponent:@"cidade_escolhida2.plist"];
//    
//    // If the file doesn't exist in the Documents Folder, copy it.
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    if (![fileManager fileExistsAtPath:destPath]) {
//        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"cidade_escolhida2" ofType:@"plist"];
//        [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
//    }
    
    
//    - (void) rwDataToPlist:(NSString *)fileName playerColor:(NSString *)strPlayer withData:(NSArray *)data
    
    // Step1: Get plist file path
    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,NSUserDomainMask, YES);
    NSString *documentsDirectory2 = [sysPaths objectAtIndex:0];
    NSString *filePath2 = [documentsDirectory2 stringByAppendingPathComponent:@"cidade_escolhida.plist"];
    NSMutableDictionary *plistDict2;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath2])
    {
        NSLog(@"Arquivo existe");
        plistDict2 = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath2];
    } else {
        NSLog(@"Arquivo Nao existe");
        plistDict2 = [[NSMutableDictionary alloc] init];
        [plistDict2 setValue:@"Rio de Janeiro" forKey:@"nome"];
        
        BOOL didWriteToFile = [plistDict2 writeToFile:filePath2 atomically:YES];
        if (didWriteToFile)
        {
            NSLog(@"Write to .plist file is a SUCCESS!");
        }
        else
        {
            NSLog(@"Write to .plist file is a FAILURE!");
        }
    }

    NSDictionary *listaCidades;
    listaCidades = [NSDictionary dictionaryWithContentsOfFile:[
                                                               [NSBundle mainBundle] pathForResource:@"cidade_escolhida" ofType:@"plist"]];
//    NSLog(@"%@", [listaCidades valueForKey:@"nome"]);
    NSLog(@"%@", [listaCidades description]);
    
}



@end
