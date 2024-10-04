report 51054 "ACA-Update Academic Year"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/UPdateAcademicYr.rdl';

    
    dataset
    {
        dataitem(results; "ACA-Exam Results")
        {
            
            column(AcademicYear_DataItemName; "Academic Year")
            {
            }
            column(AdmissionNo_DataItemName; "Admission No")
            {
            }
            column(Score_DataItemName; Score)
            {
            }
            trigger OnAfterGetRecord()
            begin
                results2.Reset();
                results2.SetRange(Semester, results.Semester);
                if results2.Find('-') then begin
                    repeat
                    acadYr.Reset();
                    acadYr.SetRange(code, results2.Semester);
                    if acadYr.Find('-') then begin
                        if results2."Academic Year" = '' then begin
                            results2."Academic Year" := acadYr."Academic Year";
                            results2.Modify();
                        end
                    end;
                until results2.Next() = 0;

                end;

            end;
        }
    }
    
    requestpage
    {
        layout
        {
            
        }
    
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }
    
    

    var
        acadYr: Record "ACA-Semester";
        results2: Record "ACA-Exam Results";
}