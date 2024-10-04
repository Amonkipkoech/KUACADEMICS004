report 65320 "Dash-Customer & Item Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Dash-Customer & Item Reports.rdl';
    EnableExternalImages = true;
    EnableHyperlinks = true;

    dataset
    {
        dataitem(DataItem1000000000; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));
            column(TopXCustomers; TopXCustomers)
            {
            }
            column(TopXItems; TopXItems)
            {
            }
        }
        dataitem(DataItem1000000003; 18)
        {
            column(No_Customer; "No.")
            {
            }
            column(Name_Customer; Name)
            {
                IncludeCaption = true;
            }
            column(Sales_Customer; "Sales (LCY)")
            {
            }
            column(Profit_Customer; "Profit (LCY)")
            {
            }
        }
        dataitem(DataItem1000000008; 27)
        {
            PrintOnlyIfDetail = true;
            column(No_Item; "No.")
            {
            }
            column(Description_Item; Description)
            {
                IncludeCaption = true;
            }
            column(ReorderPoint_Item; "Reorder Point")
            {
            }
            column(Purchases_Item; "Purchases (LCY)")
            {
            }
            column(Sales_Item; "Sales (LCY)")
            {
            }
            dataitem(DataItem1000000014; 32)
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = WHERE(Quantity = FILTER(<> 0),
                                          "Location Code" = FILTER(<> ''));
                column(Location_ItemLedgerEntry; "Location Code")
                {
                    IncludeCaption = true;
                }
                column(Quantiry_ItemLedgerEntry; Quantity)
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(TopXCustomers; TopXCustomers)
                    {
                        Caption = 'Top X Customers';
                        ApplicationArea = All;
                    }
                    field(TopXItems; TopXItems)
                    {
                        Caption = 'Top X Items';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        TopX = 'Top X:';
        Customers = 'Customers';
        Items = 'Items';
        ItemInventory = 'Item Inventory';
        ReportTitle = 'Dashboard Report';
    }

    var
        TopXCustomers: Integer;
        TopXItems: Integer;
}

