table 60000 "ELECT-Elections Header"
{
    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters".Code;
        }
        field(3; "Election Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Election Approach"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Many Candidates 1 Position,Delegates Election (Many Candidates many Positions),One candidate One Position (Ratification),Yes or No Poll,Referendum,Survey e.g. Likert Rating,Normination (Collection of Names for Nominees running for a Post)';
            OptionMembers = "Many Candidates 1 Position","Delegates Election (Many Candidates many Positions)","One candidate One Position (Ratification)","Yes or No Poll",Referendum,"Survey e.g. Likert Rating","Normination (Collection of Names for Nominees running for a Post)";
        }
        field(5; "Voting Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Plurality,Cummulation,Preffered,Scored,Approval,Nomination';
            OptionMembers = Plurality,Cummulation,Preffered,Scored,Approval,Nomination;
        }
        field(6; "Voter Choice"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Candidate,Option';
            OptionMembers = Candidate,Option;
        }
        field(7; "Allow Abstain"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Abstain Candidate"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Election Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'One Person one Vote,Delegate System';
            OptionMembers = "One Person one Vote","Delegate System";
        }
        field(10; "Notification Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Emails,SMS,Portal,Mail and SMS and Portal';
            OptionMembers = Emails,SMS,Portal,"Mail and SMS and Portal";
        }
        field(11; "Notice template"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Active Students only"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Candidate Balance Based on"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Amounts,Percentage';
            OptionMembers = Amounts,Percentage;
        }
        field(14; "Candicate Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Voter Balance Based on"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Amounts,Percentage';
            OptionMembers = Amounts,Percentage;
        }
        field(16; "Voter Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Voter Registration Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Automated  Registration,Self Registration,Admin Registration';
            OptionMembers = "Automated  Registration","Self Registration","Admin Registration";
        }
        field(18; "Voter Registration Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Voter Registration End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Ballot Tested"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Ballot Tested" <> FALSE THEN BEGIN
                    "Ballot Tested By" := USERID;
                    "Ballot tested Date" := TODAY;
                    "Ballot Tested Time" := TIME;
                END ELSE BEGIN
                    "Ballot Tested By" := '';
                    "Ballot tested Date" := 0D;
                    "Ballot Tested Time" := 0T;
                END;
            end;
        }
        field(21; "Voter List Confirmed"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Voter List Confirmed" = FALSE THEN BEGIN
                    "Voter List Confirmation Marked" := '';
                    "Voter List Confirmed Date" := 0D;
                    "Voter list Confirmed Time" := 0T;
                END ELSE BEGIN
                    "Voter List Confirmation Marked" := USERID;
                    "Voter List Confirmed Date" := TODAY;
                    "Voter list Confirmed Time" := TIME;
                END;
            end;
        }
        field(22; "Election Dates Verified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Ballot Tested By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Ballot tested Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Ballot Tested Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Voter List Confirmation Marked"; Code[20])
        {
            Caption = 'Voter List Confirmation Marked By';
            DataClassification = ToBeClassified;
        }
        field(27; "Voter list Confirmed Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Voter List Confirmed Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Registered Voters"; Integer)
        {
            CalcFormula = Count("ELECT-Voter Register" WHERE("Election Code" = FIELD("Election Code")));
            FieldClass = FlowField;
        }
        field(30; "Eligible Voters"; Integer)
        {
            CalcFormula = Count("ELECT-Voter Register" WHERE("Election Code" = FIELD("Election Code"),
                                                              Eligible = FILTER(true)));
            FieldClass = FlowField;
        }
        field(31; "Verified Voters"; Integer)
        {
            CalcFormula = Count("ELECT-Voter Register" WHERE("Election Code" = FIELD("Election Code")));
            FieldClass = FlowField;
        }
        field(32; "Total Voted"; Integer)
        {
            CalcFormula = Count("ELECT-Voter Register" WHERE("Election Code" = FIELD("Election Code"),
                                                              Eligible = FILTER(true),
                                                              Voted = FILTER(true)));
            FieldClass = FlowField;
        }
        field(33; "Did not Vote"; Integer)
        {
            CalcFormula = Count("ELECT-Voter Register" WHERE("Election Code" = FIELD("Election Code"),
                                                              Eligible = FILTER(true),
                                                              Voted = FILTER(false)));
            FieldClass = FlowField;
        }
        field(34; "Candidature Application Start"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Candidature Application End"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Candidate Registration Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Applications,Norminations,Items/Questions';
            OptionMembers = Applications,Norminations,"Items/Questions";
        }
        field(37; "Delegates Election"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Delegate Elections Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Get Candidates from Delegates"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Applications Allowed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Voting Allowed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Election Date"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(43; "Ballot ID Numbers"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(44; "Is Active"; Boolean)
        {
            CalcFormula = Exist("ELECT-Elections Setup" WHERE("Current Election" = FIELD("Election Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Election Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

