report 85527 "Class Splits Reports"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/acaClassSplits.rdl';

    
    dataset
    {
        dataitem(splits; "ACA-Student Units")
        {
            column(AcademicYear_splits; "Academic Year")
            {
            }
            column(StudentNo_splits; "Student No.")
            {
            }
            column(StudentName_splits; "Student Name")
            {
            }
            column(Stream_splits; Stream)
            {
            }
            column(CampusCode_splits; "Campus Code")
            {
            }
            column(Stage_splits; Stage)
            {
            }
            column(Programme;Programme)
            {

            }
            column(Unit;Unit)
            {

            }
            column(Unit_Description;"Unit Description")
            {
                
            }
           
        }
    }
    
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    
                }
            }
        }
    
        actions
        {
            
        }
    }
    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;
    
    var
        myInt: Integer;
        CompanyInformation: Record 79;
}