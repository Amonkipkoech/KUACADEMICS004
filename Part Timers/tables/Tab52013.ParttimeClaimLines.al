table 52013 "Parttime Claim Lines"
{
    LookupPageId = "Parttime Claim Lines";
    DrillDownPageId = "Parttime Claim Lines";
    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Document No."; Code[20])
        {
            NotBlank = true;
        }
        field(4; "Semester"; code[30])
        {

        }
        field(5; "Academic Year"; code[30])
        {

        }
        field(6; Unit; code[30])
        {
            TableRelation = "ACA-Lecturers Units".Unit where(Lecturer = field("Lecture No."), Semester = field(Semester),
            Programme = field(Programme));

            trigger OnValidate()
            var
                lecunits: Record "ACA-Lecturers Units";
                pplines: Record "Parttime Claim Lines";
            begin
                TestField(Programme);
                pplines.Reset();
                pplines.SetRange("Lecture No.", rec."Lecture No.");
                pplines.SetRange(Semester, Rec.Semester);
                pplines.SetRange("Academic Year", Rec."Academic Year");
                pplines.SetRange(Unit, Rec.Unit);
                if pplines.Find('-') then Error('A unit is only paid once irregardless of number classes offered');
                lecunits.Reset();
                lecunits.SetRange(Semester, Semester);
                lecunits.SetRange(Programme, Programme);
                lecunits.SetRange(Unit, Unit);
                if lecunits.Find('-') then begin
                    lecunits.CalcFields("Unit Students Count", "Registered Students");
                    "Unit Description" := lecunits.Description;
                    Stage := lecunits.Stage;
                    "Student Count" := lecunits."Registered Students";
                    if "Invigillation Done" = false then begin
                        if ("Programme Category" = "Programme Category"::Postgraduate) then begin
                            if "Exam Category" = 'PHD' then begin
                                if lecunits."Registered Students" < 10 then begin
                                    "Hourly Rate" := 1200;
                                    "Hours Done" := 42;
                                    Amount := (1200 * 42) * (lecunits."Registered Students" / 10);
                                end else begin
                                    "Hourly Rate" := 1200;
                                    "Hours Done" := 42;
                                    Amount := 1200 * 42;
                                end;
                            end else begin
                                if lecunits."Registered Students" < 10 then begin
                                    "Hourly Rate" := 1200;
                                    "Hours Done" := 42;
                                    Amount := (1200 * 42) * (lecunits."Registered Students" / 10);
                                end else begin
                                    "Hourly Rate" := 1200;
                                    "Hours Done" := 42;
                                    Amount := 1200 * 42;
                                end;
                            end;
                        end
                        else
                            if "Programme Category" = "Programme Category"::Undergraduate then begin
                                if lecunits."Registered Students" < 25 then begin
                                    "Hourly Rate" := 1000;
                                    "Hours Done" := 42;
                                    Amount := 42000 * (lecunits."Registered Students" / 25);
                                end else begin
                                    "Hourly Rate" := 1000;
                                    "Hours Done" := 42;
                                    Amount := 42000;
                                end;

                            end
                            else begin
                                if lecunits."Registered Students" < 25 then begin
                                    "Hourly Rate" := 700;
                                    "Hours Done" := 42;
                                    Amount := (42 * 700) * (lecunits."Registered Students" / 25);
                                end else begin
                                    "Hourly Rate" := 700;
                                    "Hours Done" := 42;
                                    Amount := 42 * 700;

                                end;

                            end;

                    end else begin

                        if ("Programme Category" = "Programme Category"::Postgraduate) then begin
                            if "Exam Category" = 'PHD' then begin
                                if lecunits."Registered Students" < 10 then begin
                                    "Hourly Rate" := 1200;
                                    "Hours Done" := 42;
                                    Amount := (1200 * 42) * (lecunits."Registered Students" / 10) + 30000;
                                end else begin
                                    "Hourly Rate" := 1200;
                                    "Hours Done" := 42;
                                    Amount := 1200 * 42 + 30000;
                                end;

                            end else begin
                                if lecunits."Registered Students" < 10 then begin
                                    "Hourly Rate" := 1200;
                                    "Hours Done" := 42;
                                    Amount := (1200 * 42) * (lecunits."Registered Students" / 10) + 20000;
                                end else begin
                                    "Hourly Rate" := 1200;
                                    "Hours Done" := 42;
                                    Amount := 1200 * 42 + 20000;
                                end;

                            end;
                        end
                        else
                            if "Programme Category" = "Programme Category"::Undergraduate then begin
                                if lecunits."Registered Students" < 25 then begin
                                    "Hourly Rate" := 1000;
                                    "Hours Done" := 42;
                                    Amount := 45000 * (lecunits."Registered Students" / 25);
                                end else begin
                                    "Hourly Rate" := 1000;
                                    "Hours Done" := 42;
                                    Amount := 45000;
                                end;

                            end
                            else begin
                                if lecunits."Registered Students" < 25 then begin
                                    "Hourly Rate" := 700;
                                    "Hours Done" := 42;
                                    Amount := (42 * 700) * (lecunits."Registered Students" / 25);
                                end else begin
                                    "Hourly Rate" := 700;
                                    "Hours Done" := 42;
                                    Amount := 42 * 700;

                                end;

                            end;
                    end;
                end;

            end;
        }
        field(7; "Unit Description"; Text[150])
        {

        }
        field(8; "Programme"; code[30])
        {
            TableRelation = "ACA-Programme"."Code";

            trigger OnValidate()
            var
                acaprog: Record "ACA-Programme";
            begin
                acaprog.Reset();
                acaprog.SetRange(Code, Programme);
                if acaprog.Find('-') then begin
                    "Programme Description" := acaprog.Description;
                    "Programme Category" := acaprog.Category;
                    "Exam Category" := acaprog."Exam Category";
                end;


            end;
        }
        field(9; "Programme Description"; Text[100])
        {
        }
        field(11; "Hours Done"; Decimal)
        {
        }
        field(12; "Hourly Rate"; Decimal)
        {

        }
        field(13; "Lecture No."; code[30])
        {

        }
        field(14; Stage; code[30])
        {

        }
        field(15; Amount; Decimal)
        {
        }
        field(16; "Invigillation Done"; Boolean)
        {
            trigger OnValidate()
            begin
                if "Invigillation Done" = true then begin
                    "Invigillation Hours" := 3;
                    Validate(Unit);
                end else begin
                    "Invigillation Hours" := 0;
                    Validate(Unit);
                end;
            end;

        }
        field(17; "Invigillation Hours"; Decimal)
        {

        }
        field(18; "Programme Category"; Option)
        {
            OptionMembers = ,Certificate,Diploma,Undergraduate,Postgraduate,Professional,"Course List";
        }
        field(19; "Exam Category"; code[30])
        {

        }
        field(20; "Student Count"; Integer)
        {

        }
    }

    keys
    {
        key(Key1; "Line No.", "Document No.", "Academic Year", Semester, "Lecture No.")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        parttimeheader.RESET;
        parttimeheader.SETRANGE(parttimeheader."No.", "Document No.");
        IF parttimeheader.FINDFIRST THEN BEGIN
            IF (parttimeheader.Status = parttimeheader.Status::Approved) OR
            (parttimeheader.Status = parttimeheader.Status::Posted) OR
            (parttimeheader.Status = parttimeheader.Status::"Pending Approval") THEN
                ERROR('You Cannot Delete this record its status is not Pending');
        END;
    end;

    trigger OnInsert()
    begin
        parttimeheader.RESET;
        parttimeheader.SETRANGE(parttimeheader."No.", "Document No.");
        IF parttimeheader.FINDFIRST THEN BEGIN
            //  parttimeheader.TESTFIELD("Responsibility Center");
            parttimeheader.TESTFIELD("Global Dimension 1 Code");
            parttimeheader.TESTFIELD("Global Dimension 2 Code");
        END;
    end;

    trigger OnModify()
    begin
        parttimeheader.RESET;
        parttimeheader.SETRANGE(parttimeheader."No.", "Document No.");
    end;

    var
        GLAcc: Record "G/L Account";
        Pay: Record "Parttime Claim Header";
        parttimeheader: Record "Parttime Claim Header";

}