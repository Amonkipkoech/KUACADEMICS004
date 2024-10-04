report 78050 "ACA-Update Student Names"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = WHERE("Customer Posting Group" = FILTER('STUDENT'),
                                      Name = FILTER(<> ''));

            trigger OnAfterGetRecord()
            begin
                IF STRLEN(Customer.Name) > 100 THEN Customer.Name := COPYSTR(Customer.Name, 1, 100);
                RemainingRecs := RemainingRecs - 1;
                Customer.Name := FormatNames(Customer.Name);
                Customer.MODIFY;
                dialsz.UPDATE(2, FORMAT(RemainingRecs));

                dialsz.UPDATE(3, FORMAT(Customer."No."));
            end;

            trigger OnPostDataItem()
            begin
                dialsz.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                dialsz.OPEN('#1############################################################\' +
                '#2#################################################################' +
                '#3#################################################################');
                totrec := Customer.COUNT;
                RemainingRecs := totrec;
                dialsz.UPDATE(1, FORMAT(totrec));
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
        totrec: Integer;
        RemainingRecs: Integer;
        dialsz: Dialog;

    local procedure FormatNames(CommonName: Text[250]) NewName: Text[250]
    var
        NamesSmall: Text[250];
        FirsName: Text[250];
        SpaceCount: Integer;
        SpaceFound: Boolean;
        Counts: Integer;
        Strlegnth: Integer;
        OtherNames: Text[250];
    begin
        CLEAR(NamesSmall);
        CLEAR(FirsName);
        CLEAR(SpaceCount);
        CLEAR(SpaceFound);
        CLEAR(OtherNames);
        IF STRLEN(CommonName) > 100 THEN CommonName := COPYSTR(CommonName, 1, 100);
        Strlegnth := STRLEN(CommonName);
        IF STRLEN(CommonName) > 4 THEN BEGIN
            NamesSmall := LOWERCASE(CommonName);
            REPEAT
            BEGIN
                SpaceCount += 1;
                IF ((COPYSTR(NamesSmall, SpaceCount, 1) = '') OR (COPYSTR(NamesSmall, SpaceCount, 1) = ' ') OR (COPYSTR(NamesSmall, SpaceCount, 1) = ',')) THEN SpaceFound := TRUE;
                IF NOT SpaceFound THEN BEGIN
                    FirsName := FirsName + UPPERCASE(COPYSTR(NamesSmall, SpaceCount, 1));
                END ELSE BEGIN
                    IF STRLEN(OtherNames) < 150 THEN BEGIN
                        IF ((COPYSTR(NamesSmall, SpaceCount, 1) = '') OR (COPYSTR(NamesSmall, SpaceCount, 1) = ' ') OR (COPYSTR(NamesSmall, SpaceCount, 1) = ',')) THEN BEGIN
                            OtherNames := OtherNames + ' ';
                            SpaceCount += 1;
                            OtherNames := OtherNames + UPPERCASE(COPYSTR(NamesSmall, SpaceCount, 1));
                        END ELSE BEGIN
                            OtherNames := OtherNames + COPYSTR(NamesSmall, SpaceCount, 1);
                        END;

                    END;
                END;
            END;
            UNTIL ((SpaceCount = Strlegnth))
        END;
        CLEAR(NewName);
        NewName := FirsName + ',' + OtherNames;
    end;
}

