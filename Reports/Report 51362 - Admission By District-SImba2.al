report 51362 "Admission By District"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Admission By District.rdlc';

    dataset
    {
        dataitem("ACA-Applic. Setup County"; "ACA-Applic. Setup County")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code";
            column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
            {
            }
            column(Application_Setup_County_Code; Code)
            {
            }
            column(Application_Setup_County__Application_Setup_County__Description; "ACA-Applic. Setup County".Description)
            {
            }
            column(IntC; IntC)
            {
            }
            column(GIntC; GIntC)
            {
            }
            column(STUDENTS_STATISTICS_PER_DISTRICTCaption; STUDENTS_STATISTICS_PER_DISTRICTCaptionLbl)
            {
            }
            column(OFFICE_OF_THE_DEPUTY_REGISTRAR__ACADEMIC_AFFAIRSCaption; OFFICE_OF_THE_DEPUTY_REGISTRAR__ACADEMIC_AFFAIRSCaptionLbl)
            {
            }
            column(SERIAL_NO_Caption; SERIAL_NO_CaptionLbl)
            {
            }
            column(DISTRICTCaption; DISTRICTCaptionLbl)
            {
            }
            column(TOTALSCaption; TOTALSCaptionLbl)
            {
            }
            column(GRAND_TOTALSCaption; GRAND_TOTALSCaptionLbl)
            {
            }
            column(Number; "ACA-Applic. Setup County"."No. of Students")
            {
            }
            dataitem("ACA-Adm. Form Header"; 61372)
            {
                DataItemLink = "Home District" = FIELD(Code);

                trigger OnAfterGetRecord()
                begin
                    IntC := IntC + 1;
                    GIntC := GIntC + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IntC := 0;
            end;

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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        IntC: Integer;
        GIntC: Integer;
        STUDENTS_STATISTICS_PER_DISTRICTCaptionLbl: Label 'STUDENTS STATISTICS PER DISTRICT';
        OFFICE_OF_THE_DEPUTY_REGISTRAR__ACADEMIC_AFFAIRSCaptionLbl: Label 'OFFICE OF THE DEPUTY REGISTRAR, ACADEMIC AFFAIRS';
        SERIAL_NO_CaptionLbl: Label 'SERIAL NO.';
        DISTRICTCaptionLbl: Label 'DISTRICT';
        TOTALSCaptionLbl: Label 'TOTALS';
        GRAND_TOTALSCaptionLbl: Label 'GRAND TOTALS';
}

