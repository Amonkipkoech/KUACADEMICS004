report 77721 "Aca-Transfer Stopped C. Reg."
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = WHERE(Code = FILTER('E101'));

            trigger OnAfterGetRecord()
            begin
                ACACourseRegistration.RESET;
                ACACourseRegistration.SETFILTER(Reversed, '%1', TRUE);
                IF ACACourseRegistration.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        //Copy Course Registrations That have been Reversed
                        ACACourseRegReservour.TRANSFERFIELDS(ACACourseRegistration);
                        ACACourseRegReservour.INSERT;
                        ACACourseRegistration.DELETE;
                    END;
                    UNTIL ACACourseRegistration.NEXT = 0;
                END;

                ACAStudentUnits.RESET;
                ACAStudentUnits.SETFILTER("Reg. Reversed", '%1', TRUE);
                IF ACAStudentUnits.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        //Copy Student Units That have been Reversed
                        ACAStudentUnitsReservour.TRANSFERFIELDS(ACAStudentUnits);
                        ACAStudentUnitsReservour.INSERT;
                        ACAStudentUnits.DELETE;
                    END;
                    UNTIL ACAStudentUnits.NEXT = 0;
                END;

                ACAStdCharges.RESET;
                ACAStdCharges.SETFILTER("Reg. Reversed", '%1', TRUE);
                IF ACAStdCharges.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        //Copy StudentCharges That have been Reversed
                        ACAStudentUnitsReservour.TRANSFERFIELDS(ACAStdCharges);
                        ACAStudentUnitsReservour.INSERT;
                        ACAStdCharges.DELETE;
                    END;
                    UNTIL ACAStdCharges.NEXT = 0;
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
        ACACourseRegistration: Record 61532;
        ACAStudentUnits: Record 61549;
        ACAStdCharges: Record 61535;
        ACACourseRegReservour: Record 77721;
        ACAStudentUnitsReservour: Record 77722;
        ACAStdChargesReservour: Record 77723;
}

