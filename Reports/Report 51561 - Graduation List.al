report 51561 "Graduation List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Graduation List.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(USERID; USERID)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(Customer_Customer__No__; Customer."No.")
            {
            }
            column(TPassedUnits; TPassedUnits)
            {
            }
            column(TUnitsTaken_TPassedUnits; TUnitsTaken - TPassedUnits)
            {
            }
            column(Customer_Customer_Name; Customer.Name)
            {
            }
            column(Remark; Remark)
            {
            }
            column(RCount; RCount)
            {
            }
            column(TUnitsTaken; TUnitsTaken)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Pass_ListCaption; Pass_ListCaptionLbl)
            {
            }
            column(Units_PassedCaption; Units_PassedCaptionLbl)
            {
            }
            column(Units_FailedCaption; Units_FailedCaptionLbl)
            {
            }
            column(RemarkCaption; RemarkCaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(Customer_Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Units_TakenCaption; Units_TakenCaptionLbl)
            {
            }
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type");
                RequestFilterFields = Programmes, Stage, Unit, "Student No.";

                trigger OnAfterGetRecord()
                begin
                    RCount := RCount + 1;

                    PassedUnits := 0;
                    Grading.RESET;
                    Grading.SETRANGE(Grading.Category, 'DEFAULT');
                    Grading.SETRANGE(Grading.Failed, TRUE);
                    IF Grading.FIND('+') THEN
                        FailScore := Grading."Up to";

                    StudUnits.RESET;
                    StudUnits.SETRANGE(StudUnits."Student No.", "ACA-Course Registration"."Student No.");
                    StudUnits.SETRANGE(StudUnits."Reg. Transacton ID", "ACA-Course Registration"."Reg. Transacton ID");
                    IF StudUnits.FIND('-') THEN BEGIN
                        REPEAT
                            StudUnits.CALCFIELDS(StudUnits."Total Score");
                            IF StudUnits."Total Score" > FailScore THEN
                                PassedUnits := PassedUnits + 1;

                        UNTIL StudUnits.NEXT = 0;
                    END;


                    TPassedUnits := TPassedUnits + PassedUnits;
                    TUnitsTaken := TUnitsTaken + "ACA-Course Registration"."Units Taken";

                    IF TPassedUnits = TPassedUnits THEN
                        Remark := 'PASSED'
                    ELSE
                        Remark := 'FAILED';
                end;

                trigger OnPreDataItem()
                begin
                    RCount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TPassedUnits := 0;
                TUnitsTaken := 0;
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
        Grading: Record 61569;
        StudUnits: Record 61549;
        FailScore: Decimal;
        PassedUnits: Integer;
        Remark: Text[150];
        RCount: Integer;
        TPassedUnits: Integer;
        TUnitsTaken: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Pass_ListCaptionLbl: Label 'Pass List';
        Units_PassedCaptionLbl: Label 'Units Passed';
        Units_FailedCaptionLbl: Label 'Units Failed';
        RemarkCaptionLbl: Label 'Remark';
        NamesCaptionLbl: Label 'Names';
        Units_TakenCaptionLbl: Label 'Units Taken';
}

