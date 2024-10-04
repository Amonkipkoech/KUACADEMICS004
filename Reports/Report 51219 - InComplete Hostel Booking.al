/// <summary>
/// Report InComplete Hostel Booking (ID 51219).
/// </summary>
report 51219 "InComplete Hostel Booking"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/InComplete Hostel Booking.rdl';

    dataset
    {
        dataitem("ACA-Students Hostel Rooms"; "ACA-Students Hostel Rooms")
        {
            DataItemTableView = SORTING("Hostel No")
                                WHERE(Billed = CONST(false),
                                      Cleared = CONST(false));
            RequestFilterFields = "Hostel No", Semester, "Space No", Student;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(Students_Hostel_Rooms__Hostel_No_; "Hostel No")
            {
            }
            column(Students_Hostel_Rooms__Hostel_Name_; "Hostel Name")
            {
            }
            column(Students_Hostel_Rooms__Space_No_; "Space No")
            {
            }
            column(Students_Hostel_Rooms__Room_No_; "Room No")
            {
            }
            column(Students_Hostel_Rooms__Hostel_No__Control1000000017; "Hostel No")
            {
            }
            column(Students_Hostel_Rooms__Accomodation_Fee_; "Accomodation Fee")
            {
            }
            column(Students_Hostel_Rooms_Student; Student)
            {
            }
            column(CustName; CustName)
            {
            }
            column(SCount; SCount)
            {
            }
            column(Students_Hostel_Rooms__Students_Hostel_Rooms___Allocation_Date_; "ACA-Students Hostel Rooms"."Allocation Date")
            {
            }
            column(Students_Hostel_Rooms__Accomodation_Fee__Control1000000022; "Accomodation Fee")
            {
            }
            column(TCount; TCount)
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
            column(Students_Hostel_Rooms__Hostel_No__Control1000000017Caption; FIELDCAPTION("Hostel No"))
            {
            }
            column(Students_Hostel_Rooms__Accomodation_Fee_Caption; FIELDCAPTION("Accomodation Fee"))
            {
            }
            column(Students_Hostel_Rooms_StudentCaption; FIELDCAPTION(Student))
            {
            }
            column(Student_NameCaption; Student_NameCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Allocation_DateCaption; Allocation_DateCaptionLbl)
            {
            }
            column(Students_Hostel_Rooms__Hostel_No_Caption; FIELDCAPTION("Hostel No"))
            {
            }
            column(Total_AccomodationCaption; Total_AccomodationCaptionLbl)
            {
            }
            column(Total_StudentsCaption; Total_StudentsCaptionLbl)
            {
            }
            column(Students_Hostel_Rooms_Line_No; "Line No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("ACA-Students Hostel Rooms".Student) THEN
                    CustName := Cust.Name;
                SCount := SCount + 1;
                TCount := TCount + 1;
            end;

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
        TotalFor: Label 'Total for ';
        Cust: Record 18;
        CustName: Text[100];
        SCount: Integer;
        TCount: Integer;
        Students_Hostel_RoomsCaptionLbl: Label 'Students Hostel Rooms';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Student_NameCaptionLbl: Label 'Student Name';
        EmptyStringCaptionLbl: Label '#';
        Allocation_DateCaptionLbl: Label 'Allocation Date';
        Total_AccomodationCaptionLbl: Label 'Total Accomodation';
        Total_StudentsCaptionLbl: Label 'Total Students';
}

