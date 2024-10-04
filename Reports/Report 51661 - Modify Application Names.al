/// <summary>
/// Report Modify Application Names (ID 51661).
/// </summary>
report 51661 "Modify Application Names"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Modify Application Names.rdl';

    dataset
    {
        dataitem(DataItem8879; 61348)
        {
            RequestFilterFields = "Enquiry No.";
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
            column(Enquiry_Header__Name_Surname_First__; "Name(Surname First)")
            {
            }
            column(Enquiry_Header_Surname; Surname)
            {
            }
            column(Enquiry_Header__Other_Names_; "Other Names")
            {
            }
            column(KSPS_Enquiry_HeaderCaption; KSPS_Enquiry_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Enquiry_Header__Name_Surname_First__Caption; FIELDCAPTION("Name(Surname First)"))
            {
            }
            column(Enquiry_Header_SurnameCaption; FIELDCAPTION(Surname))
            {
            }
            column(Enquiry_Header__Other_Names_Caption; FIELDCAPTION("Other Names"))
            {
            }
            column(Enquiry_Header_Enquiry_No_; "Enquiry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF ("Name(Surname First)" <> '') OR (STRLEN("Name(Surname First)") > 10) THEN BEGIN
                    Surname := COPYSTR("Name(Surname First)", 1, STRPOS("Name(Surname First)", ' ') - 1);
                    lStart := STRPOS("Name(Surname First)", ' ');
                    lStart := lStart + 1;
                    lEnd := STRLEN("Name(Surname First)") - lStart;
                    "Other Names" := COPYSTR("Name(Surname First)", lStart, lEnd + 1);
                    MODIFY;
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
        lStart: Integer;
        lEnd: Integer;
        KSPS_Enquiry_HeaderCaptionLbl: Label 'KSPS Enquiry Header';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

