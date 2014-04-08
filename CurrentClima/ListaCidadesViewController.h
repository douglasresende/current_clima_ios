//
//  listaCidadesViewController.h
//  CurrentClima
//
//  Created by Douglas Camargo on 03/04/14.
//  Copyright (c) 2014 mdlsistemas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaCidadesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSArray *arrayDeCidades;
@end
