//
//  ViewController.m
//  json Tutorial
//
//  Created by Walter Gonzalez Domenzain on 17/03/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "ViewController.h"
#import "SBJson.h"
#import "cellStudents.h"

NSString        *dataPost;
NSDictionary    *jsonResponse;
NSMutableArray  *aStudentName;
NSMutableArray  *aID;
NSMutableArray  *aApellido;
NSMutableArray  *aEdad;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self postService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*******************************************************************************
 Web Service
 *******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postService
{
    NSLog(@"postService");
    NSOperationQueue *queue             = [NSOperationQueue new];
    NSInvocationOperation *operation    = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadService) object:nil];
    [queue addOperation:operation];
}
//-------------------------------------------------------------------------------
- (void) loadService
{
    @try
    {
        NSString *post = [[NSString alloc] initWithFormat:@"id=%@", dataPost];
        NSLog(@"postService: %@",post);
        NSURL *url = [NSURL URLWithString:@"http://dev.dvlop.mx/humberto/"];
        NSLog(@"URL postService = %@", url);
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        [NSURLRequest requestWithURL:url];
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//-------------------------------------------------------------------------------
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            jsonResponse = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
        }
        else
        {
            if (error)
            {
                NSLog(@"Error");
                
            }
            else
            {
                NSLog(@"Conect Fail");
            }
        }
//-------------------------------------------------------------------------------
    }
    @catch (NSException * e)
    {
        NSLog(@"Exception");
    }
//-------------------------------------------------------------------------------
    NSLog(@"jsonResponse %@", jsonResponse);
    aID        = [jsonResponse valueForKey:@"id"];
    aStudentName        = [jsonResponse valueForKey:@"nombre"];
    aApellido       = [jsonResponse valueForKey:@"apellidos"];
    aEdad        = [jsonResponse valueForKey:@"edad"];
    
    //NSLog(@"aStudentName %@", aStudentName);
    [self.tblStudents reloadData];
}

/***********************************************************************************************
 Table Functions
 **********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return aStudentName.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellStudents");
    static NSString *CellIdentifier = @"cellStudents";
    
    cellStudents *cell = (cellStudents *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"cellStudents" bundle:nil] forCellReuseIdentifier:@"cellStudents"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellStudents"];
    }
    
    cell.selectionStyle     = UITableViewCellSelectionStyleNone;
    cell.lblID.text         =aID[indexPath.row];
    cell.lblName.text       =aStudentName[indexPath.row];
    cell.lblApellidos.text  =aApellido[indexPath.row];
    cell.lblEdad.text       =aEdad[indexPath.row];
    
    return cell;
}
//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (IBAction)btnPresRefresh:(id)sender {
    [self postService];
    [self.tblStudents reloadData];
}


@end
