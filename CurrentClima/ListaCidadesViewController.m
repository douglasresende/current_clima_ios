//
//  listaCidadesViewController.m
//  CurrentClima
//
//  Created by Douglas Camargo on 03/04/14.
//  Copyright (c) 2014 mdlsistemas. All rights reserved.
//

#import "ListaCidadesViewController.h"
#define TAG_NOME_CIDADE 1

@interface ListaCidadesViewController ()

@end

@implementation ListaCidadesViewController

@synthesize arrayDeCidades;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self popularCidades];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) popularCidades
{
    arrayDeCidades = [NSArray arrayWithContentsOfFile:[
                                                       [NSBundle mainBundle] pathForResource:@"cidades" ofType:@"plist"]
                      ];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayDeCidades.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"listaCidades"];
    
    UILabel *labelNome = (UILabel *) [myCell viewWithTag:TAG_NOME_CIDADE];
    NSDictionary *cidade = [arrayDeCidades objectAtIndex:[indexPath row]];
    labelNome.text = [cidade valueForKey:@"nome"];
    return myCell;
}


//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
