report 51248 "Hostel List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel List.rdl';

    dataset
    {
        dataitem("ACA-Hostel Card"; "ACA-Hostel Card")
        {
            DataItemTableView = SORTING("Asset No");
            RequestFilterFields = "Asset No";
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
            column(Hostel_Card__Asset_No_; "Asset No")
            {
            }
            column(Hostel_Card_Discription; Description)
            {
            }
            column(Hostel_Card__Space_Per_Room_; "Space Per Room")
            {
            }
            column(Hostel_Card_Gender; Gender)
            {
            }
            column(Hostel_Card__Total_Rooms_Created_; "Total Rooms Created")
            {
            }
            column(Hostel_Card__Total_Vacant_; "Total Vacant")
            {
            }
            column(Hostel_Card__Total_Occupied_; "Total Occupied")
            {
            }
            column(Hostel_Card__Total_Out_of_Order_; "Total Out of Order")
            {
            }
            column(Hostel_Card__Room_Prefix_; "Room Prefix")
            {
            }
            column(tOut; tOut)
            {
            }
            column(tOccupied; tOccupied)
            {
            }
            column(tVacant; tVacant)
            {
            }
            column(tAll; tAll)
            {
            }
            column(Hostel_SummaryCaption; Hostel_SummaryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Hostel_Card__Asset_No_Caption; FIELDCAPTION("Asset No"))
            {
            }
            column(Hostel_Card_DiscriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Hostel_Card__Space_Per_Room_Caption; FIELDCAPTION("Space Per Room"))
            {
            }
            column(Hostel_Card_GenderCaption; FIELDCAPTION(Gender))
            {
            }
            column(Total_RoomsCaption; Total_RoomsCaptionLbl)
            {
            }
            column(Hostel_Card__Total_Vacant_Caption; FIELDCAPTION("Total Vacant"))
            {
            }
            column(Hostel_Card__Total_Occupied_Caption; FIELDCAPTION("Total Occupied"))
            {
            }
            column(Hostel_Card__Total_Out_of_Order_Caption; FIELDCAPTION("Total Out of Order"))
            {
            }
            column(Hostel_Card__Room_Prefix_Caption; FIELDCAPTION("Room Prefix"))
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                tVacant := tVacant + "ACA-Hostel Card"."Total Vacant";
                tAll := tAll + "ACA-Hostel Card"."Total Rooms Created";
                tOccupied := tOccupied + "ACA-Hostel Card"."Total Occupied";
                tOut := tOut + "ACA-Hostel Card"."Total Out of Order";
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
        tVacant: Integer;
        tOccupied: Integer;
        tAll: Integer;
        tOut: Integer;
        Hostel_SummaryCaptionLbl: Label 'Hostel Summary';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Total_RoomsCaptionLbl: Label 'Total Rooms';
        TotalsCaptionLbl: Label 'Totals';
}

