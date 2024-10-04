report 63905 "CUE Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/CUE Report.rdl';

    dataset
    {
        dataitem(DataItem1000000000; 18)
        {
            DataItemTableView = WHERE("Customer Posting Group" = FILTER('STUDENT'));
            RequestFilterFields = "No.";
            column(IDNo; "ID No")
            {
            }
            column(No; "No.")
            {
            }
            column(Names; Name)
            {
            }
            column(FirstNames; Fnames)
            {
            }
            column(MiddleNames; MNames)
            {
            }
            column(LastNames; LNames)
            {
            }
            column(Addr; Address)
            {
            }
            column(Addre2; "Address 2")
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(Gender; Gender)
            {
            }
            column(DoB; "Date Of Birth")
            {
            }
            column(YoS; StudyYear)
            {
            }
            column(Country; "Country/Region Code")
            {
            }
            column(County; County)
            {
            }
            column(Tribe; Tribe)
            {
            }

            column(ProGCode; Coregs.Programmes)
            {
            }
            column(AdmissionDate; Coregs2."Registration Date")
            {
            }
            column(Campus; "Global Dimension 1 Code")
            {
            }
            column(seq; seq)
            {
            }

            trigger OnAfterGetRecord()
            var
                NoOfSpaces: Integer;
                FullStringLegnth: Integer;
                FirstName: Text[150];
                MiddleName: Text[150];
                LastName: Text[150];
                LoopCounts: Integer;
                FirstSpacePos: Integer;
                SecondSpacePos: Integer;
                incrementChar: Integer;
            begin
                CLEAR(Fnames);
                CLEAR(MNames);
                CLEAR(LNames);
                CLEAR(SecondSpacePos);
                CLEAR(FirstSpacePos);
                IF Name <> '' THEN BEGIN
                    //  Fnames:=ReturnName(Name,RetVals::FirstName);
                    //  MNames:=ReturnName(Name,RetVals::MiddleName);
                    //  LNames:=ReturnName(Name,RetVals::LastName);
                    CLEAR(FirstName);
                    CLEAR(MiddleName);
                    CLEAR(LastName);
                    CLEAR(LoopCounts);
                    CLEAR(NoOfSpaces);
                    LoopCounts := 1;
                    REPEAT
                    BEGIN
                        CLEAR(incrementChar);
                        CLEAR(StringChar);
                        StringChar := COPYSTR(Name, LoopCounts, 1);
                        IF (StringChar = ' ') THEN BEGIN
                            incrementChar := 0;
                            NoOfSpaces := NoOfSpaces + 1;
                            IF NoOfSpaces = 1 THEN FirstSpacePos := LoopCounts;
                            IF NoOfSpaces = 2 THEN SecondSpacePos := LoopCounts;
                            IF (COPYSTR(Name, (LoopCounts + 1), 1) = '') THEN incrementChar := 1;
                            IF (COPYSTR(Name, (LoopCounts + 2), 1) = '') THEN incrementChar := 2;
                            IF (COPYSTR(Name, (LoopCounts + 3), 1) = '') THEN incrementChar := 3;
                            LoopCounts := LoopCounts + incrementChar;

                        END;
                        LoopCounts := LoopCounts + 1;
                    END;
                    UNTIL ((LoopCounts = (STRLEN(Name))) OR (NoOfSpaces = 2) OR (LoopCounts > (STRLEN(Name))));
                    IF (FirstSpacePos < STRLEN(Name)) THEN
                        FirstName := COPYSTR(Name, 1, FirstSpacePos)
                    ELSE
                        FirstName := Name;

                    IF SecondSpacePos <> 0 THEN
                        IF FirstSpacePos <> 0 THEN
                            MiddleName := COPYSTR(Name, FirstSpacePos, SecondSpacePos - FirstSpacePos);

                    IF SecondSpacePos = 0 THEN BEGIN
                        IF (STRLEN(Name) > FirstSpacePos + 1) THEN BEGIN
                            MiddleName := COPYSTR(Name, (FirstSpacePos + 1), ((STRLEN(Name) - FirstSpacePos) + 1));
                        END;
                    END;

                    IF (STRLEN(Name) - SecondSpacePos) > 0 THEN
                        IF SecondSpacePos <> 0 THEN
                            LastName := COPYSTR(Name, SecondSpacePos, ((STRLEN(Name) - SecondSpacePos) + 1));

                    Fnames := FirstName;

                    MNames := MiddleName;

                    LNames := LastName;
                END;
                Coregs.RESET;
                Coregs.SETRANGE("Student No.");
                //Coregs.SETRANGE(Reversed,false);
                IF Coregs.FIND('+') THEN;
                CLEAR(StudyYear);
                IF STRLEN(Coregs.Stage) > 1 THEN StudyYear := COPYSTR(Coregs.Stage, 2, 1);

                Coregs2.RESET;
                Coregs2.SETRANGE("Student No.", "No.");
                Coregs2.SETRANGE(Reversed, FALSE);
                IF Coregs2.FIND('-') THEN;
                seq := seq + 1;
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
        Fnames: Text[100];
        MNames: Text[100];
        LNames: Text[100];
        StringChar: Text[1];
        RetVals: Option FirstName,MiddleName,LastName;
        Coregs: Record 61532;
        Coregs2: Record 61532;
        StudyYear: Text;
        seq: Integer;

    local procedure ReturnName(FullNames: Text[250]; ReturnType: Option FirstName,MiddleName,LastName) NameReturned: Text[150]
    var
        NoOfSpaces: Integer;
        FullStringLegnth: Integer;
        FirstName: Text[150];
        MiddleName: Text[150];
        LastName: Text[150];
        LoopCounts: Integer;
        FirstSpacePos: Integer;
        SecondSpacePos: Integer;
        incrementChar: Integer;
    begin
        CLEAR(FirstName);
        CLEAR(NameReturned);
        CLEAR(MiddleName);
        CLEAR(LastName);
        CLEAR(LoopCounts);
        CLEAR(NoOfSpaces);
        LoopCounts := 1;
        REPEAT
        BEGIN
            CLEAR(incrementChar);
            CLEAR(StringChar);
            StringChar := COPYSTR(FullNames, LoopCounts, 1);
            IF (StringChar = ' ') THEN BEGIN
                incrementChar := 0;
                NoOfSpaces := NoOfSpaces + 1;
                IF NoOfSpaces = 1 THEN FirstSpacePos := LoopCounts;
                IF NoOfSpaces = 2 THEN SecondSpacePos := LoopCounts;
                IF (COPYSTR(FullNames, (LoopCounts + 1), 1) = '') THEN incrementChar := 1;
                IF (COPYSTR(FullNames, (LoopCounts + 2), 1) = '') THEN incrementChar := 2;
                IF (COPYSTR(FullNames, (LoopCounts + 3), 1) = '') THEN incrementChar := 3;
                LoopCounts := LoopCounts + incrementChar;

            END;
            LoopCounts := LoopCounts + 1;
        END;
        UNTIL ((LoopCounts = (STRLEN(FullNames))) OR (NoOfSpaces = 2) OR (LoopCounts > (STRLEN(FullNames))));
        IF (FirstSpacePos < STRLEN(FullNames)) THEN
            FirstName := COPYSTR(FullNames, 1, FirstSpacePos)
        ELSE
            FirstName := FullNames;

        IF SecondSpacePos <> 0 THEN
            IF FirstSpacePos <> 0 THEN
                MiddleName := COPYSTR(FullNames, FirstSpacePos, SecondSpacePos - FirstSpacePos);

        IF SecondSpacePos = 0 THEN BEGIN
            IF (STRLEN(FullNames) > FirstSpacePos + 1) THEN BEGIN
                MiddleName := COPYSTR(FullNames, (FirstSpacePos + 1), ((STRLEN(FullNames) - FirstSpacePos) + 1));
            END;
        END;

        IF (STRLEN(FullNames) - SecondSpacePos) > 0 THEN
            IF SecondSpacePos <> 0 THEN
                LastName := COPYSTR(FullNames, SecondSpacePos, ((STRLEN(FullNames) - SecondSpacePos) + 1));
        IF ReturnType = ReturnType::FirstName THEN
            NameReturned := FirstName;
        IF ReturnType = ReturnType::MiddleName THEN
            NameReturned := MiddleName;
        IF ReturnType = ReturnType::LastName THEN
            NameReturned := LastName;
    end;
}

