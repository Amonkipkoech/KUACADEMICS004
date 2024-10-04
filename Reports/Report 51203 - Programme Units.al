report 51203 "Programme Units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Programme Units.rdl';

    dataset
    {
        dataitem(DataItem1410; 61511)
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(USERID; USERID)
            {
            }
            column(Programme_Code; Code)
            {
            }
            column(Programme_Code_Control1102756011; Code)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Programme_Code_Control1102756011Caption; FIELDCAPTION(Code))
            {
            }
            column(Programme_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Programme_CodeCaption; FIELDCAPTION(Code))
            {
            }
            dataitem("ACA-Programme Stages"; 61516)
            {
                DataItemLink = "Programme Code" = FIELD(Code);
                column(StaGeCode; "ACA-Programme Stages".Code)
                {
                }
                column(StageDesc; "ACA-Programme Stages".Description)
                {
                }
                dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
                {
                    DataItemLink = "Programme Code" = FIELD("Programme Code"),
                                  "Stage Code" = FIELD(Code);
                    column(UnitCode; "ACA-Units/Subjects".Code)
                    {
                    }
                    column(UnitDesc; "ACA-Units/Subjects".Desription)
                    {
                    }
                    column(UnitCreditHrs; "ACA-Units/Subjects"."Credit Hours")
                    {
                    }
                }
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Code);
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

    trigger OnPreReport()
    begin
        info.RESET;
        IF info.FIND('-') THEN info.CALCFIELDS(Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        ProgrammeCaptionLbl: Label 'Programme';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        info: Record 79;
}

