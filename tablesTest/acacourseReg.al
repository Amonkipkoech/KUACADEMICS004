page 86615 CourseReg
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ACA-Course Registration";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Reg. Transacton ID";"Reg. Transacton ID")
                {
                    ApplicationArea = All;
                    
                }
                field("Student No.";Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year";Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester;Rec.Semester)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}