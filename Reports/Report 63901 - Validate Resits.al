report 63901 "Validate Resits"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(SpecialUnits; 78002)
        {
            DataItemTableView = WHERE("Current Academic Year" = FILTER(''),
                                      "Charge Posted" = FILTER('No'));

            trigger OnAfterGetRecord()
            begin
                //StudNoName:=SpecialUnits."Student No.";
                CLEAR(StudNoName);
                StudNoName := 'Student No: ' + SpecialUnits."Student No.";
                SpecialUnits.VALIDATE("Unit Code");
                CountedRecs := CountedRecs + 1;
                RemainingRec := TotalRecord - CountedRecs;
                RecVal := 'Patient Please!';

                CountedRecsText := 'Counted ' + FORMAT(CountedRecs);
                RemainingRecText := 'Remaining ' + FORMAT(RemainingRec);
                TotalRecordText := 'Total Records: ' + FORMAT(TotalRecord);
                progre.UPDATE();
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

    trigger OnPostReport()
    begin
        progre.CLOSE;
        MESSAGE('Done!');
    end;

    trigger OnPreReport()
    begin

        SpecialUnits2.RESET;
        SpecialUnits2.COPYFILTERS(SpecialUnits);
        IF SpecialUnits2.FIND('-') THEN;
        TotalRecord := SpecialUnits2.COUNT;
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
        SpecialUnits2: Record 78002;
}

