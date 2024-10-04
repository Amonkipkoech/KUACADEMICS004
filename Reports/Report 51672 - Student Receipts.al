/// <summary>
/// Report Student Receipts (ID 51672).
/// </summary>
report 51672 "Student Receipts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Receipts.rdl';

    dataset
    {
        dataitem(DataItem1410; 61511)
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
            column(totalc_0_35; totalc * 0.35)
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
            dataitem(DataItem2901; 61532)
            {
                DataItemLink = Programmes = FIELD(Code);
                DataItemTableView = SORTING("Student No.")
                                    ORDER(Ascending)
                                   //WHERE(reversed =filter(Boolean))
                                   ;
                PrintOnlyIfDetail = true;
                RequestFilterFields = Programmes, "Settlement Type", Stage, Session, Semester;
                column(Student_No_; "Student No.")
                {
                }
                column(Names; Names)
                {
                }
                // column(Customer__Debit_Amount__LCY__Caption; Customer.FIELDCAPTION("Debit Amount (LCY)"))
                // {
                // }
                // column(Customer__Credit_Amount__LCY__Caption; Customer.FIELDCAPTION("Credit Amount (LCY)"))
                // {
                // }
                column(V35___CreditCaption; V35___CreditCaptionLbl)
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
                column(Course_Registration_Entry_No_; "Entry No.")
                {
                }
                column(Course_Registration__Stage; Stage)
                {
                }
                dataitem(DataItem6836; 18)
                {
                    DataItemLink = "No." = FIELD("Student No.");
                    DataItemTableView = SORTING("No.")
                                        ORDER(Ascending)
                                        // WHERE(Customer Type=CONST(Student))
                                        ;
                    RequestFilterFields = "No.", "Date Filter", "Balance (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)", "Credit Amount";
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
                    column(Customer__Credit_Amount__LCY___0_35; "Credit Amount (LCY)" * 0.35)
                    {
                    }
                    column(Hesabu; Hesabu)
                    {
                    }


                    trigger OnAfterGetRecord()
                    begin
                        Totald := Totald + "Debit Amount (LCY)";
                        totalc := totalc + "Credit Amount (LCY)";
                        totalb := totalb + "Balance (LCY)";
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
        V35___CreditCaptionLbl: Label '35 % Credit';
        StageCaptionLbl: Label 'Stage';
}

