page 86609 "Test"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ACA-Exam Grading Source";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
               
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            
        }
    }
    
    var
        myInt: Integer;
}