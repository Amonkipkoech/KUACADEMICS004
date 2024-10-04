report 51569 "Pass List - Grouped"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Pass List - Grouped.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("General Remark");
            RequestFilterFields = Programmes, Stage, Unit, "General Remark";
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
            column(Course_Registration__General_Remark_; "General Remark")
            {
            }
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Resit_ListCaption; Resit_ListCaptionLbl)
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
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("Student No."), "Reg. Transacton ID" = FIELD("Reg. Transacton ID");
                DataItemTableView = WHERE(Taken = CONST(false), Failed = CONST(true));
                column(Student_Units_Unit; Unit)
                {
                }
                column(UDesc; UDesc)
                {
                }
                column(Student_Units_Programme; Programme)
                {
                }
                column(Student_Units_Stage; Stage)
                {
                }
                column(Student_Units_Semester; Semester)
                {
                }
                column(Student_Units_Reg__Transacton_ID; "Reg. Transacton ID")
                {
                }
                column(Student_Units_Student_No_; "Student No.")
                {
                }
                column(Student_Units_ENo; ENo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    UDesc := '';

                    pUnits.RESET;
                    pUnits.SETRANGE("Programme Code", "ACA-Student Units".Programme);
                    pUnits.SETRANGE(Code, "ACA-Student Units".Unit);
                    IF pUnits.FIND('-') THEN
                        UDesc := pUnits.Desription;
                end;
            }


            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("General Remark");
                RCount := 0;
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
        Cust: Record 18;
        Grading: Record 61569;
        StudUnits: Record 61549;
        FailScore: Decimal;
        // PassedUnits: Integer;
        Remark: Text[150];
        RCount: Integer;
        pUnits: Record 61517;
        UDesc: Text[200];
        Resit_ListCaptionLbl: Label 'Resit List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

