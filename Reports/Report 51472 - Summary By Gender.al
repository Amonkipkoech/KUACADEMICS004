report 51472 "Summary By Gender"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Summary By Gender.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code";
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
            column(malecount; malecount)
            {
            }
            column(femalecount; femalecount)
            {
            }
            column(totalno; totalno)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(No__Of__Male_StudentsCaption; No__Of__Male_StudentsCaptionLbl)
            {
            }
            column(No__Of__Male_StudentsCaption_Control1102760010; No__Of__Male_StudentsCaption_Control1102760010Lbl)
            {
            }
            column(Total_No_of_StudentsCaption; Total_No_of_StudentsCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                malecount := 0;
                femalecount := 0;
                totalno := 0;

                custrec.SETRANGE(custrec."Student Programme", "ACA-Programme".Code);
                custrec.SETRANGE(custrec.Status, custrec.Status::Current);
                custrec.CALCFIELDS(custrec."Student Programme");
                IF custrec.FIND('-') THEN BEGIN

                    REPEAT
                        IF custrec.Gender = custrec.Gender::" " THEN BEGIN
                            malecount := malecount + 1;
                        END
                        ELSE BEGIN
                            femalecount := femalecount + 1;
                        END;
                        totalno := malecount + femalecount;
                    UNTIL custrec.NEXT = 0;
                END;
            end;

            trigger OnPreDataItem()
            begin
                //malecount:=0;
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
        progrec: Record 61511;
        malecount: Integer;
        femalecount: Integer;
        custrec: Record 18;
        totalno: Integer;
        ProgrammeCaptionLbl: Label 'Programme';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        No__Of__Male_StudentsCaptionLbl: Label 'No. Of  Male Students';
        No__Of__Male_StudentsCaption_Control1102760010Lbl: Label 'No. Of  Male Students';
        Total_No_of_StudentsCaptionLbl: Label 'Total No of Students';
}

