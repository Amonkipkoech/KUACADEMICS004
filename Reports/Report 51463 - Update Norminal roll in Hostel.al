report 51463 "Update Norminal roll in Hostel"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Update Norminal roll in Hostel.rdl';

    dataset
    {
        dataitem("ACA-Students Hostel Rooms"; "ACA-Students Hostel Rooms")
        {
            DataItemTableView = SORTING("Line No", Student);
            RequestFilterFields = Billed;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(Students_Hostel_Rooms__Line_No_; "Line No")
            {
            }
            column(Students_Hostel_Rooms__Space_No_; "Space No")
            {
            }
            column(Students_Hostel_Rooms__Room_No_; "Room No")
            {
            }
            column(Students_Hostel_Rooms__Hostel_No_; "Hostel No")
            {
            }
            column(Students_Hostel_Rooms__Accomodation_Fee_; "Accomodation Fee")
            {
            }
            column(Students_Hostel_RoomsCaption; Students_Hostel_RoomsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Students_Hostel_Rooms__Line_No_Caption; FIELDCAPTION("Line No"))
            {
            }
            column(Students_Hostel_Rooms__Space_No_Caption; FIELDCAPTION("Space No"))
            {
            }
            column(Students_Hostel_Rooms__Room_No_Caption; FIELDCAPTION("Room No"))
            {
            }
            column(Students_Hostel_Rooms__Hostel_No_Caption; FIELDCAPTION("Hostel No"))
            {
            }
            column(Students_Hostel_Rooms__Accomodation_Fee_Caption; FIELDCAPTION("Accomodation Fee"))
            {
            }
            column(Students_Hostel_Rooms_Student; Student)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Creg.RESET;
                Creg.SETRANGE(Creg."Student No.", "ACA-Students Hostel Rooms".Student);
                Creg.SETRANGE(Creg.Semester, "ACA-Students Hostel Rooms".Semester);
                IF Creg.FIND('-') THEN BEGIN
                    Creg.Registered := TRUE;
                    Creg.MODIFY;
                END;
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
        Creg: Record 61532;
        Students_Hostel_RoomsCaptionLbl: Label 'Students Hostel Rooms';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

