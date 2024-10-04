report 70092 "ACA-Student Balances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Student Balances.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code)
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            column(USERID; USERID)
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
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(Totald; Totald)
            {
            }
            column(totalc; totalc)
            {
            }
            column(totalb; totalb)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(Programme_Code; Code)
            {
            }
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = Programmes = FIELD(Code);
                DataItemTableView = SORTING("Student No.")
                                    ORDER(Ascending)
                                    WHERE(Reversed = CONST(false),
                                          Posted = CONST(true));
                PrintOnlyIfDetail = true;
                RequestFilterFields = Programmes, "Settlement Type", Stage, Session, Semester, Faculty;
                column(Customer__No__Caption; Customer.FIELDCAPTION("No."))
                {
                }
                column(Customer_NameCaption; Customer.FIELDCAPTION(Name))
                {
                }
                column(Customer__Debit_Amount__LCY__Caption; Customer.FIELDCAPTION("Debit Amount (LCY)"))
                {
                }
                column(Customer__Credit_Amount__LCY__Caption; Customer.FIELDCAPTION("Credit Amount (LCY)"))
                {
                }
                column(Customer__Balance__LCY__Caption; Customer.FIELDCAPTION("Balance (LCY)"))
                {
                }
                column(StageCaption; StageCaptionLbl)
                {
                }
                column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
                {
                }
                column(Course_Registration_Student_No_; "Student No.")
                {
                }
                column(Course_Registration_Programme; Programmes)
                {
                }
                column(Course_Registration_Semester; Semester)
                {
                }
                column(Course_Registration_Register_for; "Register for")
                {
                }
                column(Course_Registration_Stage; Stage)
                {
                }
                column(Course_Registration_Unit; Unit)
                {
                }
                column(Course_Registration_Student_Type; "Student Type")
                {
                }
                column(Course_Registration_Programmefilter; "ACA-Course Registration"."Programme Filter")
                {
                }
                column(Studentstatus; "ACA-Course Registration"."Student Status")
                {
                }
                column(Settlemnt; "ACA-Course Registration"."Settlement Type")
                {
                }
                column(Course_Registration_Entry_No_; "Entry No.")
                {
                }
                dataitem(Customer; Customer)
                {
                    DataItemLink = "No." = FIELD("Student No.");
                    DataItemTableView = SORTING("No.")
                                        ORDER(Ascending)
                                        WHERE("Customer Type" = CONST(Student),
                                              Status = FILTER(Current | Registration));
                    RequestFilterFields = "No.", "Date Filter", "Balance (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)", "Credit Amount", Status;
                    column(NCount; NCount)
                    {
                    }
                    column(Customer__No__; "No.")
                    {
                    }
                    column(Customer_Name; Name)
                    {
                    }
                    column(Customer__Debit_Amount__LCY__; "Debit Amount (LCY)")
                    {
                    }
                    column(Customer__Credit_Amount__LCY__; "Credit Amount (LCY)")
                    {
                    }
                    column(Customer__Balance__LCY__; "Balance (LCY)")
                    {
                    }
                    column(Hesabu; Hesabu)
                    {
                    }
                    column(Course_Registration__Stage; "ACA-Course Registration".Stage)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        NCount := NCount + 1;
                        Totald := Totald + Customer."Debit Amount (LCY)";
                        totalc := totalc + Customer."Credit Amount (LCY)";
                        totalb := totalb + Customer."Balance (LCY)";
                    end;
                }
            }
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
        totalc: Decimal;
        Totald: Decimal;
        totalb: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CustomerCaptionLbl: Label 'Customer';
        StageCaptionLbl: Label 'Stage';
        NCount: Integer;
}

