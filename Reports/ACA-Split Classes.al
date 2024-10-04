report 61549 "ACA-Split Streams"
{

    dataset
    {
        dataitem(coursesOnOffer; "ACA-Semester Units On Offer")
        {

            column(ProgrammeCode_coursesOnOffer; "Programme Code")
            {
            }
            column(StageCode_coursesOnOffer; "Stage Code")
            {
            }
            column(Code_coursesOnOffer; "Unit Code")
            {
            }
            column(MaximumStreamCapacity_coursesOnOffer; "Maximum Stream Capacity")
            {
            }
            column(Semester_coursesOnOffer; Semester)
            {
            }
            column(UnitBaseTitle_coursesOnOffer; "Unit Base Title")
            {
            }
            column(UnitBaseCode_coursesOnOffer; "Unit Base Code")
            {
            }

            trigger OnPreDataItem()
            begin

            end;

            trigger OnAfterGetRecord()
            begin
                counter := 0;
                StudUnits.Reset();
                StudUnits.SetRange(Semester, coursesOnOffer.Semester);
                StudUnits.SetRange(Programme, coursesOnOffer."Programme Code");
                StudUnits.SetRange(Stage, coursesOnOffer."Stage Code");
                StudUnits.SetRange(Unit, coursesOnOffer."Unit Code");

                if StudUnits.Find('-') then begin
                    //Message(FORMAT(coursesOnOffer."Maximum Stream Capacity"));
                    repeat
                        counter := counter + 1;
                        if (counter <= coursesOnOffer."Maximum Stream Capacity") then begin
                            StudUnits.Stream := 'STREAM A';
                            //Message(FORMAT(counter));
                        end else
                            if ((counter > coursesOnOffer."Maximum Stream Capacity") and (counter <= 2 * (coursesOnOffer."Maximum Stream Capacity"))) then begin
                                StudUnits.Stream := 'STREAM B';
                                //Message(FORMAT(counter));
                            end else
                                if ((counter > 2 * coursesOnOffer."Maximum Stream Capacity") and (counter <= 3 * (coursesOnOffer."Maximum Stream Capacity"))) then begin
                                    StudUnits.Stream := 'STREAM C';
                                    //Message(FORMAT(counter));
                                end
                                else
                                    if ((counter > 3 * coursesOnOffer."Maximum Stream Capacity") and (counter <= 4 * (coursesOnOffer."Maximum Stream Capacity"))) then begin
                                        StudUnits.Stream := 'STREAM D';
                                        //Message(FORMAT(counter));
                                    end;
                        StudUnits.Modify();
                    UNTIL StudUnits.Next() = 0;
                end;

            end;
        }

    }
    trigger OnPostReport()
    begin
        Message('Split Completed Successifully');
    end;

    var
        StudUnits: Record "ACA-Student Units";
        counter: Decimal;

}