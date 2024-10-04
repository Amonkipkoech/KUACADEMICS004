report 51809 "CAT-Cafeteria Menu"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/CAT-Cafeteria Menu.rdl';

    dataset
    {
        dataitem(DataItem1; 61782)
        {
            column(pic; info.Picture)
            {
            }
            column(comp; 'MASENO UNIVERSITY')
            {
            }
            column(tittle; 'CAFETERIA MENU')
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(CafeSections; CafeSections)
            {
            }
            column(seq; seq)
            {
            }
            column(itemCode; "Item No")
            {
            }
            column(Desc; "Item Description")
            {
            }
            column(ItemPrice; "Price Per Item")
            {
            }
            column(warning; 'The Cafeteria Management reserves the right to sell an Item on the menu')
            {
            }
            column(bonapettie; '***************************************** BON APETTIE *****************************************')
            {
            }

            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
            end;

            trigger OnPreDataItem()
            begin
                RESET;
                SETFILTER("Menu Date", '=%1', DateFilter);
                SETFILTER("Cafeteria Section", '=%1', CafeSections);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Report_Filter)
                {
                    Caption = 'Report Filter';
                    field(DateFilter; DateFilter)
                    {
                        Caption = 'Date Filter';
                        ApplicationArea = All;
                    }
                    field(CafeSections; CafeSections)
                    {
                        Caption = 'Cafe. Sections';
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
    }

    trigger OnInitReport()
    begin
        DateFilter := TODAY;
    end;

    trigger OnPreReport()
    begin
        info.RESET;
        IF info.FIND('-') THEN BEGIN
            info.CALCFIELDS(info.Picture);
        END;
        CLEAR(seq);
        IF DateFilter = 0D THEN ERROR('Please specify a date.');
        IF CafeSections = CafeSections::" " THEN ERROR('Specify the Cafeteria section!');
    end;

    var
        DateFilter: Date;
        CafeSections: Option " ",Students,Staff;
        info: Record 79;
        seq: Integer;
}

