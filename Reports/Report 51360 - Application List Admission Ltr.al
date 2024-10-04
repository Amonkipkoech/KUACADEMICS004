report 51360 "Application List Admission Ltr"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Application List Admission Ltr.rdl';

    dataset
    {
        dataitem(DataItem2953; 61358)
        {
            DataItemTableView = SORTING("Application No.")
                                WHERE(Status = CONST("Admission Letter"));
            RequestFilterFields = "Application No.";
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
            column(Application_Form_Header__Application_No__; "Application No.")
            {
            }
            column(Application_Form_Header__Application_Date_; "Application Date")
            {
            }
            column(Surname_________Other_Names_; Surname + ' ' + "Other Names")
            {
            }
            column(Application_Form_Header__Date_Of_Birth_; "Date Of Birth")
            {
            }
            column(Application_Form_Header_Gender; Gender)
            {
            }
            column(Application_Form_Header__Marital_Status_; "Marital Status")
            {
            }
            column(DegreeName; DegreeName)
            {
            }
            column(Application_Form_Header__Mean_Grade_Acquired_; "Mean Grade Acquired")
            {
            }
            column(Application_Form_Header_Status; Status)
            {
            }
            column(IntC; IntC)
            {
            }
            column(Applications_ListingCaption; Applications_ListingCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Applicant_NamesCaption; Applicant_NamesCaptionLbl)
            {
            }
            column(Application_Form_Header__Date_Of_Birth_Caption; FIELDCAPTION("Date Of Birth"))
            {
            }
            column(Application_Form_Header_GenderCaption; FIELDCAPTION(Gender))
            {
            }
            column(Application_Form_Header__Marital_Status_Caption; FIELDCAPTION("Marital Status"))
            {
            }
            column(Degree_Applied_ForCaption; Degree_Applied_ForCaptionLbl)
            {
            }
            column(GradeCaption; GradeCaptionLbl)
            {
            }
            column(Application_Form_Header_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*Get the name of the programme from the database*/
                Programme.RESET;
                DegreeName := '';
                IF Programme.GET("First Degree Choice") THEN BEGIN
                    DegreeName := Programme.Description;
                END;

                /*Add the total count*/
                IntC := IntC + 1;

            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Application No.");
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
        DegreeName: Text[200];
        Programme: Record 61511;
        IntC: Integer;
        Applications_ListingCaptionLbl: Label 'Applications Listing';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        No_CaptionLbl: Label 'No.';
        DateCaptionLbl: Label 'Date';
        Applicant_NamesCaptionLbl: Label 'Applicant Names';
        Degree_Applied_ForCaptionLbl: Label 'Degree Applied For';
        GradeCaptionLbl: Label 'Grade';
        TOTALCaptionLbl: Label 'TOTAL';
}

