report 66616 "Update Student Names"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Update Student Names.rdl';

    dataset
    {
        dataitem(DataItem1; 18)
        {
            DataItemTableView = WHERE("Customer Posting Group" = FILTER('STUDENT'));

            trigger OnAfterGetRecord()
            begin
                CLEAR(NamesSmall);
                CLEAR(FirsName);
                CLEAR(SpaceCount);
                CLEAR(SpaceFound);
                CLEAR(OtherNames);
                IF STRLEN(Customer.Name) > 100 THEN Customer.Name := COPYSTR(Customer.Name, 1, 100);
                Customer.MODIFY;
                Strlegnth := STRLEN(Customer.Name);
                IF STRLEN(Customer.Name) > 4 THEN BEGIN
                    NamesSmall := LOWERCASE(Customer.Name);
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

                //MESSAGE(FirsName+','+OtherNames);
                Customer.Name := FirsName + ',' + OtherNames;
                Customer.MODIFY;
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
        customer: Record 18;
        NamesSmall: Text[250];
        FirsName: Text[250];
        SpaceCount: Integer;
        SpaceFound: Boolean;
        Counts: Integer;
        Strlegnth: Integer;
        OtherNames: Text[250];
}

