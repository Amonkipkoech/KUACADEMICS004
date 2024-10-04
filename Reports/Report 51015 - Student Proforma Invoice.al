report 51015 "Student Proforma Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Proforma Invoice.rdl';

    dataset
    {
        dataitem(SFS; 61523)
        {
            RequestFilterFields = "Programme Code", "Stage Code", "Settlemet Type", Semester;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(Pic;CompanyInformation.Picture)
            {

            }
            column(Name;CompanyInformation.Name)
            {

            }
            column(USERID; USERID)
            {
            }
            column(TuitionTT; "Break Down")
            {
            }
            column(Fee_By_StageCaption; Fee_By_StageCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Tuition_PayableCaption; Tuition_PayableCaptionLbl)
            {
            }
            column(Fee_By_Stage_Programme_Code; "Programme Code")
            {
            }
            column(Fee_By_Stage_Stage_Code; "Stage Code")
            {
            }
            column(Fee_By_Stage_Semester; Semester)
            {
            }
            column(Fee_By_Stage_Student_Type; "Student Type")
            {
            }
            column(Fee_By_Stage_Settlemet_Type; "Settlemet Type")
            {
            }
            column(Fee_By_Stage_Seq_; "Seq.")
            {
            }
            column(ProgName; SFS."Programme Description")
            {
            }
            column(StageName; SFS."Stage Description")
            {
            }
            column(Total; TotalAmount)
            {
            }
            dataitem(AC; 61533)
            {
                DataItemLink = "Programme Code" = FIELD("Programme Code"),
                               "Stage Code" = FIELD("Stage Code"),
                               "Settlement Type" = FIELD("Settlemet Type");
                column(Stage_Charges_Code; Code)
                {
                }
                column(Stage_Charges_Description; Description)
                {
                }
                column(Stage_Charges_Amount; Amount)
                {
                }
                column(Fee_By_Stage___Break_Down___Stage_Charges__Amount; AC.Amount + TuitionAmount)
                {
                }
                column(Stage_Charges_Programme_Code; "Programme Code")
                {
                }
                column(Stage_Charges_Stage_Code; "Stage Code")
                {
                }
                column(Stage_Charges_Settlement_Type; "Settlement Type")
                {
                }
                column(Stage_Charges_Semester; Semester)
                {
                }
                column(Tuition; TuitionAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SFS.CALCFIELDS(SFS."Stage Charges");
                    TotalAmount := SFS."Break Down" + SFS."Stage Charges";
                end;
            }

            trigger OnAfterGetRecord()
            begin

                //TotalAmount:="Fee By Stage"."Break Down"+"Stage Charges".Amount;
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
    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var
        Fee_By_StageCaptionLbl: Label 'Fee By Stage';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Tuition_PayableCaptionLbl: Label 'Tuition Payable';
        TotalAmount: Decimal;
        TuitionAmount: Decimal;
        CompanyInformation: Record 79;
}

