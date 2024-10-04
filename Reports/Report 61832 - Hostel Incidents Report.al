report 61832 "Hostel Incidents Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Incidents Report.rdl';

    dataset
    {
        dataitem(DataItem1; 61162)
        {
            column(address; info.Address)
            {
            }
            column(Phone; info."Phone No.")
            {
            }
            column(pics; info.Picture)
            {
            }
            column(No; "Asset No")
            {
            }
            column(Desc; Description)
            {
            }
            dataitem(DataItem1000000000; 61832)
            {
                DataItemLink = "Hostel Block No." = FIELD("Asset No");
                column(IncidentNo; "Incident No.")
                {
                }
                column(IncidentDate; "Incident Date")
                {
                }
                column(IncidentTime; "Incident Time")
                {
                }
                column(DayOrNight; "Day/Night")
                {
                }
                column(ReportBy; "Report By")
                {
                }
                column(ReportSummary; "Report Summary")
                {
                }
                column(ReportDetails; "Report Details")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(totRooms);
                totRooms := Vaccant + "Fully Occupied" + Blacklisted + "Partially Occupied";
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

    trigger OnPreReport()
    begin
        info.RESET;
        IF info.FIND('-') THEN info.CALCFIELDS(info.Picture)
    end;

    var
        info: Record 79;
        totRooms: Integer;
}

