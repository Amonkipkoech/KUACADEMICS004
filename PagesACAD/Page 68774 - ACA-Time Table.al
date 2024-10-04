page 68774 "ACA-Time Table"
{
    PageType = ListPlus;
    SourceTable = "ACA-Units/Subjects";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(CampusFilter; CampusFilter)
                {
                    Caption = 'Campus Filter';
                    ApplicationArea = All;
                }
                field(ProgFilter; ProgFilter)
                {
                    Caption = 'Programme Filter';
                    Lookup = true;
                    LookupPageID = "ACA-Programmes List";
                    TableRelation = "ACA-Programme".Code;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.SETFILTER("Programme Code", ProgFilter);
                    end;
                }
                field(StageFilter; StageFilter)
                {
                    Caption = 'Stage Filter';
                    Lookup = true;
                    TableRelation = "ACA-Programme Stages".Code;
                    ApplicationArea = All;
                }
                field(SemFilter; SemFilter)
                {
                    Caption = 'Semester Filter';
                    Lookup = true;
                    TableRelation = "ACA-Semester".Code;
                    ApplicationArea = All;
                }
                field(DayFilter; DayFilter)
                {
                    Caption = 'Day Filter';
                    Lookup = true;
                    TableRelation = "ACA-Day Of Week".Day;
                    ApplicationArea = All;
                }
                field(RoomFilter; RoomFilter)
                {
                    Caption = 'Room Filter';
                    TableRelation = "ACA-Lecture Rooms".Code;
                    ApplicationArea = All;
                }
                field(LecFilter; LecFilter)
                {
                    Caption = 'Lecturer Filter';
                    TableRelation = "HRM-Employee (D)"."No." WHERE(Lecturer = CONST(true));
                    ApplicationArea = All;
                }
            }
#pragma warning disable AL0269
            part(MatrixForm; "ACA-Time Table Header")
#pragma warning restore AL0269
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var

        ProgFilter: Code[20];
        StageFilter: Code[20];
        SemFilter: Code[20];
        DayFilter: Code[20];
        RoomFilter: Code[20];
        LecFilter: Code[20];
        CampusFilter: Code[20];
}

