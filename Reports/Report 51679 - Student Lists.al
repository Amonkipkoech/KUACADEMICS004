/// <summary>
/// Report Student Lists (ID 51679).
/// </summary>
report 51679 "Student Lists"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Lists.rdl';

    dataset
    {
        dataitem(DataItem6836; 18)
        {
#pragma warning disable AL0254
            DataItemTableView = SORTING("Lib Membership", "No.")
#pragma warning restore AL0254
                                // WHERE(Customer Type=CONST(Student))
                                ;
            RequestFilterFields = "No.", "Date Registered", Status, Gender;
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
            column(Hesabu; Hesabu)
            {
            }
            column(Course; Course)
            {
            }
            column(AmountPaid; AmountPaid)
            {
            }
            column(Customer__Balance__LCY__; "Balance (LCY)")
            {
            }
            column(Student_ListCaption; Student_ListCaptionLbl)
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
            column(CourseCaption; CourseCaptionLbl)
            {
            }
            column(Amount_PaidCaption; Amount_PaidCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Course := '';
                AmountPaid := 0;
                courseReg.RESET;
                courseReg.SETCURRENTKEY(courseReg."Student No.");
                courseReg.SETRANGE(courseReg."Student No.", "No.");
                IF courseReg.FIND('+') THEN
                    Course := courseReg.Programmes;
                Receipt.RESET;
                Receipt.SETCURRENTKEY(Receipt."Student No.");
                Receipt.SETRANGE(Receipt."Student No.", "No.");
                IF Receipt.FIND('-') THEN BEGIN
                    REPEAT
                        AmountPaid := AmountPaid + Receipt.Amount;
                    UNTIL Receipt.NEXT = 0;
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
        Hesabu: Integer;
        Programme: Record 61511;
        courseReg: Record 61532;
        Course: Code[20];
        Receipt: Record 61538;
        AmountPaid: Decimal;
        Student_ListCaptionLbl: Label 'Student List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CourseCaptionLbl: Label 'Course';
        Amount_PaidCaptionLbl: Label 'Amount Paid';
}

