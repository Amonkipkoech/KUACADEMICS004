page 40020 "XY form"
{
    Caption = 'XY form';
    PageType = List;
    CardPageId = "XY form Card";
    SourceTable = "ACA-XY-FORM";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Form Id"; Rec."Form Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Form Id field.', Comment = '%';
                }
                field(StudentNo; Rec.StudentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the StudentNo field.', Comment = '%';
                }
                field(UnitCode; Rec.UnitCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UnitCode field.', Comment = '%';
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Description field.', Comment = '%';
                }
                field(LecturerNo; Rec.LecturerNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LecturerNo field.', Comment = '%';
                }
                field("Lecturer Name"; Rec."Lecturer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecturer Name field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration field.', Comment = '%';
                }
                field(ClassRep; Rec.ClassRep)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ClassRep field.', Comment = '%';
                }
                field(HoD; Rec.HoD)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HoD field.', Comment = '%';
                }
                field("Hod Name"; Rec."Hod Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hod Name field.', Comment = '%';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }
                field(Coverage; Rec.Coverage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Coverage field.', Comment = '%';
                }
                field(AcademicYr; Rec.AcademicYr)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic year field.', Comment = '%';
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme field.', Comment = '%';
                }
            }
        }
    }
}
