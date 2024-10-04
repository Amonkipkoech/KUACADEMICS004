/* page 68424 "ACA-Stage Shortlist"
{
    PageType = ListPart;
    SourceTable = 61315;
    SourceTableView = SORTING("Stage Score")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Applicant; Applicant)
                {
                }
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field("ID No"; "ID No")
                {
                }
                field(Gender; Gender)
                {
                }
                field("Stage Score"; "Stage Score")
                {
                }
                field("Marital Status"; "Marital Status")
                {
                }
                field(Qualified; Qualified)
                {

                    trigger OnValidate()
                    begin
                        "Manual Change" := TRUE;
                        MODIFY;
                    end;
                }
                field("Manual Change"; "Manual Change")
                {
                }
                field(Position; Position)
                {
                }
                field(Employ; Employ)
                {
                }
                field("Reporting Date"; "Reporting Date")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        MyCount: Integer;

    procedure GetApplicantNo() AppicantNo: Code[20]
    begin
        AppicantNo := Applicant;
    end;
}
 */
