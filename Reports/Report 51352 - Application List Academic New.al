report 51352 "Application List Academic New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Application List Academic New.rdl';

    dataset
    {
        dataitem("ACA-Applic. Form Header"; "ACA-Applic. Form Header")
        {
            RequestFilterFields = "Application No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(compName; info.Name)
            {
            }
            column(address; info.Address)
            {
            }
            column(phoneno; info."Phone No.")
            {
            }
            column(email; info."E-Mail")
            {
            }
            column(website; info."Home Page")
            {
            }
            column(pic; info.Picture)
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
            column(status; "ACA-Applic. Form Header".Status)
            {
            }
            column(Admitteddegree; "ACA-Applic. Form Header"."Admitted Degree")
            {
            }
            column(Intakecode; "ACA-Applic. Form Header"."Intake Code")
            {
            }
            column(Modeofstudy; "ACA-Applic. Form Header"."Mode of Study")
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

    trigger OnInitReport()
    begin
        IF info.GET() THEN BEGIN
            info.CALCFIELDS(info.Picture);
        END;
    end;

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
        info: Record 79;
}

