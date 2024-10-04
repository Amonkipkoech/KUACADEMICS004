report 51573 Invoice
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Invoice.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Student No.");
            RequestFilterFields = "Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type";
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Course_Registration__Registration_Date_; "Registration Date")
            {
            }
            column(Course_Registration__Student_Type_; "Student Type")
            {
            }
            column(Stages_Description; Stages.Description)
            {
            }
            column(Prog_Description; Prog.Description)
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Course_Registration__Registration_Date_Caption; FIELDCAPTION("Registration Date"))
            {
            }
            column(Course_Registration__Student_Type_Caption; FIELDCAPTION("Student Type"))
            {
            }
            column(MASENO_UNIVERSITYCaption; MASENO_UNIVERSITYCaptionLbl)
            {
            }
            column(LevelCaption; LevelCaptionLbl)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; "Cust. Ledger Entry".FIELDCAPTION("Posting Date"))
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; "Cust. Ledger Entry".FIELDCAPTION("Document No."))
            {
            }
            column(Cust__Ledger_Entry_DescriptionCaption; "Cust. Ledger Entry".FIELDCAPTION(Description))
            {
            }
            column(Cust__Ledger_Entry__Currency_Code_Caption; "Cust. Ledger Entry".FIELDCAPTION("Currency Code"))
            {
            }
            column(Cust__Ledger_Entry__Remaining_Amount_Caption; "Cust. Ledger Entry".FIELDCAPTION("Remaining Amount"))
            {
            }
            column(INVOICECaption; INVOICECaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
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
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("Student No.");
                DataItemTableView = WHERE("Remaining Amount" = FILTER(> 0),
                                          "Document No." = FILTER(<> 'HELB JAN'));
                column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Cust__Ledger_Entry_Description; Description)
                {
                }
                column(Cust__Ledger_Entry__Currency_Code_; "Currency Code")
                {
                }
                column(Cust__Ledger_Entry__Remaining_Amount_; "Remaining Amount")
                {
                }
                column(Cust__Ledger_Entry__Remaining_Amount__Control1102760000; "Remaining Amount")
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("ACA-Course Registration"."Student No.") THEN
                    RFound := TRUE;
                IF Prog.GET("ACA-Course Registration".Programmes) THEN
                    RFound := TRUE;
                IF Stages.GET("ACA-Course Registration".Programmes, "ACA-Course Registration".Stage) THEN
                    RFound := TRUE;
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
        Cust: Record 18;
        Prog: Record 61511;
        Stages: Record 61516;
        RFound: Boolean;
        UDesc: Text[200];
        Units: Record 61517;
        MASENO_UNIVERSITYCaptionLbl: Label 'MASENO UNIVERSITY';
        LevelCaptionLbl: Label 'Level';
        ProgrammeCaptionLbl: Label 'Programme';
        INVOICECaptionLbl: Label 'INVOICE';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
}

