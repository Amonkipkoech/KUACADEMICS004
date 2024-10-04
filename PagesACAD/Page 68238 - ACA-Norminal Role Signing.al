page 68238 "ACA-Norminal Role Signing"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 61532;

    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = '&View Filters';
                field(AcadYear; AcadYear)
                {
                    Caption = 'Academic Year';
                    TableRelation = "ACA-Academic Year".Code;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        applyFilters();
                    end;
                }
                field(semester; semesterz1)
                {
                    Caption = 'Semester Filter';
                    TableRelation = "ACA-Semesters".Code;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF AcadYear = '' THEN ERROR('Specify the Academic Year First!');
                        applyFilters();
                    end;
                }
            }
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programmes)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Sem; Rec.Semester)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Billed"; Rec."Total Billed")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Time Student"; Rec."First Time Student")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF ((AcadYear = '') OR (semesterz1 = '')) THEN ERROR('Please specify the Academic Year and the Semester!');
                    end;
                }
                field("Fee Structure Exists"; Rec."Fee Structure Exists")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*acadYearTable.RESET;
        acadYearTable.SETRANGE(acadYearTable.Current,TRUE);
        IF acadYearTable.FIND('-') THEN
        AcadYear:=acadYearTable.Code;

       SemTable.RESET;
       SemTable.SETRANGE(SemTable."Current Semester",TRUE);
       IF SemTable.FIND('-') THEN
       semesterz1:=SemTable.Code;
             */
        //IF ((AcadYear='') OR (semesterz1='')) THEN ERROR('The Academic Year and Semester setups are not done.')

    end;

    var
        AcadYear: Code[20];
        semesterz1: Code[20];
        acadYearTable: Record 61382;


    procedure applyFilters()
    begin
        Rec.SETFILTER("Academic Year", AcadYear);
        Rec.SETFILTER(Semester, semesterz1);
        CurrPage.UPDATE;
    end;
}

