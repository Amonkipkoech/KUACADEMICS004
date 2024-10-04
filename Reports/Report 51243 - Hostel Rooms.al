report 51243 "Hostel Rooms"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Rooms.rdl';

    dataset
    {
        dataitem(DataItem3889; 61163)
        {
            DataItemTableView = SORTING("Hostel No");
            RequestFilterFields = "Hostel No";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(USERID; USERID)
            {
            }
            column(Hostel_Ledger__Hostel_No_; "Hostel No")
            {
            }
            column(Hostel_Ledger__Hostel_No__Control1000000011; "Hostel No")
            {
            }
            column(Hostel_Ledger__Room_No_; "Room No")
            {
            }
            column(Hostel_Ledger__Space_No_; "Space No")
            {
            }
            column(Hostel_Ledger_Status; Status)
            {
            }
            column(Hostel_RoomsCaption; Hostel_RoomsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Hostel_Ledger__Hostel_No__Control1000000011Caption; FIELDCAPTION("Hostel No"))
            {
            }
            column(Hostel_Ledger__Room_No_Caption; FIELDCAPTION("Room No"))
            {
            }
            column(Hostel_Ledger__Space_No_Caption; FIELDCAPTION("Space No"))
            {
            }
            column(Hostel_Ledger_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(Hostel_Ledger__Hostel_No_Caption; FIELDCAPTION("Hostel No"))
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Hostel No");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Hostel_RoomsCaptionLbl: Label 'Hostel Rooms';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

