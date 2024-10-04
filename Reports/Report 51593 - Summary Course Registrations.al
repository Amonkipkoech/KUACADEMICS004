report 51593 "Summary Course Registrations"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Summary Course Registrations.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = Category, Faculty, "Code", "Stage Filter", "Semester Filter", "No. Of Units Filter";
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
            column(Programme_Code; Code)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(Programme_Category; Category)
            {
            }
            column(StudCount; StudCount)
            {
            }
            column(Programme_Registered; Registered)
            {
            }
            column(Total1; Total1)
            {
            }
            column(Total2; Total2)
            {
            }
            column(PercentComplete; PercentComplete)
            {
            }
            column(Summary_Course_RegistrationCaption; Summary_Course_RegistrationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Programme_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Programme_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Programme_CategoryCaption; FIELDCAPTION(Category))
            {
            }
            column(No__Of_StudentsCaption; No__Of_StudentsCaptionLbl)
            {
            }
            column(Programme_RegisteredCaption; FIELDCAPTION(Registered))
            {
            }
            column(Percentage_CompleteCaption; Percentage_CompleteCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                StudCount := 0;

                CReg.RESET;
                CReg.SETRANGE(CReg.Programmes, "ACA-Programme".Code);
                CReg.SETFILTER(CReg.Stage, "ACA-Programme".GETFILTER("ACA-Programme"."Stage Filter"));
                CReg.SETFILTER(CReg.Semester, "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter"));
                CReg.SETFILTER(CReg."Units Taken", "ACA-Programme".GETFILTER("ACA-Programme"."No. Of Units Filter"));
                IF CReg.FIND('-') THEN
                    StudCount := CReg.COUNT;

                "ACA-Programme".CALCFIELDS("ACA-Programme".Registered);
                Total1 := Total1 + "ACA-Programme".Registered;
                Total2 := Total2 + StudCount;
                IF Total1 > 0 THEN PercentComplete := Total2 / Total1 * 100;
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
        CReg: Record 61532;
        StudCount: Integer;
        Total1: Integer;
        Total2: Integer;
        PercentComplete: Decimal;
        Summary_Course_RegistrationCaptionLbl: Label 'Summary Course Registration';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        No__Of_StudentsCaptionLbl: Label 'No. Of Students';
        Percentage_CompleteCaptionLbl: Label 'Percentage Complete';
        EmptyStringCaptionLbl: Label '%';
}

