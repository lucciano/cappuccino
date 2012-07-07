/*
 * AppController.j
 * TableCibTest
 *
 * Created by Francisco Tolmasky on July 5, 2009.
 * Copyright 2009, 280 North, Inc. All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "../CPTrace.j"

CPLogRegister(CPLogConsole);

@implementation AppController : CPObject
{
    CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
    iconImage = [[CPImage alloc] initWithContentsOfFile:"http://cappuccino.org/images/favicon.png" size:CGSizeMake(16,16)];
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.

    // In this case, we want the window from Cib to become our full browser window
    [theWindow setFullBridge:YES];
    CPTrace(@"CPTableView", @"_loadDataViewsInRows:columns:", traceLog);
}

- (int)numberOfRowsInTableView:(CPTableView)tableView
{
    return 100000;
}

- (id)tableView:(CPTableView)tableView objectValueForTableColumn:(CPTableColumn)tableColumn row:(int)row
{
    if ([tableColumn identifier] === "icons")
        return iconImage;
    else
        return String((row + 1) * [[tableColumn identifier] intValue]);
}

@end

var traceLog = function(a,b,c,d,e,f,g)
{
    if (this.tlr == null)
        this.tlr = 0;

    var lr = [c[0] count];
    if (d > 0)
        this.tlr += lr;

    var avg = (ROUND(100 * e/this.tlr) / 100);
    console.log(b + " " + lr + " rows in " + d + " ms ; avg/row = " + avg + " ms");
}
