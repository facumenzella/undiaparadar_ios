//
//  RETableViewManager+ReplaceItem.m
//  Umewin iOS
//
//  Created by Vanesa Stricker on 28/10/14.
//  Copyright (c) 2014 Monits. All rights reserved.
//

#import "RETableViewManager+ReplaceItem.h"

@implementation RETableViewManager (ReplaceItem)

- (void)replaceItem:(RETableViewItem*)oldItem withItem:(RETableViewItem*)newItem
{
    RETableViewSection *section = oldItem.section;
    NSUInteger index = [section.items indexOfObject:oldItem];
    if (index != NSNotFound) {
        [section replaceItemAtIndex:index withItem:newItem];
        
        [self.tableView reloadRowsAtIndexPaths:@[newItem.indexPath]
                              withRowAnimation:UITableViewRowAnimationNone];
    }
}

@end
