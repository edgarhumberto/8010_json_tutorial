//
//  cellStudents.h
//  json Tutorial
//
//  Created by Carolina Lopez on 17/03/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cellStudents : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblID;
@property (weak, nonatomic) IBOutlet UILabel *lblApellidos;
@property (weak, nonatomic) IBOutlet UILabel *lblEdad;

@end
