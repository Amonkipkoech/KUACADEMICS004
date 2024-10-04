page 61626 "Course Outline Contents"
{
    PageType = List;
    SourceTable = "ACA-Unit Course Outline";
    DeleteAllowed = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme Code field.';
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                    Editable = false;
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stage Code field.';
                    Editable = false;
                }
                field("Unit Base Code"; Rec."Unit Base Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Base Code field.';
                    Editable = false;
                }
                field(Stream; Rec.Stream)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stream field.';
                }
                field("Unit Base Title"; Rec."Unit Base Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Base Title field.';
                }
                field("Course Outline"; Rec."Course Outline")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Outline field.';
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Description field.';
                }
                field("Lecture Staff ID"; Rec."Lecture Staff ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecture Staff ID field.';
                }
                field("Consultation Hours"; Rec."Consultation Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consultation Hours field.';
                }
                field("Pre-Requisites"; Rec."Pre-Requisites")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pre-Requisites field.';
                }
                field("Learning Outcomes"; Rec."Learning Outcomes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Learning Outcomes field.';
                }
                field("Course Topic"; Rec."Course Topic")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Topic field.';
                }
                field("Recommended Texts"; Rec."Recommended Texts")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recommended Texts field.';
                }
                field("Other Remarks"; Rec."Other Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other Remarks field.';
                }
            }
        }
    }

}