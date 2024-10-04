page 52048 "ACA-Exam Grading Sources"
{
    PageType = List;
    SourceTable = "ACA-Exam Grading Source";
    //DeleteAllowed = false;
    //InsertAllowed = false;
    // ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field("Exam Catregory"; Rec."Exam Catregory")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exam Catregory field.';
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Score field.';
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field(Pass; Rec.Pass)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pass field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Results Exists Status"; Rec."Results Exists Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Results Exists Status field.';
                }
                field(CatMarksExist; Rec.CatMarksExist)
                {
                    ApplicationArea = All;
                }
                field(ExamMarksExist; Rec.ExamMarksExist)
                {
                    ApplicationArea = All;
                }
                field("Consolidated Prefix"; Rec."Consolidated Prefix")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consolidated Prefix field.';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import")
            {
                ApplicationArea = All;
                image = ImportCodes;
                RunObject = xmlport "Grading Source Import";
            }
        }
    }
    trigger OnOpenPage()
    begin
        if ((UserId <> 'APPKINGS') or (UserId <> 'Frankie')) then
            CurrPage.Close();
    end;

}