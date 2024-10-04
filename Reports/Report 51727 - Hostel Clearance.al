report 51727 "Hostel Clearance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Clearance.rdl';

    dataset
    {
        dataitem("ACA-Students Hostel Rooms"; "ACA-Students Hostel Rooms")
        {
            DataItemTableView = SORTING("Line No", Student);
            RequestFilterFields = Semester, "Hostel No", "Room No", "Space No";
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
            column(Students_Hostel_Rooms__Allocation_Date_; "Allocation Date")
            {
            }
            column(Students_Hostel_Rooms__Clearance_Date_; "Clearance Date")
            {
            }
            column(Students_Hostel_Rooms_Student; Student)
            {
            }
            column(Students_Hostel_Rooms_Billed; Billed)
            {
            }
            column(Students_Hostel_Rooms_Semester; Semester)
            {
            }
            column(Students_Hostel_RoomsCaption; Students_Hostel_RoomsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
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
            column(Students_Hostel_Rooms__Allocation_Date_Caption; FIELDCAPTION("Allocation Date"))
            {
            }
            column(Students_Hostel_Rooms__Clearance_Date_Caption; FIELDCAPTION("Clearance Date"))
            {
            }
            column(Students_Hostel_Rooms_StudentCaption; FIELDCAPTION(Student))
            {
            }
            column(Students_Hostel_Rooms_BilledCaption; FIELDCAPTION(Billed))
            {
            }
            column(Students_Hostel_Rooms_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Students_Hostel_Rooms_Line_No; "Line No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Rooms.RESET;
                Rooms.SETRANGE(Rooms."Hostel No", "ACA-Students Hostel Rooms"."Hostel No");
                Rooms.SETRANGE(Rooms."Room No", "ACA-Students Hostel Rooms"."Room No");
                Rooms.SETRANGE(Rooms."Space No", "ACA-Students Hostel Rooms"."Space No");
                IF Rooms.FIND('-') THEN BEGIN
                    Rooms.Status := Rooms.Status::Vaccant;
                    Rooms.MODIFY;
                    "ACA-Students Hostel Rooms".Cleared := TRUE;
                    "ACA-Students Hostel Rooms"."Clearance Date" := TODAY;
                    "ACA-Students Hostel Rooms"."Hostel Assigned" := FALSE;
                    "ACA-Students Hostel Rooms"."Eviction Code" := 'CLEARED BY ' + USERID;
                    // StudentHostel."Billed Date":=TODAY;
                    "ACA-Students Hostel Rooms".MODIFY;
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF CONFIRM('Do you really want to run the hostels clearance') THEN BEGIN
                END ELSE BEGIN
                    CurrReport.BREAK;
                END;
                IF CONFIRM('Please note that this will clear students from their current rooms, Do you still want to continue?') THEN BEGIN
                END ELSE BEGIN
                    CurrReport.BREAK;
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
        Rooms: Record 61163;
        Students_Hostel_RoomsCaptionLbl: Label 'Students Hostel Rooms';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

