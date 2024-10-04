report 51422 "Hostel Registration"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Registration.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
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
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer_Address; Address)
            {
            }
            column(Customer__Address_2_; "Address 2")
            {
            }
            column(Customer__Student_Programme_; "Student Programme")
            {
            }
            column(STUDENT_HOSTEL_REGISTRATIONCaption; STUDENT_HOSTEL_REGISTRATIONCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Customer_AddressCaption; FIELDCAPTION(Address))
            {
            }
            column(Programme_Caption; Programme_CaptionLbl)
            {
            }
            dataitem(DataItem4756; 61155)
            {
                DataItemLink = Student = FIELD("No.");
                column(Students_Hostel_Rooms__Hostel_No_; "Hostel No")
                {
                }
                column(Students_Hostel_Rooms__Room_No_; "Room No")
                {
                }
                column(Students_Hostel_Rooms__Space_No_; "Space No")
                {
                }
                column(Students_Hostel_Rooms__Accomodation_Fee_; "Accomodation Fee")
                {
                }
                column(Students_Hostel_Rooms_Cleared; Cleared)
                {
                }
                column(Students_Hostel_Rooms__Hostel_No_Caption; FIELDCAPTION("Hostel No"))
                {
                }
                column(Students_Hostel_Rooms__Room_No_Caption; FIELDCAPTION("Room No"))
                {
                }
                column(Students_Hostel_Rooms__Space_No_Caption; FIELDCAPTION("Space No"))
                {
                }
                column(Students_Hostel_Rooms__Accomodation_Fee_Caption; FIELDCAPTION("Accomodation Fee"))
                {
                }
                column(Students_Hostel_Rooms_ClearedCaption; FIELDCAPTION(Cleared))
                {
                }
                column(Students_Hostel_Rooms_Line_No; "Line No")
                {
                }
                column(Students_Hostel_Rooms_Student; Student)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Customer.CALCFIELDS(Customer."Student Programme");
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
        STUDENT_HOSTEL_REGISTRATIONCaptionLbl: Label 'STUDENT HOSTEL REGISTRATION';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Programme_CaptionLbl: Label 'Programme ';
}

