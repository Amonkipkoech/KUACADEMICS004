report 63902 "Validate Resits 4"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(SpecialUnits; 78002)
        {

            trigger OnAfterGetRecord()
            begin
                //StudNoName:=SpecialUnits."Student No.";
                CLEAR(StudNoName);
                StudNoName := 'Student No: ' + SpecialUnits."Student No.";
                //SpecialUnits.VALIDATE("Unit Code");
                CountedRecs := CountedRecs + 1;
                RemainingRec := TotalRecord - CountedRecs;
                RecVal := 'Patient Please!';

                CountedRecsText := 'Counted ' + FORMAT(CountedRecs);
                RemainingRecText := 'Remaining ' + FORMAT(RemainingRec);
                TotalRecordText := 'Total Records: ' + FORMAT(TotalRecord);
                progre.UPDATE();
            end;

            trigger OnPostDataItem()
            begin
                progre.CLOSE;
                MESSAGE('Done!' + FORMAT(rex.COUNT));
            end;

            trigger OnPreDataItem()
            begin
                progre.OPEN('Started.....\#1###################################################\' +
                '#2###############################################\' +
                '#3###############################################\' +
                '#4###############################################\' +
                '#5###############################################',
                StudNoName,
                TotalRecordText,
                CountedRecsText,
                RemainingRecText,
                RecVal);
                SpecialUnits.COPYFILTERS(SpecialUnits);
                IF SpecialUnits.FIND('-') THEN;
                TotalRecord := SpecialUnits.COUNT;
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
        rex.RESET;
        IF rex.FIND('-') THEN;

    end;

    var
        progre: Dialog;
        StudNoName: Text[250];
        TotalRecord: Integer;
        CountedRecs: Integer;
        RemainingRec: Integer;
        RecVal: Text[150];
        TotalRecordText: Text[150];
        CountedRecsText: Text[150];
        RemainingRecText: Text[150];
        rex: Record 78002;
}

