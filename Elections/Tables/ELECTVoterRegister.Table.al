table 60002 "ELECT-Voter Register"
{
    DrillDownPageID = 60021;
    LookupPageID = 60021;

    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Voter Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Individual,Delegetes';
            OptionMembers = Individual,Delegetes;
        }
        field(3; "Voter No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(4; "Voter Names"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Voter Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Voter Verified"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD("Polling Center Code");
                TESTFIELD("Electral District");
            end;
        }
        field(7; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Campus Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "School Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Electral District"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "ELECT-Electoral Districts"."Electral District Doce" WHERE("Election Code" = FIELD("Election Code"));

            trigger OnValidate()
            begin
                IF "Electral District" <> '' THEN "Polling Center Code" := '';
                IF "Electral District" = '' THEN BEGIN
                    Eligible := FALSE;
                    "Manual Eligibility to Contest" := FALSE;
                END;
            end;
        }
        field(11; Eligible; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Polling Center Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Electral District" = FILTER(<> '')) "ELECT-Polling Centers"."Polling Center Code" WHERE("Election Code" = FIELD("Election Code"),
                                                                                                                     "Electral District" = FIELD("Electral District"))
            ELSE
            IF ("Electral District" = FILTER('')) "ELECT-Polling Centers"."Polling Center Code" WHERE("Election Code" = FIELD("Election Code"));

            trigger OnValidate()
            begin
                IF "Polling Center Code" = '' THEN BEGIN
                    Eligible := FALSE;
                    "Manual Eligibility to Contest" := FALSE;
                END ELSE BEGIN
                    CLEAR(BilledAmount);
                    Customer.RESET;
                    Customer.SETRANGE("No.", "Voter No.");
                    IF Customer.FIND('-') THEN BEGIN
                        Customer.CALCFIELDS(Balance);
                        "Voter Names" := Customer.Name;
                        "Voter Balance" := Customer.Balance;
                        "Campus Code" := Customer."Global Dimension 1 Code";
                        BilledAmount := Customer.Balance;
                    END;
                    ACASemesters.RESET;
                    ACASemesters.SETRANGE("Current Semester", TRUE);
                    IF ACASemesters.FIND('-') THEN BEGIN

                    END;

                    ACACourseRegistration.RESET;
                    ACACourseRegistration.SETRANGE("Student No.", "Voter No.");
                    ACACourseRegistration.SETRANGE(Semester, ACASemesters.Code);
                    ACACourseRegistration.SETFILTER(Programmes, '<>%1', '');
                    IF ACACourseRegistration.FIND('+') THEN BEGIN
                        ACAProgramme.RESET;
                        ACAProgramme.SETRANGE(Code, ACACourseRegistration.Programmes);
                        IF ACAProgramme.FIND('-') THEN BEGIN
                            "Department Code" := ACAProgramme."Department Code";
                            "School Code" := ACAProgramme."School Code";

                        END ELSE
                            ERROR('Undefined programme');
                        ACACourseRegistration.CALCFIELDS("Total Billed");

                    END ELSE
                        ERROR('No Course Registration found');
                    ELECTElectionsHeader.RESET;
                    ELECTElectionsHeader.SETRANGE("Election Code", "Election Code");
                    IF ELECTElectionsHeader.FIND('-') THEN BEGIN
                        IF ELECTElectionsHeader."Voter Balance" <> 0 THEN BEGIN
                            IF ELECTElectionsHeader."Voter Balance Based on" = ELECTElectionsHeader."Voter Balance Based on"::Amounts THEN BEGIN
                                IF ELECTElectionsHeader."Voter Balance" < Customer.Balance THEN Eligible := FALSE ELSE Eligible := TRUE;
                            END ELSE BEGIN
                                IF ((ELECTElectionsHeader."Voter Balance" / 100) * ACACourseRegistration."Total Billed") < Customer.Balance THEN
                                    Eligible := FALSE ELSE
                                    Eligible := TRUE;
                            END;
                        END ELSE BEGIN
                            Eligible := TRUE;
                        END;
                    END;

                    IF Eligible = TRUE THEN "Manual Eligibility to Contest" := TRUE ELSE "Manual Eligibility to Contest" := FALSE;
                END;
            end;
        }
        field(13; Voted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Ballot ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Manual Eligibility to Contest"; Boolean)
        {
            Caption = 'Cleared to Vie';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Manual Eligibility to Contest" = TRUE THEN BEGIN
                    IF Eligible = FALSE THEN ERROR('Not a qualified candicate');
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Voter No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Customer: Record 18;
        ACACourseRegistration: Record 61532;
        ACAProgramme: Record 61511;
        ELECTElectionsHeader: Record 60000;
        ACASemesters: Record 61692;
        BilledAmount: Decimal;
}

