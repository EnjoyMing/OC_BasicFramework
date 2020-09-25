//
//  SNCustomBaseVC.h
//  objective-c
//
//  Created by silence on 2020/9/22.
//  Copyright © 2020 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNNodataView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SNCustomBaseVC : UIViewController
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) SNNodataView * noDataView;
@end

NS_ASSUME_NONNULL_END
